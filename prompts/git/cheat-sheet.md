
# 🐙 Git Cheat Sheet

Quick reference for common Git commands, aliases, and workflows.

---

## 📋 Quick Table

| Command | Description |
|---------|-------------|
| `git config --global --get-regexp alias` | Show global aliases |
| `git config --global alias.phom "push origin main"` | Alias for `git push origin main` |
| `git config --global alias.ow '!...'` | Alias for amend + force push |
| `git remote get-url origin` | Show current origin URL |
| `git remote set-url origin <new-url>` | Set a new origin URL |
| `git add . && git commit --amend --no-edit && git push --force-with-lease` | Amend last commit & safely force push |
| `git merge --abort` | Abort an in-progress merge |
| `git checkout <commit>` | Switch to specific commit |
| `git reset --hard <commit>` | Reset to specific commit (discard changes) |
| `git log main..develop --oneline` | Show commits in `develop` not in `main` |
| `git diff --stat main..develop` | Show file diff summary between branches |
| GitHub: `/compare/main...develop` | Compare branches in browser |
| `git branch -m master main` | Rename branch `master` → `main` |
| `git rm --cached .env` | Stop tracking `.env` but keep file locally |
| `git stash` | Save current changes |
| `git stash pop` | Restore last stashed changes |
| `git log --oneline --graph --decorate --all` | Pretty commit tree |
| `git show <commit>` | Show details of a commit |
| `git blame <file>` | Show who changed each line |
| `git diff` / `git diff --cached` | Show unstaged/staged changes |
| `git clean -fd` | Remove untracked files & dirs |
| `git restore <file>` | Discard changes in a file |
| `git restore --staged <file>` | Unstage a file |
| `git revert <commit>` | Undo a commit with a new commit |
| `git fetch` | Download refs/objects but don’t merge |
| `git pull --rebase origin main` | Rebase local branch onto remote |
| `git push -u origin main` | Push and set upstream |

---

## ⚡ Aliases

```bash
git config --global --get-regexp alias
git config --global alias.phom "push origin main"
git config --global alias.ow '!git commit --amend --no-edit && git push --force'
```

```bash
git config --global --get-regexp alias

alias.ci commit
alias.co checkout
alias.br branch
alias.st status
alias.sw switch
alias.lg log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches
alias.rst-stgd restore --staged
alias.phod push origin develop
alias.plod pull origin develop
alias.phom push origin main
alias.plom pull origin main
alias.ow commit --amend --no-edit
```

---

## 🌍 Remote Management

```bash
git remote get-url origin
git remote set-url origin <new-url>
```

---

## 💾 Commits & Push

```bash
git add . && git commit --amend --no-edit && git push --force-with-lease
```

---

## 🔀 Merging

```bash
git merge --abort
```

---

## ⏪ Reset & Checkout

```bash
git checkout <commit>
git reset --hard <commit>
```

---

## 🔍 Comparing Branches

```bash
git log main..develop --oneline
git diff --stat main..develop
https://github.com/<your-username>/<repo>/compare/main...develop
```

---

## 🌱 Branch Management

```bash
git branch -m master main
```

---

## 🛡️ Ignore Sensitive Files

```bash
git rm --cached .env
```

---

## 📝 Stashing

```bash
git stash              # Save changes (tracked files only)
git stash -u           # Save changes incl. untracked files
git stash pop          # Apply and remove the latest stash
git stash list         # Show stashes
git stash drop stash@{0}   # Delete a stash
```

---

## 🕒 Logs & History

```bash
git log --oneline --graph --decorate --all   # Pretty commit tree
git show <commit>                            # Show commit details
git blame <file>                             # Show who changed each line
```

---

## 🔎 Inspecting Changes

```bash
git diff                   # Show unstaged changes
git diff --cached          # Show staged changes
git diff <commit1> <commit2>   # Compare two commits
```

---

## 🧹 Cleanup

```bash
git clean -fd              # Remove untracked files & directories
```

---

## 🔄 Undoing

```bash
git restore <file>         # Discard changes in a file
git restore --staged <file> # Unstage a file
git revert <commit>        # Undo a commit with a new commit
```

---

## 🌐 Sync with Remote

```bash
git log HEAD..origin/main --oneline
git fetch                       # Download refs/objects but don’t merge
git pull --rebase origin main   # Rebase local branch onto remote
git push -u origin main         # Push and set upstream
```

---

## ✅ Notes

* Prefer `--force-with-lease` over `--force` to avoid overwriting others’ commits.
* Use `stash` when you need to save changes without committing.
* `revert` is safer than `reset --hard` when working with shared branches.
* Always coordinate with your team before rewriting history.

```

---

⚡ This cheat sheet is now **battle-ready**: aliases, commits, branching, remotes, merges, stash, inspection, cleanup, undo, syncing — all in one place.  

Do you also want me to add a **section about rebasing & interactive rebase** (`git rebase -i`) for cleaning commit history before pushing?
```
