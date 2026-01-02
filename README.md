<h1><img width="512" height="294" alt="Auto-Claude" src="https://github.com/user-attachments/assets/26878379-6cff-4803-a50d-c1e3f9455f55" /></h1>

<p align="center">
  <a href="https://kislay.is-a.dev">Website</a> •
  <a href="https://twitter.com/whykislay">Twitter</a> •
  <a href="https://www.linkedin.com/in/kislayy/">LinkedIn</a> •
  <a href="https://syncally.app">Syncally</a>
</p>

<details data-embed="kislay.is-a.dev" data-title="Auto-Claude" data-summary="Your AI teammate that works overnight, handling the tedious stuff while you sleep">
  <summary>Transform Claude Code into a tireless development partner that autonomously tackles multi-day projects through an intelligent loop of code → PR → CI → merge → repeat.</summary>

## The Problem: AI Coding Tools Stop Too Soon

Picture this: You're working with Claude Code on a massive refactoring project. Claude makes some brilliant changes, you review them, merge, and then... silence. To continue, you need to craft another prompt, provide context again, and manually shepherd each change through your workflow. It's like having a brilliant intern who can only focus for 5 minutes at a time.

Most AI coding assistants operate in single-shot mode—they complete one task and halt, waiting for your next instruction. This creates friction for anything beyond trivial changes. Want to add tests to your entire codebase? That's dozens of manual iterations. Need to refactor a legacy module? Prepare for a week of babysitting.

## The Insight: What If AI Could Iterate Like Humans?

Real developers don't work in isolated bursts. We iterate, learn from failures, and build on previous work. We create PRs, wait for CI, read error messages, fix issues, and repeat. The breakthrough? Teaching Claude to do the same.

Auto-Claude transforms Claude Code into a persistent development partner by wrapping it in an intelligent automation loop. Think of it as CI/CD, but instead of deploying code, you're deploying AI iterations. Each cycle, Claude:
- Makes focused changes on a fresh branch
- Creates a pull request with detailed context
- Patiently waits for CI checks (respecting your existing workflows)
- Learns from failures and tries different approaches
- Merges successful changes and moves to the next task

The magic happens in how Claude hands off knowledge between iterations. Just like developers use task lists and documentation, Claude maintains a shared markdown file—`SHARED_TASK_NOTES.md`—that evolves as the project progresses. This external memory prevents context drift and enables genuine multi-day projects.

## The Origin Story: A Saturday Experiment

It started with a joke. My friend [Namanyay](https://nmn.gl) (founder of Giga AI) saw my first prototype—literally just this:

```bash
while true; do
  claude --dangerously-skip-permissions "Increase test coverage [...] write notes for the next developer in TASKS.md"
  sleep 1
done
```

He called it "genius and hilarious." That sparked a weekend coding sprint. The elegant simplicity—a while loop—revealed something profound: persistence matters more than sophistication. By Sunday evening, the prototype had evolved into a production-ready orchestrator that integrates seamlessly with GitHub's PR workflow.

## How the Loop Works

Each iteration follows a carefully designed cycle:

1. **Branch Creation** → Claude works on a clean slate (`auto-claude/iteration-N/2026-01-02-abc123`)
2. **Focused Development** → Claude makes changes guided by your original prompt + learnings from previous attempts
3. **PR Generation** → Changes are committed and a pull request is automatically created
4. **CI/CD Integration** → The system waits for your existing checks (tests, linters, security scans) to complete
5. **Decision Point** → Pass? Merge and continue. Fail? Close the PR, document what went wrong, try a different approach
6. **Knowledge Transfer** → Update the shared notes with progress, blockers, and next steps
7. **Repeat** → Pull latest main, increment counter, loop back to step 1

The beauty lies in what happens during failures. When a PR fails CI, Claude doesn't just retry the same approach—it reads the error logs, updates its strategy in the notes file, and attempts a different solution. This creates a natural selection pressure toward working code.

## The Memory System: Notes as Neural Connections

Without guided prompting, Claude would fill the notes file with verbose logs that actually harm productivity. The critical instruction is framing each iteration as a relay race:

> *"You don't need to solve everything today. Make meaningful progress on ONE thing, document what you learned, and pass the baton to the next runner (who might be you, or a human, or another AI tomorrow)."*

In production, this creates fascinating emergence. I once prompted: *"increase test coverage."* By iteration 3, the notes evolved to:

```
Strategy: Running coverage report reveals auth.js (23%), payments.js (41%), and utils.js (67%) need attention.

Priority: auth.js first (most critical, least covered)

Blocker from previous iteration: Tried adding tests to `validateToken()` but hit edge case with expired tokens. Need to mock Date.now() in test setup.

Next: Fix Date mocking, then cover remaining auth.js functions
```

Claude taught itself to work systematically, prioritize by impact, and debug failed approaches—all without additional prompting.

## Real-World Applications

### The Dependabot Killer

Dependabot updates your dependencies. Auto-Claude updates them *and* fixes the breaking changes. Schedule it to run every morning:

```bash
auto-claude -p "Update all dependencies and fix breaking changes" --max-duration 2h
```

Wake up to a series of merged PRs, each updating one package with all tests passing.

### The Weekend Refactorer

Large refactoring tasks become automated marathons. Point Auto-Claude at legacy code:

```bash
auto-claude -p "Convert all callbacks to async/await, one file at a time" -m 50
```

Come back Monday to 20+ merged PRs, each modernizing a different module with full CI validation. The work happens incrementally, safely, and with complete audit trails.

### The Test Coverage Machine

Instead of manually grinding through untested files:

```bash
auto-claude -p "Increase test coverage to 80%" --max-cost 15.00 --completion-threshold 3
```

Auto-Claude systematically identifies gaps, adds tests, and stops when three consecutive iterations confirm the goal is met.

## Advanced Concepts

### Parallel Agents with Git Worktrees

Run multiple Auto-Claude instances simultaneously without conflicts. Each gets its own isolated workspace:

```bash
# Terminal 1: Testing specialist
auto-claude -p "Add integration tests" -m 10 --worktree testing

# Terminal 2: Documentation specialist
auto-claude -p "Document all public APIs" -m 10 --worktree docs

# Terminal 3: Performance optimizer
auto-claude -p "Profile and optimize slow endpoints" -m 5 --worktree perf
```

Like scheduling meetings with [Syncally](https://syncally.app), you're coordinating parallel AI workstreams that don't step on each other's toes.

### Probabilistic Progress (The Physics Analogy)

My friends at [GitHub Next](https://githubnext.com/projects/continuous-ai/) are exploring similar ideas. Their researcher [Don Syme](https://github.com/dsyme) nailed the fault-tolerance insight: *"If things go wrong, it just hits resource limits and tries again. You throw away bad PRs. Much better than frustrated users stuck guiding agents down wrong paths."*

This reminds me of particle physics—specifically "radiation of probabilities" (bear with me). Each Auto-Claude run is like a quantum particle: individually unpredictable, but collectively trending toward your goal. Some iterations fail spectacularly. Others nail it. What matters is the aggregate direction, not individual successes.

This "wasteful-but-effective" approach becomes economically viable as AI costs approach zero, similar to how Cursor runs multiple simultaneous agents.

</details>

## ⚡ Quick Start

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/iKislay/auto-claude/main/install.sh | bash
```

This auto-installs to `~/.local/bin`, checks dependencies, and configures your PATH.

### Manual Installation

Prefer DIY? Here's the manual route:

```bash
curl -fsSL https://raw.githubusercontent.com/iKislay/auto-claude/main/auto_claude.sh -o auto-claude
chmod +x auto-claude
sudo mv auto-claude /usr/local/bin/
```

**Uninstall**: `rm ~/.local/bin/auto-claude` (or `/usr/local/bin/auto-claude`)

### Required Dependencies

Before your first run, ensure these are installed:

1. **[Claude Code CLI](https://code.claude.com)** → Authenticate: `claude auth`
2. **[GitHub CLI](https://cli.github.com)** → Authenticate: `gh auth login`
3. **jq** → Install: `brew install jq` (macOS) or `apt-get install jq` (Linux)

### Your First Run

```bash
# Auto-detects repo from git remote
auto-claude --prompt "add unit tests until all code is covered" --max-runs 5

# Explicit repo specification
auto-claude --prompt "refactor legacy auth module" --max-runs 10 --owner myuser --repo myapp

# Budget-constrained run
auto-claude --prompt "improve documentation" --max-cost 10.00

# Time-boxed sprint
auto-claude --prompt "fix all TypeScript errors" --max-duration 2h
```

## 🎛️ Configuration Reference

### Core Flags

| Flag | Description | Example |
|------|-------------|---------|
| `-p, --prompt` | The mission for Claude (required) | `"add tests"` |
| `-m, --max-runs` | Iteration limit (0 = infinite) | `10` |
| `--max-cost` | Budget cap in USD | `25.00` |
| `--max-duration` | Time limit (`2h`, `30m`, `1h30m`) | `90m` |
| `--owner` | GitHub username (auto-detected) | `iKislay` |
| `--repo` | Repository name (auto-detected) | `auto-claude` |

### Workflow Customization

| Flag | Description | Default |
|------|-------------|---------|
| `--merge-strategy` | How to merge PRs | `squash` |
| `--git-branch-prefix` | Branch naming prefix | `auto-claude/` |
| `--notes-file` | Shared memory file | `SHARED_TASK_NOTES.md` |
| `--completion-signal` | Project-done phrase | `AUTO_CLAUDE_PROJECT_COMPLETE` |
| `--completion-threshold` | Consecutive signals to stop | `3` |

### Advanced Options

| Flag | Description | Use Case |
|------|-------------|----------|
| `--disable-commits` | Dry-run mode (no PRs) | Testing prompts |
| `--worktree <name>` | Parallel execution workspace | Running 3 agents simultaneously |
| `--worktree-base-dir` | Worktree storage location | `../auto-claude-worktrees` |
| `--cleanup-worktree` | Remove worktree on completion | One-off tasks |
| `--list-worktrees` | Show active worktrees | Housekeeping |
| `--dry-run` | Simulate without changes | Validation |

**Pro Tip**: Unrecognized flags auto-forward to Claude Code CLI. Use `--allowedTools "Read,Write"` or `--model claude-haiku-4-5` directly.

## 💡 Real-World Examples

### Budget-Conscious Development
```bash
# Spend exactly $5, stop when done or money runs out
auto-claude -p "migrate API from REST to GraphQL" --max-cost 5.00
```

### Lunch Break Automation
```bash
# Give it 1 hour while you grab lunch
auto-claude -p "update all dependencies and fix breaking changes" --max-duration 1h
```

### Overnight Marathon
```bash
# Run indefinitely until the job is actually done
auto-claude -p "add comprehensive error handling across all endpoints" -m 0 --max-cost 50.00 --completion-threshold 3
```

### Parallel Development Streams
```bash
# Terminal 1: Backend work
auto-claude -p "Add input validation to all API routes" -m 15 --worktree backend

# Terminal 2: Frontend work
auto-claude -p "Convert class components to hooks" -m 15 --worktree frontend
```

Each runs independently, creating PRs in parallel. No conflicts, no coordination overhead.

### Conservative Testing
```bash
# Use cheapest model, restrict to safe operations
auto-claude -p "document public functions" -m 5 --model claude-haiku-4-5 --allowedTools "Read,Write"
```

### Smart Stopping
```bash
# Stop early when Claude confirms completion 3 times
auto-claude -p "fix all ESLint warnings" -m 100 --completion-threshold 3
```

If Claude says "ALL_DONE" (the default signal) three iterations in a row, the loop terminates early—saving tokens and time.

## 🔍 Troubleshooting

### Installation Issues

**"jq: command not found"**
→ Install: `brew install jq` (macOS) or `sudo apt-get install jq` (Linux)

**"claude: command not found"**
→ Visit [code.claude.com](https://code.claude.com), install CLI, then run `claude auth`

**"gh: command not found"**
→ Install GitHub CLI from [cli.github.com](https://cli.github.com), authenticate with `gh auth login`

### Runtime Issues

**"Cannot auto-detect GitHub repo"**
→ Not in a git repo or remote isn't GitHub? Use `--owner` and `--repo` explicitly

**"PR checks timeout after 30 minutes"**
→ Your CI takes >30min? The loop will close the PR and retry. Consider:
- Optimizing your CI pipeline
- Breaking the task into smaller pieces
- Using `--max-duration` for longer runs

**"Loop stopped after 3 errors"**
→ Safety mechanism. Auto-Claude halts after 3 consecutive failures to prevent infinite error loops. Review the error logs, fix underlying issues, and restart.

### Need Help?

- **Bug reports**: [GitHub Issues](https://github.com/iKislay/auto-claude/issues)
- **Technical deep-dive**: [CLAUDE.md](./CLAUDE.md)
- **Updates**: `auto-claude update`

## 🧠 Best Practices

### Crafting Effective Prompts

**❌ Vague**: `"improve the code"`
**✅ Specific**: `"Add TypeScript types to all API route handlers in src/routes/"`

**❌ Massive scope**: `"rewrite the entire app"`
**✅ Incremental**: `"Refactor authentication module to use JWT, one route at a time"`

**❌ No success criteria**: `"make it better"`
**✅ Measurable**: `"Increase test coverage from 45% to 75%"`

### Ideal Use Cases

| Task Type | Why It Works | Example Prompt |
|-----------|--------------|----------------|
| **Test generation** | Systematic, repetitive, clear success criteria | `"Add Jest tests to all untested utility functions"` |
| **Documentation** | Well-defined format, low risk | `"Add JSDoc comments to all exported functions"` |
| **Refactoring** | Small incremental changes, validated by CI | `"Convert all var declarations to const/let"` |
| **Dependency updates** | Automated fixes for breaking changes | `"Update React to v18 and fix breaking changes"` |
| **Code quality** | Linter errors provide clear feedback | `"Fix all ESLint errors in src/ directory"` |

### Challenging Use Cases

| Task Type | Why It's Hard | Alternative Approach |
|-----------|---------------|---------------------|
| **Architecture decisions** | Requires human judgment, business context | Use Claude for research, human for decisions |
| **Time-sensitive work** | Loop may take hours/days | Use standard Claude Code interactively |
| **External dependencies** | Can't access private docs, Slack, etc. | Provide context in shared notes file |

### Cost Management

**Start Small**: Test with `--max-cost 2.00` before committing to larger budgets

**Time-Box Experiments**: Use `--max-duration 30m` to cap exploration

**Monitor Progress**: Check `SHARED_TASK_NOTES.md` periodically to ensure Claude isn't stuck

**Smart Stopping**: Always use `--completion-threshold 3` to prevent unnecessary iterations

**Model Selection**: For simple tasks, `--model claude-haiku-4-5` is 10x cheaper than Sonnet

## 🚀 Advanced Features

### Completion Signals

Claude can signal when the entire project (not just the current task) is complete:

```bash
auto-claude -p "fix all TODO comments" -m 50 --completion-threshold 3
```

When Claude outputs `AUTO_CLAUDE_PROJECT_COMPLETE` three times consecutively, the loop terminates early. Customize the signal:

```bash
auto-claude -p "security audit" --completion-signal "SECURITY_AUDIT_COMPLETE" --completion-threshold 2
```

### Merge Strategies

**Squash (default)** → Clean history, one commit per PR
**Merge** → Preserve detailed commit history
**Rebase** → Linear history, no merge commits

```bash
auto-claude -p "add logging" -m 5 --merge-strategy rebase
```

### Worktree Orchestration

Run 3 specialists simultaneously:

```bash
# List active worktrees
auto-claude --list-worktrees

# Launch parallel work
auto-claude -p "Add E2E tests" -m 10 --worktree testing
auto-claude -p "Update README" -m 3 --worktree docs
auto-claude -p "Profile performance" -m 5 --worktree perf

# Cleanup temporary worktree
auto-claude -p "quick fix" -m 1 --worktree temp --cleanup-worktree
```

### Forwarding Claude Flags

Any flag Auto-Claude doesn't recognize gets passed directly to Claude Code:

```bash
# Restrict tools for safety
auto-claude -p "analyze code" --allowedTools "Read,Grep,Glob"

# Use specific model
auto-claude -p "complex refactor" --model claude-opus-4-5

# Combine multiple forwards
auto-claude -p "task" --model claude-haiku-4-5 --allowedTools "Write,Read" --max-tokens 4096
```

## 🔬 Under the Hood

### Architecture

1. **Branch Naming**: `auto-claude/iteration-N/YYYY-MM-DD-randomhash` ensures uniqueness
2. **Enhanced Prompting**: Each iteration receives: workflow context + your prompt + previous notes
3. **JSON Parsing**: Claude runs with `--output-format json` for reliable structured output
4. **Commit Generation**: A nested Claude call generates meaningful commit messages by analyzing diffs
5. **PR Polling**: Checks GitHub every 10 seconds, only logs on state changes (reduces noise)
6. **Failure Recovery**: 3 strikes and you're out—prevents infinite error loops
7. **Memory Persistence**: `SHARED_TASK_NOTES.md` acts as external memory across iterations

### Example Terminal Output

```
🔄 (1/5) Starting iteration...
🌿 (1/5) Creating branch: auto-claude/iteration-1/2026-01-02-a7f3c941
🤖 (1/5) Running Claude Code...
📝 (1/5) Output: Successfully added tests for authentication module. Coverage increased from 34% to 67%.
💰 (1/5) Cost: $0.12
✅ (1/5) Work completed
💬 (1/5) Committing changes...
📦 (1/5) Changes committed on branch: auto-claude/iteration-1/2026-01-02-a7f3c941
📤 (1/5) Pushing branch...
🔨 (1/5) Creating pull request...
🔍 (1/5) PR #127 created, waiting for GitHub...
🔍 (1/5) Checking PR status...
   📊 Found 4 check(s)
   🟢 3    🟡 1    🔴 0
   👁️  Review status: Approved
⏳ Waiting for: checks to complete
✅ (1/5) All PR checks passed!
🔀 (1/5) Merging PR #127...
📥 (1/5) Pulling latest from main...
🗑️  (1/5) Cleaning up branch
✅ (1/5) PR #127 merged: Add unit tests for authentication module

🔄 (2/5) Starting iteration...
...
```

## 🧪 Testing

Validate your installation:

```bash
# Setup test dependencies (one-time)
./tests/setup.sh

# Run full test suite
./tests/libs/bats/bin/bats tests/test_auto_claude.bats
```

Tests use BATS (Bash Automated Testing System) and cover argument parsing, error handling, completion signals, and worktree management.

## 🤝 Contributing

This project thrives on community contributions! Ways to help:

1. **🐛 Report bugs** → Open detailed issues with reproduction steps
2. **💡 Suggest features** → Share your use cases and ideas
3. **🔧 Submit PRs** → Fork, branch, code, test, and submit
4. **📚 Improve docs** → Fix typos, clarify explanations, add examples
5. **✅ Write tests** → Increase coverage, prevent regressions

### Development Setup

```bash
git clone https://github.com/iKislay/auto-claude.git
cd auto-claude
chmod +x auto_claude.sh

# Run tests
./tests/setup.sh
./tests/libs/bats/bin/bats tests/test_auto_claude.bats
```

### Contribution Guidelines

- **Code style**: Follow existing Bash conventions (shellcheck compliant)
- **Testing**: Add BATS tests for new features
- **Documentation**: Update README and CLAUDE.md for user-facing changes
- **Compatibility**: Maintain backward compatibility when possible

## 👨‍💻 Author

Built by **Kumar Kislay**

- 🌐 Website: [kislay.is-a.dev](https://kislay.is-a.dev)
- 🐦 Twitter: [@whykislay](https://twitter.com/whykislay)
- 💼 LinkedIn: [kislayy](https://www.linkedin.com/in/kislayy/)
- 📧 Email: kislay@syncally.app
- 🗓️ Check out: [Syncally](https://syncally.app) - Smart calendar scheduling for modern teams

## 📜 License

[MIT](./LICENSE) ©️ [Kumar Kislay](https://kislay.is-a.dev)

---

**Originally inspired by** [Continuous Claude](https://github.com/AnandChowdhary/continuous-claude) by Anand Chowdhary
