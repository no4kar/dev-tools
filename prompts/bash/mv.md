
---

### ✅ `mv` – Move or Rename Files and Folders

The `mv` command is used in Unix/Linux to **move files/directories** or **rename them**.

---

## 📦 Move a File to Another Directory

```bash
mv myfile.txt ./backup/
```

* Moves `myfile.txt` into the `backup/` folder.

---

## ✏️ Rename a File

```bash
mv report.txt final-report.txt
```

* Renames `report.txt` to `final-report.txt` in the same directory.

---

## 📁 Move a Directory

```bash
mv ./temp ./archive/old-temp
```

* Moves the `temp/` directory into `archive/` and renames it to `old-temp`.

---

## ⚠️ Overwrite Without Prompt

```bash
mv -f file1.txt file2.txt
```

* `-f` (force): Overwrites `file2.txt` without asking.

---

## 🛑 Prompt Before Overwriting

```bash
mv -i file1.txt file2.txt
```

* `-i` (interactive): Asks before overwriting `file2.txt`.

---

## ♻️ Move Multiple Files into a Folder

```bash
mv file1.txt file2.txt file3.txt ./archive/
```

* Moves all three files into the `archive/` directory.

---

Let me know if you want one for `cp`, `rm`, or other common Bash utilities!
