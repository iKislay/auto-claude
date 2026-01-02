# Contributing to Auto-Claude

Thank you for your interest in contributing to Auto-Claude! This document provides guidelines and information to help you contribute effectively.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Code Style Guidelines](#code-style-guidelines)
- [Documentation](#documentation)

## Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please be respectful and constructive in all interactions.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/auto-claude.git
   cd auto-claude
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/iKislay/auto-claude.git
   ```

## Development Setup

### Prerequisites

- Bash 4.0 or higher
- Git 2.5 or higher
- [Claude Code CLI](https://code.claude.com)
- [GitHub CLI](https://cli.github.com)
- jq (JSON processor)

### Install Test Dependencies

```bash
./tests/setup.sh
```

This installs BATS (Bash Automated Testing System) and its helper libraries.

## Making Changes

### Create a Branch

Always create a new branch for your work:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `test/` - Test improvements
- `refactor/` - Code refactoring

### Keep Your Fork Updated

Regularly sync with upstream:

```bash
git fetch upstream
git rebase upstream/main
```

## Testing

### Run the Test Suite

```bash
./tests/libs/bats/bin/bats tests/test_auto_claude.bats
```

### Test Coverage

Ensure your changes include tests:
- Add new tests for new features
- Update existing tests for bug fixes
- Ensure all tests pass before submitting

### Manual Testing

Test your changes in a real repository:

```bash
# Test in dry-run mode first
./auto_claude.sh -p "test task" -m 1 --dry-run --disable-commits

# Test with a real iteration (use a test repo)
./auto_claude.sh -p "add comment to README" -m 1 --owner YOUR-USER --repo test-repo
```

## Submitting Changes

### Before Submitting

1. **Run shellcheck** (if available):
   ```bash
   shellcheck auto_claude.sh
   ```

2. **Run all tests**:
   ```bash
   ./tests/libs/bats/bin/bats tests/test_auto_claude.bats
   ```

3. **Update documentation** if needed:
   - Update README.md for user-facing changes
   - Update CLAUDE.md for architectural changes
   - Add inline comments for complex logic

### Create a Pull Request

1. **Push your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open a Pull Request** on GitHub with:
   - Clear title describing the change
   - Description explaining what and why
   - Reference any related issues (#123)
   - Screenshots/examples if applicable

### Pull Request Guidelines

- Keep changes focused and atomic
- Write clear commit messages
- Respond to feedback promptly
- Ensure CI checks pass

## Code Style Guidelines

### Bash Style

Follow these conventions for consistency:

1. **Indentation**: Use 4 spaces (no tabs)

2. **Variable naming**:
   ```bash
   # Global variables: UPPER_CASE
   GLOBAL_VAR="value"

   # Local variables: lower_case
   local local_var="value"
   ```

3. **Function definitions**:
   ```bash
   function_name() {
       local arg1="$1"
       local arg2="$2"

       # Function body
   }
   ```

4. **Quoting**:
   ```bash
   # Always quote variables
   echo "$variable"

   # Use double quotes for strings with variables
   message="Hello $name"

   # Use single quotes for literal strings
   literal='This is literal'
   ```

5. **Error handling**:
   ```bash
   if ! command_that_might_fail; then
       echo "Error: descriptive message" >&2
       return 1
   fi
   ```

6. **Comments**:
   ```bash
   # Explain why, not what
   # Good: Retry 3 times to handle transient network errors
   # Bad: Loop 3 times
   ```

### Function Documentation

Document complex functions with comments:

```bash
# Parses a duration string (e.g., "2h", "30m") to seconds
# Arguments:
#   $1 - Duration string (e.g., "2h30m", "90s")
# Returns:
#   Number of seconds, or 1 on error
# Example:
#   parse_duration "1h30m"  # Returns 5400
parse_duration() {
    # Implementation
}
```

## Documentation

### When to Update Documentation

Update documentation when you:
- Add new features or options
- Change existing behavior
- Fix bugs that affect usage
- Add examples or use cases

### Documentation Files

- **README.md** - User-facing documentation, examples, quick start
- **CLAUDE.md** - Internal architecture, for Claude Code and developers
- **CONTRIBUTING.md** - This file, for contributors
- Inline comments - Explain complex logic

### Writing Style

- Be clear and concise
- Use examples liberally
- Assume readers are developers but may be new to Bash
- Include both simple and advanced examples

## Common Contribution Areas

### Easy First Contributions

- Fix typos in documentation
- Improve error messages
- Add more examples to README
- Add tests for existing functionality
- Improve inline comments

### Medium Contributions

- Add new command-line options
- Improve error handling
- Add new merge strategies
- Optimize performance

### Advanced Contributions

- Add new core features
- Refactor major components
- Improve CI/CD integration
- Add support for other Git platforms

## Getting Help

- **Questions**: Open a GitHub Discussion
- **Bugs**: Open a GitHub Issue with reproduction steps
- **Features**: Open a GitHub Issue describing the use case
- **Chat**: Reach out to [@whykislay](https://twitter.com/whykislay) on Twitter

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- README acknowledgments section (coming soon)

## License

By contributing, you agree that your contributions will be licensed under the same [MIT License](./LICENSE) that covers the project.

---

Thank you for contributing to Auto-Claude! Your efforts help make autonomous AI development more accessible to everyone.
