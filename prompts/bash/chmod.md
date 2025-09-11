
---

### ✅ `chmod` – Change File Permissions (for Bash / Unix / Linux)

Use the `chmod` command to **change permissions** on files and directories in Unix/Linux systems.

---

## 📘 Check File Permissions

```bash
ls -l <filename>
```

Example output:

```
-rwxr-xr--
```

### Breakdown:

* `-` : It's a **regular file**
* `rwx` : The **OWNER** (characters 2–4) can read, write, and execute
* `r-x` : The **GROUP** (characters 5–7) can read and execute, but not write
* `r--` : **OTHERS** (characters 8–10) can only read

---

## 🔢 Set Permissions with Numeric Mode

```bash
chmod 755 file.txt
```

Each permission digit = `r=4`, `w=2`, `x=1`. The sum defines access.

### Numeric Breakdown:

| Digit | Binary | Meaning                      |
| ----- | ------ | ---------------------------- |
| `7`   | 4+2+1  | `rwx` (read, write, execute) |
| `5`   | 4+0+1  | `r-x` (read, execute)        |

So `chmod 755 file.txt` sets:

* **Owner**: `rwx` (read, write, execute)
* **Group**: `r-x` (read, execute)
* **Others**: `r-x` (read, execute)

---
