In **Bash**, double quotes `""` and single quotes `''` both create string literals, but they behave very differently when it comes to **expansion**.

---

## 🔑 Key difference

### 1. **Single quotes `'...'`**

* Everything inside is taken **literally**.
* No variable expansion, no command substitution, no escape sequences.

```bash
name="World"

echo 'Hello $name'   # → Hello $name   (no expansion)
echo 'It\'s fine'    # ❌ Error (cannot escape quotes inside single quotes)
```

If you need a literal single quote inside single quotes, you have to close and reopen them:

```bash
echo 'It'\''s fine'   # → It's fine
```

---

### 2. **Double quotes `"..."`**

* Allows **expansions**:

  * Variables (`$var`)
  * Command substitution (`$(...)` or `` `...` ``)
  * Arithmetic expansion (`$((...))`)
* Preserves **whitespace** inside the string.

```bash
name="World"

echo "Hello $name"       # → Hello World
echo "Today is $(date)"  # → Today is Tue Sep  3 10:00:00 UTC 2025
```

Escapes work inside double quotes:

```bash
echo "Line1\nLine2"   # → Line1\nLine2  (still literal, unless you use echo -e)
echo "He said \"Hi\"" # → He said "Hi"
```

---

## ✅ Quick summary table

| Quotes  | Expands variables? | Expands commands? | Escapes allowed? | Typical use            |
| ------- | ------------------ | ----------------- | ---------------- | ---------------------- |
| `'...'` | ❌ No               | ❌ No              | ❌ Mostly no      | Literal strings        |
| `"..."` | ✅ Yes              | ✅ Yes             | ✅ Yes            | Strings with expansion |

---

👉 Rule of thumb:

* Use **`'...'`** when you want an exact, literal string.
* Use **`"..."`** when you want Bash to expand things inside.

---
