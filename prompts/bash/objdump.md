## ✅ Correct `objdump` Command (for Bash / Git Bash / MINGW64)

 → shows printf as an imported dynamic symbol.
```bash
objdump -T your_program | grep 'printf'
```

→ tells you which .so library provides it.
```bash
ldd your_program
```

→ confirms its actual location in the library.
```bash
objdump -T /path/to/libc.so.6 | grep 'printf'
```

→ dissasembling the needed section.
```bash
objdump -d --section=.name your_program
```

---
