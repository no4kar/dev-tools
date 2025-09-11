#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
// import { fileURLToPath } from 'node:url';

// Needed for ES module __dirname workaround
// const __filename = fileURLToPath(import.meta.url);
// const __dirname = path.dirname(__filename);

// -------------------------
// Default configuration
// -------------------------
let EXCLUDES = 'node_modules|\\.git|\\.vscode|__test__';
let OUTFILE = null;
let ROOT = '.';

// -------------------------
// Parse CLI-style arguments
// -------------------------
const args = process.argv.slice(2);

for (const arg of args) {
  const [key, value] = arg.split('=');

  switch (key) {
    case '--exclude': {
      EXCLUDES = value;
      break;
    }
    case '--outfile': {
      OUTFILE = value;
      break;
    }
    case '--root': {
      ROOT = value;
      break;
    }
    default: {
      console.error(`Unknown option: ${arg}`);
      process.exit(1);
    }
  }
}

const EXCLUDE_REGEX = new RegExp(`(${EXCLUDES})(/|$)`);
ROOT = path.resolve(ROOT);
const VISITED = new Set();

// -------------------------
// Prepare output file
// -------------------------
if (OUTFILE) {
  try {
    const outDir = path.dirname(OUTFILE);

    if (fs.existsSync(outDir) || path.isAbsolute(OUTFILE)) {
      fs.writeFileSync(OUTFILE, '');
    } else {
      OUTFILE = null;
    }
  } catch (err) {
    console.error('Failed to prepare output file:', err);
    OUTFILE = null;
  }
}

// -------------------------
// Tree printing function
// -------------------------
function printTree(dir, prefix = '') {
  const absDir = path.resolve(dir);
  if (VISITED.has(absDir)) return;
  VISITED.add(absDir);

  let entries;
  try {
    entries = fs.readdirSync(absDir)
      .map(e => path.join(absDir, e))
      .filter(e => !EXCLUDE_REGEX.test(e));
  } catch {
    return;
  }

  // entries = entries.filter(e => !EXCLUDE_REGEX.test(e));
  // entries.sort((a, b) => a.localeCompare(b));

  entries.forEach((entry, index) => {
    const isDir = fs.existsSync(entry) && fs.statSync(entry).isDirectory();
    const name = path.basename(entry);
    const isLast = index === entries.length - 1;
    const connector = isLast ? '└─' : '├─';
    const line = `${prefix}${connector} ${name}${isDir ? '/' : ''}`;

    if (OUTFILE) {
      fs.appendFileSync(OUTFILE, line + '\n');
    } else {
      console.log(line);
    }

    if (isDir) {
      const newPrefix = prefix + (isLast ? '  ' : '│ ');
      printTree(entry, newPrefix);
    }
  });
}

// -------------------------
// Start it
// -------------------------
printTree(ROOT);
