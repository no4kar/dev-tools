
---

### ✅ `awk` – Pattern Scanning and Text Processing (for Bash / Unix / Linux)

`awk` is a powerful command-line tool for **scanning, filtering, and transforming text**, especially useful when working with structured data like columns or delimited fields.

The name `awk` comes from its creators: **Alfred Aho, Peter Weinberger, and Brian Kernighan**.

---

### 🔤 `FS` — **Field Separator**

* Controls how `awk` splits each line into fields.
* Default is a **space** or **tab**.
* You can set it to other things, like `/` to split file paths.

**Example:**

```bash
echo "path/to/file.txt" | awk 'BEGIN { FS="/" } { print $2 }'
# Output: to
```

```bash
$ ls -l | awk '{print $5 " " $9}'
# Output:
# 0 prompts/
# 0 scripts/
```

---

### 🔢 `NF` — **Number of Fields**

* Represents the **number of fields** on the current line after it’s split by `FS`.

**Example:**

```bash
echo "a/b/c" | awk 'BEGIN { FS="/" } { print NF }'
# Output: 3
```

You can use `$1`, `$2`, ..., `$NF` to access individual fields.

---

### 🔁 `NR` — **Number of Records (Lines Read)**

* Tells you the **line number** currently being processed.
* `NR == 1` means you're processing the **first line**.

**Example:**

```bash
echo -e "line1\nline2" | awk '{ print NR ": " $0 }'
# Output:
# 1: line1
# 2: line2
```

```bash
$ echo -e "dir/some-file1\ndir1/dir2/some-file2" | \
awk 'BEGIN{FS="/"} {print "line-nr" NR ": " $0 " NF=" NF}'
# Output:
# line-nr1: dir/some-file1 NF=2
# line-nr2: dir1/dir2/some-file2 NF=3
```

---

### 🏁 `BEGIN`, `{}`, and `END` Blocks — **Execution Order**

`awk` programs can have three main types of blocks:

1. **`BEGIN {}`**

   * Executed **once before any input lines** are processed.
   * Typically used for initializing variables, setting `FS`, or printing headers.

2. **`{}` (main block)**

   * Executed **once for every input line**.
   * Contains the main processing logic, like printing fields or filtering lines.

3. **`END {}`**

   * Executed **once after all input lines** have been processed.
   * Often used to print totals, summaries, or final formatting.

**Execution order:**

```
BEGIN {}   → executed first, once
{}         → executed for each line
END {}     → executed last, once
```

**Example:**

```bash
awk 'BEGIN { print "Start" }
     { print $1 }
     END { print "Done" }' file.txt
```

* Prints `"Start"` before processing.
* Prints the first field `$1` for each line.
* Prints `"Done"` after all lines are processed.

---

### 📊 Visual Diagram — `awk` Flow

```
         ┌─────────────┐
         │  BEGIN {}   │  ← executed once before any input
         └─────┬───────┘
               │
               ▼
        ┌─────────────┐
Input → │    {}       │  ← executed for each line
        └─────┬───────┘
               │
               ▼
         ┌─────────────┐
         │   END {}    │  ← executed once after all input
         └─────────────┘
```

This diagram shows the **flow of execution** clearly: `BEGIN` → main `{}` → `END`.

---
