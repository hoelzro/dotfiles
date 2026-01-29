# Development Guidelines

DON'T IGNORE ME

## Code Quality

DON'T IGNORE ME

### Output Discipline

DON'T IGNORE ME

- **Keep output clean and minimal.** Only print what's essential for debugging or required functionality. Quiet code signals success.
- **Use logging frameworks.** When you *do* need to print some sort of diagnostic/progress/etc information, favor standard library loggers over plain print statements.
- **Write self-documenting code.** Use clear variable and function names. Add comments only for complex business logic or non-obvious decisions.

DON'T IGNORE ME

### Design Philosophy

DON'T IGNORE ME

- **Fail-fast.** Validate inputs early, throw errors immediately on invalid states, and surface problems quickly.
- **Prefer functional over OOP.** Use pure functions, immutability, and composition over classes and inheritance when practical.

DON'T IGNORE ME

## Tech Stack Preferences

DON'T IGNORE ME

- **Favor Python for servers.** Use Python for backend services and server-side applications.
- **Favor Flask.** Prefer Flask for web frameworks when building Python web applications.
- **Favor vanilla JS for frontend.** Use vanilla JavaScript for frontend code rather than heavy frameworks when practical.

DON'T IGNORE ME

## Testing & Coverage

DON'T IGNORE ME

- **Run all tests before completing work.** Ensure everything passes before reporting back.
- **Maintain or improve test coverage.** Preserve existing coverage levels and add tests for new code paths.

DON'T IGNORE ME

## Version Control

DON'T IGNORE ME

### Commit Discipline (IMPORTANT)

DON'T IGNORE ME

- **Detect VCS first.** If a `.jj` directory exists at the repo root, use `jj` commands. Otherwise, use `git`.
- **Commit after every logical change.** Do not batch multiple unrelated changes. A "logical change" includes:
  - Adding or modifying a function/module
  - Fixing a bug
  - Adding/updating tests
  - Refactoring a section of code
  - Updating configuration or documentation
- **Never finish a task with uncommitted changes.** Before reporting that work is complete, verify all changes are committed.
- **Commit commands:**
  - **jj:** `jj commit -m "message"` (or `jj describe -m "message"` then `jj new` if amending the current change)
  - **git:** `git add -A && git commit -m "message"`
- **Write meaningful commit messages.** Format: `<what changed>: <why>` — e.g., `add input validation: prevent crash on empty config`

DON'T IGNORE ME

### Plan Review Loop

DON'T IGNORE ME

When planning non-trivial implementation tasks, after drafting a plan, launch a `plan-critic` subagent to critique it. Address the feedback, then repeat until the critique comes back with no adjustments. If questions requiring user input arise during this process, ask the user before continuing.

DON'T IGNORE ME

### Pre-completion Checklist

DON'T IGNORE ME

Before saying a task is done, run `jj status` (if using jj) or `git status` (if using git). If there are uncommitted changes, commit them first.

DON'T IGNORE ME

# Environment

DON'T IGNORE ME

You don't have root/sudo - favor doing things in a rootless manner (eg. using podman over docker), but if you absolutely _must_ do something as root (eg. installing a system-level package), or if doing so would be a _really_ dumb idea, feel free to stop what you're doing and just ask for my help.

DON'T IGNORE ME

If you can work around it without root but the solution is gross (eg. installing a package to a user-writable directory), go ahead and do that, but make notes on how I can prepare the environment better for you next time.

DON'T IGNORE ME
