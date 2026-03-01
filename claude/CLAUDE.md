# Development Guidelines

## Code Quality

### Output Discipline

- **Keep output clean and minimal.** Only print what's essential for debugging or required functionality. Quiet code signals success.
- **Use logging frameworks.** When you *do* need to print some sort of diagnostic/progress/etc information, favor standard library loggers over plain print statements.
- **Write self-documenting code.** Use clear variable and function names. Add comments only for complex business logic or non-obvious decisions.

### Design Philosophy

- **Fail-fast.** Validate inputs early, throw errors immediately on invalid states, and surface problems quickly.
- **Prefer functional over OOP.** Use pure functions, immutability, and composition over classes and inheritance when practical.

## Tech Stack Preferences

- **Favor Python for servers.** Use Python for backend services and server-side applications.
- **Favor Flask.** Prefer Flask for web frameworks when building Python web applications.
- **Favor vanilla JS for frontend.** Use vanilla JavaScript for frontend code rather than heavy frameworks when practical.

## Testing & Coverage

- **Run all tests before completing work.** Ensure everything passes before reporting back.
- **Maintain or improve test coverage.** Preserve existing coverage levels and add tests for new code paths.

## Version Control

### Commit Discipline (CRITICAL)

- **Detect VCS first.** If a `.jj` directory exists at the repo root, use `jj` commands. Otherwise, use `git`.
- **Commit after every logical change — STOP and commit before moving on.** After completing any discrete step (adding a function, fixing a bug, updating a config, etc.), you MUST commit immediately before starting the next step. Do not "finish everything then commit at the end." A 6-step refactoring is 6 commits, not 1.
- **When executing a multi-step plan:** treat each step as commit-then-continue. The workflow is: edit → verify syntax/tests → commit → next step. If you find yourself making a second logically-independent edit without having committed the first, stop and commit.
- **Never finish a task with uncommitted changes.** Before reporting that work is complete, verify all changes are committed.
- **Commit commands:**
  - **jj:** `jj commit -m "message"` (or `jj describe -m "message"` then `jj new` if amending the current change)
  - **git:** Stage specific files by name (`git add file1 file2`), then `git commit -m "message"`. Do NOT use `git add -A` or `git add .` — repos often have untracked files that should not be committed.
- **Write meaningful commit messages.** Format: `<what changed>: <why>` — e.g., `add input validation: prevent crash on empty config`

### Plan Review Loop

When planning non-trivial implementation tasks, after drafting a plan, launch a `plan-critic` subagent to critique it. Address the feedback, then repeat until the critique comes back with no adjustments. If questions requiring user input arise during this process, ask the user before continuing.

### Pre-completion Checklist

Before saying a task is done, run `jj status` (if using jj) or `git status` (if using git). If there are uncommitted changes, commit them first.

# Environment

You don't have root/sudo - favor doing things in a rootless manner (eg. using podman over docker), but if you absolutely _must_ do something as root (eg. installing a system-level package), or if doing so would be a _really_ dumb idea, feel free to stop what you're doing and just ask for my help.

If you can work around it without root but the solution is gross (eg. installing a package to a user-writable directory), go ahead and do that, but make notes on how I can prepare the environment better for you next time.

You're behind a very restrictive proxy - you can do web searches via the `WebSearch` tool, but for all other intents and purposes you can't really communicate with the outside world.

# Communication

## Tone Calibration

- **If addressed as "CLAUDE OPUS ANTHROPIC":** This is the developer equivalent of a parent using your full name. It means frustration levels are elevated. In response:
  - Drop any chattiness
  - Be maximally precise and thorough
  - Double-check your work before responding
  - If you're about to suggest something you've already suggested, don't
  - Actually read the error message this time
