Perfect — here's how to set up a **bundled Google Apps Script project using `clasp`, modern JavaScript (with `import/export`), and a build system like `esbuild`**.

---

## ✅ Goal

* Write modular code using `import/export`
* Bundle it all into a flat `.js` or `.gs` file
* Push that to Google Apps Script using `clasp`

---

## 🧱 Project Structure (after setup)

```
my-app/
├── dist/                     # Output folder for clasp (pushed to Apps Script)
│   ├── appsscript.json       # Manifest
│   └── code.js               # Bundled output
├── src/                      # Your actual source files
│   ├── main.js               # Entry point
│   └── utils/
│       └── logger.js
├── .clasp.json
├── package.json
├── esbuild.config.js
└── tsconfig.json             # optional, for TS support
```

---

## 🚀 Step-by-Step Setup

### 1. ✅ Initialize project & install tools

```bash
npm init -y
npm install --save-dev esbuild
npm install -g clasp
```

---

### 2. ✅ Create folders

```bash
mkdir src dist src/utils
```

---

### 3. ✅ Example modular source files

#### `src/utils/logger.js`

```js
export function logger(msg) {
  console.log(`[LOG]: ${msg}`);
}
```

#### `src/main.js`

```js
import { logger } from './utils/logger.js';

globalThis.showRowByData = () => {
  const name = 'TARNOVETSKYI TARAS';
  const date = '14.07.2023';
  logger(`Looking up row for ${name} on ${date}`);
};
```

> Note: We assign the exported function to `globalThis` so it’s available in the Apps Script runtime.

---

### 4. ✅ `esbuild.config.js` (Create this)

```js
const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['./src/main.js'],
  bundle: true,
  outfile: './dist/code.js',
  format: 'iife',
  target: ['es6'],
  banner: {
    js: '// Compiled with esbuild',
  },
}).catch(() => process.exit(1));
```

---

### 5. ✅ `appsscript.json` (in `dist/`)

Create `dist/appsscript.json`:

```json
{
  "timeZone": "Europe/Warsaw",
  "exceptionLogging": "STACKDRIVER",
  "runtimeVersion": "V8"
}
```

---

### 6. ✅ `.clasp.json`

```json
{
  "scriptId": "your-script-id-here",
  "rootDir": "dist"
}
```

---

### 7. ✅ Add build scripts to `package.json`

```json
"scripts": {
  "build": "node esbuild.config.js",
  "push": "npm run build && clasp push",
  "watch": "esbuild --bundle src/main.js --outfile=dist/code.js --format=iife --watch"
}
```

---

### 8. ✅ Run it!

```bash
npm run push      # builds and pushes to Apps Script
npm run watch     # watches for changes
```

Then go to:

```bash
clasp open
```

And run the `showRowByData()` function from the Apps Script Editor.

---

## ✅ Summary

| Task               | Command         |
| ------------------ | --------------- |
| Build and push     | `npm run push`  |
| Watch & auto-build | `npm run watch` |
| Open in browser    | `clasp open`    |

---
