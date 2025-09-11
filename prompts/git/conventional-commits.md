# 🚀 Git Commit Message Guide

Follow the **Conventional Commits** style to keep history clean and meaningful.

---

## Common Commit Types

### ✨ feat: A new feature for the user
- **Example:** `feat(auth): add user login functionality`
- **Prompt:** `feat(<scope>): <short description>`

---

### 🐛 fix: A bug fix for the user
- **Example:** `fix(api): handle null values in user endpoint`
- **Prompt:** `fix(<scope>): <short description>`

---

### 📝 docs: Documentation updates or changes
- **Example:** `docs: update README with installation instructions`
- **Prompt:** `docs(<scope>): <short description>`

---

### 🎨 style: Code style changes (formatting, spacing, missing semicolons, etc.), not affecting functionality
- **Example:** `style: format code according to ESLint rules`
- **Prompt:** `style(<scope>): <short description>`

---

### ♻️ refactor: Code changes that neither fix a bug nor add a feature, but improve the codebase
- **Example:** `refactor: simplify user authentication logic`
- **Prompt:** `refactor(<scope>): <short description>`

---

### ✅ test: Adding or updating tests
- **Example:** `test(auth): add unit tests for login component`
- **Prompt:** `test(<scope>): <short description>`

---

### 🔧 chore: Changes to build process, tooling, or auxiliary libraries
- **Example:** `chore(deps): update dependencies`
- **Prompt:** `chore(<scope>): <short description>`

---

## Extra Useful Types

### 📦 build: Changes that affect the build system or external dependencies
- **Example:** `build(docker): add Dockerfile for production`
- **Prompt:** `build(<scope>): <short description>`

---

### 🚚 ci: Changes to CI/CD configuration files and scripts
- **Example:** `ci(github-actions): add Node.js workflow`
- **Prompt:** `ci(<scope>): <short description>`

---

### 🗑️ revert: Reverts a previous commit
- **Example:** `revert: revert "feat(auth): add user login functionality"`
- **Prompt:** `revert: <commit-hash> <short description>`

---

### 🔒 security: Security fixes or patches
- **Example:** `security(auth): sanitize user input to prevent XSS`
- **Prompt:** `security(<scope>): <short description>`

---

## Commit Message Template

```txt
<type>(<scope>): <short summary>

[optional body: explain *what* and *why*]

[optional footer: issue references, breaking changes]
