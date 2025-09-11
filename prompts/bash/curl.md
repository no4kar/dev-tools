
---

### ✅ `curl` – Make HTTP Requests from the Command Line

`curl` is a command-line tool for transferring data with URLs — perfect for testing APIs.

---

## 📤 Send a `POST` Request with JSON Body

```bash
curl -X POST http://localhost:3001/employees \
  -H "Content-Type: application/json" \
  -d '{"id": 1, "name": "John Doe", "position": "Developer"}'
```

This sends a new `employee` object to your API.

---

## 📥 `GET` Request with Query Parameters

```bash
curl -X GET "http://localhost:3005/candidates?firstName=John%20Doe&email=some@email.com"
```

Use `?key=value` syntax for query strings. Encode spaces with `%20`.

---

## 🔐 Use `--data-urlencode` to Safely Encode Query Params

```bash
curl --get \
  --data-urlencode "phoneNumber=\+48" \
  --data-urlencode "page=1" \
  --data-urlencode "size=5" \
  "http://localhost:3005/candidates" \
  -o ./src/db/res.json
```

* `--get`: Forces a `GET` request
* `--data-urlencode`: Automatically encodes special characters
* `-o`: Saves the response to a file

---

## 🖨️ Read Saved JSON Response from File

```bash
node -e "console.log(JSON.stringify(require('./src/db/res.json'), null, 2))"
```

This prints the content in a pretty-printed format.

---

## 🌍 Get Your Public IP Address

```bash
curl -s ipinfo.io/ip
```

* `-s`: Silent mode
* Returns your current external IP address

---

## 📸 Upload a File using **multipart/form-data**

```bash
curl -X POST http://localhost:3000/api/v1/images \
  -F "image=@/mnt/c/Users/Bahtijar/Downloads/DoOrDoNotThereIsNoTry.jpg"
```

This uploads a file using **multipart/form-data**, the same way a browser form would.  

- `-F` tells `curl` to send the request as a form.  
- `image=` is the field name expected by the server (e.g., `req.file` in Express with Multer).  
- `@/path/to/file.jpg` reads the file from disk and includes it in the request body.  

---

