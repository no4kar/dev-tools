Understanding the difference between `cmd.exe` and `powershell.exe` is essential for scripting and automation on Windows.

---

## 🧱 **1. `cmd.exe` (Command Prompt)**

### 🔹 Overview:

* The **original** Windows shell, present since MS-DOS days.
* Very basic scripting capabilities.
* Syntax similar to DOS (`.bat`, `.cmd` scripts).
* Still widely used for simple automation and legacy scripts.

### ✅ Example:

```cmd
echo Hello from CMD
set MY_VAR=value
echo %MY_VAR%
```

---

## ⚡ **2. `powershell.exe` (Windows PowerShell)**

### 🔹 Overview:

* Introduced in 2006.
* A **powerful object-oriented shell and scripting language**.
* Supports complex logic, .NET integration, JSON parsing, remote management, etc.
* Has much **richer syntax** than `cmd.exe`.

### ✅ Example:

```powershell
Write-Output "Hello from PowerShell"
$myVar = "value"
Write-Output $myVar
```

---

## 🔍 Key Differences

| Feature             | `cmd.exe`                | `powershell.exe`                          |
| ------------------- | ------------------------ | ----------------------------------------- |
| 🛠 Default Shell    | Legacy shell for Windows | Modern shell for automation               |
| 📦 Output Type      | Strings only             | .NET objects (can still output strings)   |
| 🧠 Variable Syntax  | `%VAR%`                  | `$var`                                    |
| 🧾 Script File Ext  | `.bat` / `.cmd`          | `.ps1`                                    |
| 📡 Remote Execution | Limited                  | Built-in support (e.g., `Invoke-Command`) |
| 📜 JSON Support     | No                       | Built-in (`ConvertFrom-Json`, etc.)       |
| 🔗 Integration      | Very limited             | Deep .NET, WMI, REST API integration      |

---

## ⚠️ Practical Implications in Node.js (`child_process.exec`)

| Use Case                       | Recommended Shell     |
| ------------------------------ | --------------------- |
| Run simple Windows commands    | `cmd.exe`             |
| Run advanced scripts / JSON    | `powershell.exe`      |
| Port Linux scripts to Git Bash | Git Bash (`bash.exe`) |

### Example with `cmd.exe`:

```js
exec('echo %USERNAME%', { shell: 'cmd.exe' });
```

### Example with `powershell.exe`:

```js
exec('Write-Output $env:USERNAME', { shell: 'powershell.exe' });
```

---

## 🆕 Bonus: PowerShell Core (`pwsh`)

If you're using **PowerShell Core (cross-platform)**, it installs `pwsh`:

```bash
pwsh -Command "Get-Process"
```

Use this if you're targeting macOS/Linux/Windows compatibility.

---

## ✅ Conclusion

| Use `cmd.exe` when:                                                           |
| ----------------------------------------------------------------------------- |
| You need compatibility with legacy `.bat` files or extremely simple scripting |

| Use `powershell.exe` when:                                                |
| ------------------------------------------------------------------------- |
| You want a powerful, modern shell with objects, scripting, and API access |
