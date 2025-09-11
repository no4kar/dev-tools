## 🛠 Steps to Set It Up

1. **Create a new Git repo**

   ```bash
   mkdir your_project_name && cd your_project_name
   git init
   ```

2. **Create a `README.md`**
   Explain what this repo is, how to navigate the folders, and optionally how to contribute.

3. **Create `.gitignore`**
   If you're not using compiled files, just ignore:

   ```
   node_modules/
   .DS_Store
   ```

4. **Commit and push to GitHub**

   ```bash
   git add .
   git commit -m "Initial commit of prompt collection"
   git remote add origin https://github.com/your_username/your_project_name.git
   git push -u origin main
   ```

---
