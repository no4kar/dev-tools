## ✅ Patch an Instruction in a Binary Using `dd`

This example replaces the instruction:

```asm
test %eax, %eax   ; opcode: 85 c0
````

with:

```asm
xor %eax, %eax    ; opcode: 31 c0
```

This forces a comparison result to **always succeed**.

---

## ✅ Patch Command

```bash
printf '\x31\xc0' | dd of=./build/c_lab bs=1 seek=$((0x1260)) conv=notrunc
```

---

## 🔍 What This Command Does

### `printf '\x31\xc0'`

* Outputs **raw machine code bytes**
* `\x31\xc0` is the x86 opcode for:

  ```asm
  xor eax, eax
  ```

---

### `dd`

Writes raw bytes directly into a file.

| Option             | Meaning                               |
| ------------------ | ------------------------------------- |
| `of=./build/c_lab` | Target binary file                    |
| `bs=1`             | Write **1 byte at a time**            |
| `seek=0x1260`      | Start writing at file offset `0x1260` |
| `conv=notrunc`     | Do **not truncate** the file          |

📌 Result:
The two bytes at offset `0x1260` are replaced **in-place**.

---

## ⚠️ Why Both Bytes Must Be Replaced

Original instruction:

```
85 c0   → test eax, eax
```

Replacement instruction:

```
31 c0   → xor eax, eax
```

x86 instructions are **variable-length** and decoded as a unit.
Replacing only one byte may:

* Corrupt the instruction
* Change operands
* Cause a crash or undefined behavior

✅ **Always overwrite the full instruction length**

---

## ✅ Verify the Patch

Re-disassemble the binary to confirm:

```bash
objdump -d ./build/c_lab | grep -A3 1260
```

You should now see:

```asm
xor %eax, %eax
```

---
