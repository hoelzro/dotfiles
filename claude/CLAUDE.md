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

# Environment

You don't have root/sudo - favor doing things in a rootless manner (eg. using podman over docker), but if you absolutely _must_ do something as root (eg. installing a system-level package), or if doing so would be a _really_ dumb idea, feel free to stop what you're doing and just ask for my help.

If you can work around it without root but the solution is gross (eg. installing a package to a user-writable directory), go ahead and do that, but make notes on how I can prepare the environment better for you next time.
