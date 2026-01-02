# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Auto-Claude is a Bash-based CLI tool that runs Claude Code in a continuous loop with persistent context. It automates the full PR lifecycle: Claude makes changes → creates branch → opens PR → waits for CI checks → merges → repeats. The system maintains context across iterations via a shared markdown file (`SHARED_TASK_NOTES.md` by default).

**Key concept**: Instead of one-shot AI assistance, this enables long-running autonomous development where Claude can work on multi-step projects over time while you sleep or work on other things.

## Core Architecture

### Main Script: `auto_claude.sh`

The script orchestrates a loop that:
1. Creates a new git branch for each iteration
2. Runs Claude Code with an enhanced prompt (includes workflow context + user prompt + notes from previous iteration)
3. Claude makes changes and updates the shared notes file
4. Commits changes automatically via a nested Claude call
5. Pushes branch and creates PR via GitHub CLI
6. Waits for all CI checks and code reviews to pass (30min timeout)
7. Merges PR using specified strategy (squash/merge/rebase)
8. Pulls latest main and repeats

### Context Persistence

**`SHARED_TASK_NOTES.md`** (or custom file via `--notes-file`):
- External memory shared across iterations
- Claude reads it at start of each iteration and updates it at the end
- Enables "relay race" handoffs between runs
- Should be concise, actionable notes (not verbose logs or reports)

**Enhanced Prompt Structure**:
```
## CONTINUOUS WORKFLOW CONTEXT
[Instructions about iterative work + completion signal]

## PRIMARY GOAL
[User's original prompt]

## CONTEXT FROM PREVIOUS ITERATION
[Contents of SHARED_TASK_NOTES.md if it exists]

## ITERATION NOTES
[Instructions to update the notes file]
```

### Execution Limits

The loop can be bounded by three independent constraints:
- `--max-runs N`: Stop after N successful iterations (0 = infinite)
- `--max-cost X.XX`: Stop when total cost reaches $X.XX USD
- `--max-duration Xh/Xm/Xs`: Stop after time duration (e.g., `2h`, `30m`, `1h30m`)

Whichever limit is reached first will stop the loop.

### Error Handling

- **3 consecutive errors = fatal exit**: Prevents infinite error loops
- **Failed CI checks**: PR is closed, branch deleted, iteration fails (but counted toward error threshold)
- **Successful iteration**: Resets error counter, decrements extra iterations
- **Extra iterations**: Added for each error to compensate for failed attempts

### Completion Signals

If multiple agents independently determine the entire project is complete (not just their current task), they output the completion signal (default: `AUTO_CLAUDE_PROJECT_COMPLETE`). When `--completion-threshold N` consecutive iterations emit the signal, the loop stops early.

### Git Worktrees (Parallel Execution)

`--worktree <name>` creates/uses a git worktree in `../auto-claude-worktrees/<name>/` allowing multiple instances to run simultaneously on different tasks without conflicts. Each worktree:
- Pulls latest from main on startup
- Works in isolation
- Can be cleaned up with `--cleanup-worktree`

## Development Commands

### Running Tests

```bash
# Run BATS test suite
./tests/libs/bats/bin/bats tests/test_auto_claude.bats

# Setup test dependencies (installs BATS and libraries)
./tests/setup.sh
```

Tests use BATS (Bash Automated Testing System) with bats-support and bats-assert libraries.

### Installation

```bash
# Automated install (downloads to ~/.local/bin/auto-claude)
curl -fsSL https://raw.githubusercontent.com/iKislay/auto-claude/main/install.sh | bash

# Manual install
chmod +x auto_claude.sh
sudo mv auto_claude.sh /usr/local/bin/auto-claude
```

### Common Usage Patterns

```bash
# Basic: 5 iterations with auto-detected GitHub repo
auto-claude -p "add unit tests" -m 5

# Budget-limited: stop at $10 spent
auto-claude -p "improve code quality" --max-cost 10.00

# Time-boxed: run for 2 hours
auto-claude -p "refactor module" --max-duration 2h

# Infinite loop until manually stopped
auto-claude -p "increase test coverage" -m 0

# Parallel execution in different worktrees
auto-claude -p "Add unit tests" -m 5 --worktree tests
auto-claude -p "Add docs" -m 5 --worktree docs  # Run in another terminal

# Testing without creating PRs
auto-claude -p "test changes" -m 2 --disable-commits --dry-run

# Custom completion threshold
auto-claude -p "fix all bugs" -m 20 --completion-threshold 3

# Forward flags to Claude Code
auto-claude -p "task" -m 3 --allowedTools "Write,Read" --model claude-haiku-4-5
```

## Key Functions

### Main Loop (`main_loop` at line 1616)
- Controls iteration flow based on limits (runs/cost/duration)
- Calls `execute_single_iteration` for each run
- Checks for completion signals

### Single Iteration (`execute_single_iteration` at line 1530)
1. Creates branch via `create_iteration_branch`
2. Builds enhanced prompt with context from `SHARED_TASK_NOTES.md`
3. Runs Claude via `run_claude_iteration`
4. Parses JSON result via `parse_claude_result`
5. Handles success/error via `handle_iteration_success`/`handle_iteration_error`

### PR Workflow (`auto_claude_commit` around line 1050-1194)
1. Checks for git changes
2. Uses nested Claude call to generate commit message (`PROMPT_COMMIT_MESSAGE`)
3. Pushes branch
4. Creates PR with commit title/body
5. Calls `wait_for_pr_checks` (30min timeout, polls every 10s)
6. Calls `merge_pr_and_cleanup` if checks pass

### Check Waiting (`wait_for_pr_checks` at line 771)
- Polls `gh pr checks` every 10 seconds
- Tracks: pending/success/failed check counts + review status
- Only logs when state changes (avoids spam)
- Requires all checks to pass + reviews approved (or no review requested)
- Returns success (0) if all pass, failure (1) if checks fail or timeout

## Important Behavioral Details

### Commit Message Generation
Claude is called with `--allowedTools "Bash(git)"` and prompted to:
1. Review all uncommitted changes
2. Look at recent commits for style consistency
3. Generate commit message: one-line summary + blank lines + detailed explanation
4. Run `git add .` to stage everything including untracked files
5. Commit with the message (no footers like "Generated with Claude Code")

### GitHub Repository Detection
If `--owner` and `--repo` are not provided, the script attempts to auto-detect from `git remote get-url origin`:
- Supports HTTPS: `https://github.com/owner/repo.git`
- Supports SSH: `git@github.com:owner/repo.git`

### Update Mechanism
- On startup, checks GitHub releases via `gh` CLI for newer version
- Prompts user to update (60s timeout)
- `auto-claude update` command to manually check/install updates
- Self-replacing: downloads new version, `exec`s with original args

## Testing Notes

The script sets `TESTING="true"` environment variable to prevent execution during test sourcing. Tests validate:
- Bash syntax
- Function exports (show_help, show_version, parse_arguments)
- Argument parsing
- Flag handling (dry-run, worktree, completion signals, etc.)

## GitHub Actions CI

`.github/workflows/test.yml`:
- Runs on PRs to main
- Installs BATS via `tests/setup.sh`
- Executes test suite

`.github/workflows/release.yml`:
- Handles releases and version tagging

## Dependencies

- **Claude Code CLI** (`claude`): The AI pair programmer being orchestrated
- **GitHub CLI** (`gh`): For PR creation, status checks, merging
- **jq**: JSON parsing (Claude outputs JSON with `--output-format json`)
- **Git**: Repository must be a git repo (unless `--disable-commits`)

## Notes for Future Development

- The script uses `--dangerously-skip-permissions` and `--output-format json` when calling Claude
- All user-facing output goes to stderr (`>&2`) so stdout can capture JSON from Claude
- Branch names follow pattern: `{prefix}iteration-{num}/{date}-{random}` (default prefix: `auto-claude/`)
- Error logs stored in temp file (`ERROR_LOG=$(mktemp)`) and cleaned up on exit
- Duration parsing supports: `2h`, `30m`, `1h30m`, `90s` (case-insensitive)
- Version comparison handles semantic versioning (e.g., `v0.9.1` vs `v0.10.0`)
