# Development Guidelines

## Code Quality

### Output Discipline

- **Keep output clean and minimal.** Only print what's essential for debugging or required functionality. Quiet code signals success.
- **Write self-documenting code.** Use clear variable and function names. Add comments only for complex business logic or non-obvious decisions.

### Design Philosophy

- **Fail-fast.** Validate inputs early, throw errors immediately on invalid states, and surface problems quickly.
- **Prefer functional over OOP.** Use pure functions, immutability, and composition over classes and inheritance when practical.

## Testing & Coverage

- **Run all tests before completing work.** Ensure everything passes before reporting back.
- **Maintain or improve test coverage.** Preserve existing coverage levels and add tests for new code paths.
