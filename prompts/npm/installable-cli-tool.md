Turning your JavaScript script into an **installable CLI tool** means making it usable from **anywhere in the terminal**, just like system commands (`ls`, `git`, `npm`, etc.). Instead of calling it with:

```bash
node treegen-flags.js --root=.
```

You’ll be able to run it like:

```bash
treegen --root=.
```

This is super helpful when you want to reuse your tool often or share it with others.

---

### ✅ Step-by-Step: Make Your JS Script an Installable CLI Tool

---

### 1. **Create a Project Folder (if needed)**

```bash
mkdir treegen-cli
cd treegen-cli
```

---

### 2. **Initialize a Node.js Project**

```bash
npm init -y
```

This creates a `package.json` file.

---

### 3. **Rename and Update Your Script**

Create a file called `treegen.js` (or move your script into it), and **add this special line at the very top**:

```js
#!/usr/bin/env node
```

This tells the system that your script should be run using Node.js — like a shell script.

✅ Make sure the file has **execute permissions**:

```bash
chmod +x treegen.js
```

---

### 4. **Edit `package.json` to Declare the CLI Command**

In your `package.json`, add the `bin` field like this:

```json
{
  "name": "treegen-cli",
  "version": "1.0.0",
  "description": "A simple tree generator tool like `tree`, written in Node.js.",
  "main": "treegen.js",
  "bin": {
    "treegen": "./treegen.js"
  },
  "type": "module",
  "author": "Your Name",
  "license": "MIT"
}
```

* The `"treegen"` key is the **command** users will run.
* The `"./treegen.js"` is the path to your main script.

---

### 5. **Link It Locally (So It Works Like a Real Command)**

Run this in the root of your project:

```bash
npm link
```

This installs your tool globally on your system.

Now you can just type:

```bash
treegen --root=. --exclude=node_modules
```

…from **anywhere** in your terminal!

---

### 6. **(Optional) Publish to npm**

If you want others to install it via:

```bash
npm install -g treegen-cli
```

You can publish it to npm:

```bash
npm login
npm publish
```

Just make sure:

* The name in `package.json` is unique on npm (`treegen-cli` or similar).
* You’ve removed any private code or personal info.

---

### ✅ Summary

| Step                    | Purpose                                       |
| ----------------------- | --------------------------------------------- |
| `#!/usr/bin/env node`   | Makes it a CLI script                         |
| `chmod +x`              | Allows it to be executed                      |
| `bin` in `package.json` | Declares your custom command                  |
| `npm link`              | Makes it usable globally like a real CLI tool |

---

Let me know if you'd like a working `package.json` and `treegen.js` example bundled together!
