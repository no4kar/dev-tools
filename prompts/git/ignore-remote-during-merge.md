
---

### Option 1: Keep all your local changes (ignore remote during merge)

If you’re in the middle of a merge (like you are now, `MERGING`):

```bash
git merge --abort
```

(Stops the merge attempt.)

Then tell Git to always prefer **local changes** when pulling:

```bash
git pull origin main --strategy-option=ours
```

* `ours` = take your local version whenever there’s a conflict.
* Remote changes will be ignored in conflicting files.

After that, just:

```bash
git commit -m "Keep local changes, ignore remote"
git push
```

---

### Option 2: Force your local branch over remote

If you don’t care about losing remote changes at all:

```bash
git push origin main --force
```

⚠️ This will **overwrite origin** with your local branch. Use carefully if you’re working with teammates.

---

### Option 3: During conflict, resolve file-by-file

If you only want to keep your version for certain files:

```bash
git checkout --ours path/to/file.js
git add path/to/file.js
```

(do this for every file you want to keep your version)
Then:

```bash
git commit
```

---

✅ Recommended if it’s just you: Option 1 (safer).
⚠️ Be careful with Option 2 if collaborating.
