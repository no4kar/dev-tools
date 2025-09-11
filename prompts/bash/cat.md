## ✅ Correct `cat` Command (for Bash / Git Bash / MINGW64)

Use this version **without backslashes** around the JSON block:

```bash
cat > ./src/appsscript.json <<EOF
{
  "timeZone": "Europe/Warsaw",
  "exceptionLogging": "STACKDRIVER",
  "runtimeVersion": "V8"
}
EOF
```

This writes valid JSON directly to `./src/appsscript.json`.

---

## ✅ Check Your File

To verify the content:

```bash
cat ./src/appsscript.json
```

It should show exactly:

```json
{
  "timeZone": "Europe/Warsaw",
  "exceptionLogging": "STACKDRIVER",
  "runtimeVersion": "V8"
}
```

---

## ✅ Append to file

```bash
cat >> /d/path/to/your/.env <<EOF
JWT_COMMON_SECRET=5a2f7c1e-8b6d-4c39-a2cf-73d64ae72895
GOOGLE_CREDS_JWT=eyJhbGciOi...
EOF
```

> `>>` means **append** instead of `>` (which overwrites).

---
