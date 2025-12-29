# 🔬 Disassembly, Symbol Inspection, and Binary Patching

This document explains how to **locate instructions with `objdump`**, inspect symbols and libraries, and **apply raw patches** to a binary using `dd`.

---

## ✅ Disassemble a Specific Section and Search for a Pattern

```bash
objdump -d --section=.name your_program | grep -B2 -A3 'looking pattern'
```

---

## 🔍 What This Command Does

### `objdump -d`

* Disassembles machine code into assembly instructions
* Converts raw opcodes into readable mnemonics

---

### `--section=.name`

Limits disassembly to a specific ELF section.

Common sections:

| Section | Purpose                |
| ------- | ---------------------- |
| `.text` | Main executable code   |
| `.plt`  | Dynamic function stubs |
| `.init` | Program initialization |

---

### `grep -B2 -A3 'looking pattern'`

* Searches for a known instruction, address, or symbol
* Shows surrounding context:

  * **2 lines before**
  * **3 lines after**

📌 Used to identify **exact patch locations**.

---

## ✅ Inspect Dynamic Symbols Used by the Binary

```bash
objdump -T your_program | grep 'printf'
```

---

## 🔍 What This Command Does

### `objdump -T`

* Displays the **dynamic symbol table**
* Shows symbols resolved at runtime via the loader

---

### `grep 'printf'`

Confirms whether:

* `printf` is imported dynamically
* The binary uses libc I/O functions
* The function call goes through the PLT/GOT

---

## ✅ List Shared Library Dependencies

```bash
ldd your_program
```

---

## 🔍 What This Command Does

* Lists all shared libraries required by the program
* Shows resolved filesystem paths

📌 Important for identifying:

* Which `libc.so.6` is loaded
* Environment‑specific behavior

---

## ✅ Locate a Symbol Inside libc

```bash
objdump -T /path/to/libc.so.6 | grep 'printf'
```

---

## 🔍 What This Command Does

* Searches libc’s exported symbols
* Shows symbol versioning

Example:

```text
printf@@GLIBC_2.2.5
```

📌 Symbol versions must match at runtime or execution will fail.

---

## ✅ Fully Disassemble a Section

```bash
objdump -d --section=.name your_program
```

---

## 🔎 What to Look For

* Function prologues and epilogues
* Conditional branches
* Calls into `.plt`

This output is typically used to determine:

* Instruction offsets
* Instruction lengths
* Patch targets

---

## ✅ Patch Arbitrary Data into a Binary Using `dd`

```bash
printf 'changes' | dd of=your-program bs=1 seek=$((0xaddress-in-program)) conv=notrunc
```

---

## 🔍 What This Command Does

### `printf 'changes'`

* Outputs **raw bytes** exactly as written
* Each character corresponds to one byte:

  ```text
  63 68 61 6e 67 65 73
  ```

📌 This can be:

* ASCII data
* Opcodes
* Padding
* Overwrites for strings or instructions

---

### `dd`

Writes raw bytes directly into the binary.

| Option                      | Meaning                      |
| --------------------------- | ---------------------------- |
| `of=your-program`           | Target binary file           |
| `bs=1`                      | Write **one byte at a time** |
| `seek=0xaddress-in-program` | File offset to begin writing |
| `conv=notrunc`              | Preserve file size           |

📌 The write occurs **in‑place**, starting at the specified offset.

---

## ⚠️ Critical Warnings

### Instruction Corruption

* x86 instructions are **variable‑length**
* Overwriting partial instructions will:

  * Corrupt decoding
  * Break control flow
  * Likely crash the program

✅ Always confirm instruction boundaries with `objdump`.

---

### Overwriting Strings or Data

* Ensure replacement data is:

  * Equal or shorter in length
  * Properly null‑terminated if required

---

## ✅ Verify the Patch

Always re‑disassemble or inspect after patching:

```bash
objdump -d your-program | grep -A3 0xaddress-in-program
```

or inspect raw bytes:

```bash
xxd -s 0xaddress-in-program your-program
```

---

## ✅ Typical Workflow

1. Disassemble with `objdump`
2. Locate offset and instruction length
3. Patch using `dd`
4. Verify changes
5. Execute and test

---
