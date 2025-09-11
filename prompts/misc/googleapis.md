Great — let’s walk step-by-step through setting up a **Node.js + Express server that interacts securely with a Google Sheet**, including reading and writing data.

---

## 🛠️ Goal

You want a **Node.js + Express API** that can:

* ✅ Connect to a specific **Google Sheet**
* ✅ **Read and write** data
* ✅ Work with **private** Google Sheets using **secure authentication**

---

## ✅ Overview of Steps

1. **Create a Google Sheet**
2. **Create a Google Cloud Project + Service Account**
3. **Share your sheet with the Service Account**
4. **Install Google Sheets API in Node.js**
5. **Set up your Express server to use the Google Sheets API**
6. **Write API endpoints to read/write the sheet**

---

## 🔍 Step 1: Create Your Google Sheet

1. Go to [Google Sheets](https://sheets.google.com)
2. Create a new sheet, e.g., named `EmployeeData`
3. Note the **Sheet ID** from the URL:

   ```
   https://docs.google.com/spreadsheets/d/THIS_IS_YOUR_SHEET_ID/edit
   ```

---

## 🔐 Step 2: Set Up Google Cloud & Service Account

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or use an existing one)

### Enable Sheets API:

* Go to: `APIs & Services` → `Enable APIs and Services`
* Search for and enable **Google Sheets API**

### Create a Service Account:

* Go to: `IAM & Admin` → `Service Accounts`
* Click "Create Service Account"
* Give it a name (e.g., `sheets-accessor`)
* Choose “Editor” role or more restricted as needed

### Create Key:

* After creating the account, go to “Keys” tab
* Click “Add Key” → **Create new key** → **JSON**
* This will download a file like `your-project-name-123456.json`

---

## 📤 Step 3: Share Sheet with the Service Account

1. Open your Google Sheet
2. Click "Share"
3. Add the service account email (found in the JSON file under `"client_email"`)
4. Give it **Editor** access

---

## 📦 Step 4: Install Dependencies in Node.js

```bash
npm init -y
npm install express googleapis
```

Place your downloaded JSON key file somewhere safe (e.g., `./keys/service-account.json`).

---

## 🚀 Step 5: Express Server + Google Sheets API

Create `server.js`:

```js
const express = require('express');
const { google } = require('googleapis');
const app = express();
app.use(express.json());

const SHEET_ID = 'YOUR_SHEET_ID_HERE';
const KEY_PATH = './keys/service-account.json';

const auth = new google.auth.GoogleAuth({
  keyFile: KEY_PATH,
  scopes: ['https://www.googleapis.com/auth/spreadsheets']
});

async function getSheetClient() {
  const client = await auth.getClient();
  return google.sheets({ version: 'v4', auth: client });
}
```

---

## 🔍 Step 6: Add Routes

### ✅ GET: Read Sheet Data

```js
app.get('/data', async (req, res) => {
  try {
    const sheets = await getSheetClient();
    const result = await sheets.spreadsheets.values.get({
      spreadsheetId: SHEET_ID,
      range: 'Sheet1!A1:C10' // adjust range as needed
    });

    res.json({ data: result.data.values });
  } catch (err) {
    console.error('Read error:', err.message);
    res.status(500).send('Failed to read sheet');
  }
});
```

---

### ✏️ POST: Write to Sheet

```js
app.post('/data', async (req, res) => {
  const { values } = req.body; // e.g., [["Alice", "Developer", 30]]
  if (!Array.isArray(values)) return res.status(400).send('Invalid data');

  try {
    const sheets = await getSheetClient();
    const result = await sheets.spreadsheets.values.append({
      spreadsheetId: SHEET_ID,
      range: 'Sheet1!A:C',
      valueInputOption: 'RAW',
      requestBody: {
        values
      }
    });

    res.json({ status: 'success', updates: result.data.updates });
  } catch (err) {
    console.error('Write error:', err.message);
    res.status(500).send('Failed to write to sheet');
  }
});
```

---

## ▶️ Start Server

Add this to the end of `server.js`:

```js
app.listen(3000, () => {
  console.log('Server running at http://localhost:3000');
});
```

Run it:

```bash
node server.js
```

Test routes:

* `GET http://localhost:3000/data`
* `POST http://localhost:3000/data` with JSON body:

```json
{
  "values": [
    ["Charlie", "Engineer", 29]
  ]
}
```

---

## ✅ Done!

You now have a secure, functional Google Sheets integration using Node.js!

---

### 💡 Optional Next Steps

* Add caching or batching for performance
* Integrate with Google Charts, GViz, etc.
* Add Google OAuth for user-specific sheet access

Would you like a version of this with Google OAuth (instead of service accounts) for per-user access?
