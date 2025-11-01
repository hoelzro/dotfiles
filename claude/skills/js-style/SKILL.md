---
name: javascript
description: JavaScript development guidance for Claude Code. Use when writing, testing, or working with JavaScript code to ensure consistent practices and proper test execution.
---

# JavaScript Development

## Testing

Always use `npm test` to run the test suite. If you need to provide extra arguments to whatever command `npm test` corresponds to, use:

```bash
npm test -- $EXTRA_ARGS
```

This ensures arguments are properly passed through to the underlying test runner.
