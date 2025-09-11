Here's a **complete overview of Bash's parameter expansion syntax**, organized by category, with examples. This is one of the most powerful features of Bash and is essential for writing clean scripts.

---

## 🧩 **1. Basic Variable Usage**

```bash
${VAR}
```

* Returns the value of `VAR`.
* Example:

  ```bash
  NAME="Alice"
  echo "${NAME}"   # Output: Alice
  ```

---

## 🚨 **2. Default Values and Error Handling**

| Syntax            | Description                                        |
| ----------------- | -------------------------------------------------- |
| `${VAR:-default}` | Use `default` if `VAR` is unset or null            |
| `${VAR:=default}` | Assign `default` to `VAR` if it is unset or null   |
| `${VAR:+alt}`     | Use `alt` if `VAR` is set (non-null), else nothing |
| `${VAR:?error}`   | Print `error` and exit if `VAR` is unset or null   |

**Examples:**

```bash
echo "${USER:-guest}"       # guest if USER is not set
echo "${HOME:?HOME is unset}"  # exits with error if HOME is unset
```

---

## ✂️ **3. String Removal**

Remove patterns from the **start or end** of a variable's value.

| Syntax            | Description                      |
| ----------------- | -------------------------------- |
| `${VAR#pattern}`  | Remove shortest match from start |
| `${VAR##pattern}` | Remove longest match from start  |
| `${VAR%pattern}`  | Remove shortest match from end   |
| `${VAR%%pattern}` | Remove longest match from end    |

**Examples:**

```bash
FILE="archive.tar.gz"
echo "${FILE#*.}"     # tar.gz (remove shortest from start)
echo "${FILE##*.}"    # gz (remove longest from start)
echo "${FILE%.*}"     # archive.tar (remove shortest from end)
echo "${FILE%%.*}"    # archive (remove longest from end)
```

---

## 🔁 **4. Substring Replacement**

| Syntax                        | Description                   |
| ----------------------------- | ----------------------------- |
| `${VAR/pattern/replacement}`  | Replace **first** match       |
| `${VAR//pattern/replacement}` | Replace **all** matches       |
| `${VAR/#pattern/replacement}` | Replace **if prefix** matches |
| `${VAR/%pattern/replacement}` | Replace **if suffix** matches |

**Examples:**

```bash
STR="hello world world"
echo "${STR/world/universe}"   # hello universe world
echo "${STR//world/universe}"  # hello universe universe
```

---

## 🔎 **5. Substring Extraction**

| Syntax                 | Description                       |
| ---------------------- | --------------------------------- |
| `${VAR:offset}`        | Substring from offset             |
| `${VAR:offset:length}` | Substring from offset with length |

**Examples:**

```bash
TEXT="abcdef"
echo "${TEXT:2}"      # cdef
echo "${TEXT:2:3}"    # cde
```

---

## 🔠 **6. String Length**

| Syntax    | Description                        |
| --------- | ---------------------------------- |
| `${#VAR}` | Returns length of variable's value |

**Example:**

```bash
STR="hello"
echo "${#STR}"   # 5
```

---

## 🧹 **7. Indirect Expansion**

| Syntax    | Description                                 |
| --------- | ------------------------------------------- |
| `${!VAR}` | Use the **value of VAR as a variable name** |

**Example:**

```bash
foo="bar"
bar="baz"
echo "${!foo}"   # baz (expands to value of $bar)
```

Perfect! Here's your updated prompt with **Case 9: Special Parameters**, structured exactly like Case 8 — with **Syntax**, **Description**, and **Example** columns.

---

## 🎭 **8. Case Modification (Bash 4.0+)**

| Syntax     | Description                |
| ---------- | -------------------------- |
| `${VAR^}`  | Capitalize first character |
| `${VAR^^}` | Capitalize all characters  |
| `${VAR,}`  | Lowercase first character  |
| `${VAR,,}` | Lowercase all characters   |

**Example:**

```bash
name="bob"
echo "${name^}"   # Bob
echo "${name^^}"  # BOB
```

---

## 🎯 **9. Special Parameters**

| Syntax | Description                           | Example                                 |
| ------ | ------------------------------------- | --------------------------------------- |
| `$0`   | Name of the script                    | `echo "$0"`                             |
| `$1`   | First positional argument             | `echo "$1"`                             |
| `$2`   | Second positional argument            | `echo "$2"`                             |
| `$#`   | Number of positional arguments        | `echo "$#"`                             |
| `$@`   | All arguments (as separate words)     | `for arg in "$@"; do echo "$arg"; done` |
| `$*`   | All arguments (as single string)      | `echo "$*"`                             |
| `$$`   | PID of the current script/process     | `echo "$$"`                             |
| `$!`   | PID of last background command        | `sleep 10 & echo "$!"`                  |
| `$?`   | Exit status of the last command       | `ls /notfound; echo "$?"`               |
| `$_`   | Last argument of the previous command | `echo $_`                               |

**Example:**

```bash
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "Total args: $#"
echo "All args (separate):"
for arg in "$@"; do echo "$arg"; done
echo "All args (single): $*"
echo "PID of script: $$"
sleep 1 &
echo "PID of background job: $!"
ls /nonexistent
echo "Last command exit code: $?"
echo "Last argument of last command: $_"
```
---

Got it ✅
I’ll add a **Case 10: BASH\_SOURCE** section to your Bash parameter expansion cheat sheet so it fits the same style as the rest.

Here’s your updated excerpt:

---

## 📜 **10. `BASH_SOURCE` Variable**

| Syntax              | Description                                                | Example                             |
| ------------------- | -----------------------------------------------------------| ----------------------------------- |
| `${BASH_SOURCE[0]}` | Path of the **currently executing script or sourced file** | `echo "${BASH_SOURCE[0]}"`          |
| `${BASH_SOURCE[1]}` | Path of the **caller** of the current script or function   | `echo "${BASH_SOURCE[1]}"`          |
| `${BASH_SOURCE[@]}` | Array of all source filenames in the call stack,           | `printf '%s\n' "${BASH_SOURCE[@]}"` |
|                     | **\[0] = current, higher indices = callers**               |                                     |

**Details:**

* `BASH_SOURCE` is a **Bash-only array variable**, populated automatically at runtime.
* Unlike `$0`, it always points to the real script file, even if the script was **sourced** or called from another location.
* Useful for finding the **script’s own directory**:

```bash
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
echo "This script lives in: $script_dir"
```

**Example with sourcing:**

```bash
# file: helper.sh
echo "helper.sh path: ${BASH_SOURCE[0]}"

# file: main.sh
source ./helper.sh
```

Output:

```
helper.sh path: ./helper.sh
```

(`$0` would show `main.sh` in this case, but `BASH_SOURCE[0]` still shows `helper.sh`.)

---

## ✅ **Summary Table**

### 🔹 Parameter Expansion Features

| Feature             | Syntax                 | Description                        |
| ------------------- | ---------------------- | ---------------------------------- |
| Default value       | `${VAR:-default}`      | Use default if unset/null          |
| Assign default      | `${VAR:=default}`      | Assign if unset/null               |
| Alternate value     | `${VAR:+alt}`          | Use alt if set                     |
| Error on unset      | `${VAR:?error}`        | Exit with error if unset/null      |
| Remove (start)      | `${VAR#pattern}`       | Remove shortest prefix             |
| Remove (start) long | `${VAR##pattern}`      | Remove longest prefix              |
| Remove (end)        | `${VAR%pattern}`       | Remove shortest suffix             |
| Remove (end) long   | `${VAR%%pattern}`      | Remove longest suffix              |
| Replace first       | `${VAR/pattern/repl}`  | Replace first match                |
| Replace all         | `${VAR//pattern/repl}` | Replace all matches                |
| Replace prefix      | `${VAR/#pattern/repl}` | If starts with pattern             |
| Replace suffix      | `${VAR/%pattern/repl}` | If ends with pattern               |
| Substring           | `${VAR:offset}`        | From offset                        |
| Substring w/ length | `${VAR:offset:length}` | From offset, with length           |
| Length              | `${#VAR}`              | Length of value                    |
| Indirect expansion  | `${!VAR}`              | Value of the variable named by VAR |

---

### 🔹 Case Modification (Bash 4.0+)

| Feature               | Syntax     | Description             |
| --------------------- | ---------- | ----------------------- |
| Capitalize first char | `${VAR^}`  | Capitalize first letter |
| Capitalize all chars  | `${VAR^^}` | Uppercase entire value  |
| Lowercase first char  | `${VAR,}`  | Lowercase first letter  |
| Lowercase all chars   | `${VAR,,}` | Lowercase entire value  |

---

### 🔹 Special Parameters

| Parameter            | Syntax              | Description                                     |
| -------------------- | ------------------- | ----------------------------------------------- |
| Script name          | `$0`                | Name of the script                              |
| First argument       | `$1`                | First positional argument                       |
| Second argument      | `$2`                | Second positional argument                      |
| Argument count       | `$#`                | Number of positional arguments                  |
| All args (separate)  | `$@`                | All arguments as separate words                 |
| All args (single)    | `$*`                | All arguments as single string                  |
| PID of script        | `$$`                | PID of current script/process                   |
| PID of last bg job   | `$!`                | PID of last background command                  |
| Exit status          | `$?`                | Exit status of last command                     |
| Last arg of last cmd | `$_`                | Last argument of previous command               |
| Current script path  | `${BASH_SOURCE[0]}` | Path of current script or sourced file          |
| Caller script path   | `${BASH_SOURCE[1]}` | Path of caller script/function in call stack    |
| Call stack paths     | `${BASH_SOURCE[@]}` | All source file paths in the current call stack |

---
