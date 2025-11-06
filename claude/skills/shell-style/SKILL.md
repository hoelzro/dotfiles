---
name: shell-scripting
description: Best practices for writing shell scripts. Use when writing bash, sh, zsh, or other shell code for automation, scripting, or command-line tasks.
---

# Shell Scripting

## Best Practices

### Favor Long Options

When writing shell scripts, prefer long options (e.g., `--verbose`) over short options (e.g., `-v`) for improved readability and maintainability.

**Why long options?**
- **Self-documenting**: `grep --ignore-case` is clearer than `grep -i`
- **Easier maintenance**: Future readers understand intent without checking man pages
- **Reduced errors**: Less likely to misinterpret what a short flag does

**Example:**

```bash
# Good: Clear and self-documenting
find /var/log --name "*.log" --type f --mtime +30 --delete

# Avoid: Requires knowledge of what each flag means
find /var/log -name "*.log" -type f -mtime +30 -delete
```

**Exception:** Short options are acceptable for:
- Extremely common commands where the short form is universally understood (e.g., `ls -la`)
- Interactive terminal usage where brevity matters
- Commands without long option equivalents

