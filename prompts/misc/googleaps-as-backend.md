Here is the **fully aggregated CRUD system** using:

---

## ✅ Node.js (Express) + JSDoc

## ✅ Google Apps Script (as backend to Google Sheets)

---

> ✅ The Node.js side uses **plain JavaScript + JSDoc**
> ✅ The Google Apps Script handles all logic via `doPost()`
> ✅ Includes pagination, sorting, type validation, and metadata/type inference
> ✅ Also includes `.d.ts` generator for syncing sheet fields

---

# 🟩 1. Google Apps Script (`Code.gs`)

```js
function doPost(e) {
  const data = JSON.parse(e.postData.contents);
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Sheet1');
  const raw = sheet.getDataRange().getValues();
  const headers = raw[0];
  const records = raw.slice(1).map(r => Object.fromEntries(headers.map((h, i) => [h, r[i]])));

  function respond(payload, code = 200) {
    return ContentService
      .createTextOutput(JSON.stringify({ code, ...payload }))
      .setMimeType(ContentService.MimeType.JSON);
  }

  function inferType(records, key) {
    const sample = records.map(r => r[key]).filter(Boolean).slice(0, 10);
    if (sample.every(v => !isNaN(Number(v)))) return 'number';
    if (sample.every(v => /^\d{4}-\d{2}-\d{2}/.test(v))) return 'date';
    return 'string';
  }

  function validateItem(item, required = ['id']) {
    for (let k of required) {
      if (!item[k]) return `Missing required field: ${k}`;
    }
    return null;
  }

  switch (data.action) {
    case 'create': {
      const err = validateItem(data.item);
      if (err) return respond({ error: err }, 400);

      const row = headers.map(h => data.item[h] || '');
      sheet.appendRow(row);
      return respond({ status: 'created' });
    }

    case 'read': {
      let filtered = records;

      if (data.query && typeof data.query === 'object') {
        filtered = filtered.filter(r =>
          Object.entries(data.query).every(([k, v]) => r[k] == v)
        );
      }

      if (data.sortBy && headers.includes(data.sortBy)) {
        const dir = data.sortOrder === 'desc' ? -1 : 1;
        filtered.sort((a, b) => (a[data.sortBy] > b[data.sortBy] ? 1 : -1) * dir);
      }

      const page = parseInt(data.page || 1);
      const limit = parseInt(data.limit || 10);
      const offset = (page - 1) * limit;

      return respond({
        data: filtered.slice(offset, offset + limit),
        meta: { total: filtered.length, page, limit }
      });
    }

    case 'update': {
      const err = validateItem(data.item, ['id']);
      if (err) return respond({ error: err }, 400);

      const rowIndex = records.findIndex(r => r.id === data.item.id);
      if (rowIndex === -1) return respond({ error: 'Not found' }, 404);

      const values = headers.map(h => data.item[h] || '');
      sheet.getRange(rowIndex + 2, 1, 1, values.length).setValues([values]);

      return respond({ status: 'updated' });
    }

    case 'delete': {
      if (!data.id) return respond({ error: 'Missing ID' }, 400);

      const rowIndex = records.findIndex(r => r.id === data.id);
      if (rowIndex === -1) return respond({ error: 'Not found' }, 404);

      sheet.deleteRow(rowIndex + 2);
      return respond({ status: 'deleted' });
    }

    case 'meta': {
      return respond({
        headers,
        fields: headers.map(h => ({ key: h, type: inferType(records, h) }))
      });
    }

    default:
      return respond({ error: 'Unknown action' }, 400);
  }
}
```

---

# 🟦 2. Node.js Client (JSDoc + Express style)

/\*\* 📁 `googleSheetClient.js` \*/

```js
const axios = require('axios');

const SHEET_API_URL = 'YOUR_WEB_APP_DEPLOYMENT_URL';

/**
 * @template T
 * @param {string} action
 * @param {object} payload
 * @returns {Promise<T>} */
async function sendRequest(action, payload = {}) {
  const response
  = await axios.post(SHEET_API_URL, {
    action,
    ...payload
  });

  if (response.data.error) {
    throw new Error(`[${response.data.code}] ${response.data.error}`);
  }

  return response.data;
}

/** 🟢 CREATE
 * @param {object} item
 * @returns {Promise<object>} */
exports.createEmployee = async (item) => sendRequest('create', { item });

/** 🔵 READ ALL or by ID
 * @param {object} options
 * @returns {Promise<{ data: object[], meta: object }>} */
exports.readEmployees = async (options) => sendRequest('read', options);

/** 🟡 UPDATE
 * @param {object} item
 * @returns {Promise<object>} */
exports.updateEmployee = async (item) => sendRequest('update', { item });

/** 🔴 DELETE
 * @param {string} id
 * @returns {Promise<object>} */
exports.deleteEmployee = async (id) => sendRequest('delete', { id });

/**
 * @returns {Promise<{ headers: string[], fields: { key: string, type: string }[] }>} */
exports.getSheetMetadata = async () => sendRequest('meta', {});
```

---

# 🟨 3. Type Generator (Optional)

/\*\* 📁 `scripts/generateSheetTypes.js` \*/

```js
const fs = require('fs');
const path = require('path');
const { getSheetMetadata } = require('../googleSheetClient');

/**
 * @param {string} t
 * @returns {string} */
function mapToTSType(t) {
  if (t === 'number') return 'number';
  if (t === 'date') return 'Date | string';
  return 'string';
}

(async () => {
  const meta = await getSheetMetadata();
  const fields = meta.fields;

  const content = [
    'export interface EmployeeSheetRow {',
    ...fields.map(f => `  ${f.key}: ${mapToTSType(f.type)};`),
    '}'
  ].join('\n');

  const outPath = path.join(__dirname, '../types/EmployeeSheetRow.d.ts');
  fs.writeFileSync(outPath, content);
  console.log('✅ Generated types:', outPath);
})();
```

Add to `package.json`:

```json
"scripts": {
  "gen:types": "node scripts/generateSheetTypes.js"
}
```

---

# 🧪 Example Usage

```js
const {
  createEmployee,
  readEmployees,
  updateEmployee,
  deleteEmployee
} = require('./googleSheetClient');

(async () => {
  await createEmployee({ id: '1', name: 'Alice', age: 28 });

  const result = await readEmployees({
    query: { name: 'Alice' },
    sortBy: 'age',
    sortOrder: 'asc',
    page: 1,
    limit: 10
  });

  console.log(result.data);

  await updateEmployee({ id: '1', age: 29 });
  await deleteEmployee('1');
})();
```

---

## ✅ Summary

| Feature          | Supported?                               |
| ---------------- | ---------------------------------------- |
| Create           | ✅ via `action: 'create'`                 |
| Read all         | ✅ via `action: 'read'` + pagination      |
| Read by ID       | ✅ via `query: { id: '...' }`             |
| Query filter     | ✅ via `query: { field: value }`          |
| Sorting          | ✅ via `sortBy` + `sortOrder`             |
| Pagination       | ✅ via `page` + `limit`                   |
| Update by ID     | ✅ via `action: 'update'` with `id`       |
| Delete by ID     | ✅ via `action: 'delete'` with `id`       |
| Schema/Meta Info | ✅ via `action: 'meta'`                   |
| Type Inference   | ✅ (string / number / date autodetect)    |
| Type Generator   | ✅ Generates `.d.ts` from sheet structure |
