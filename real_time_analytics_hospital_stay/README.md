# Real Time Analytics Hospital Data

This project simulates hospital operations data for real-time analytics, including patient stays, staffing levels, and discharge predictions.

---

## 📁 Template Files

### [stays_doc_template.json](./stays_doc_template.json)
- Generates individual hospital stay records, including admission/discharge, unit, entry point, patient ID, diagnosis, procedures, and attending physician.

### [staffing_doc_template.json](./staffing_doc_template.json)
- Generates staffing snapshots by unit and shift.

### [predictions_doc_template.json](./predictions_doc_template.json)
- Generates forecast data for patient discharges.

## Database Hierarchy

hospital_ops_db
 ├── stays          # patient stays, length of stay, admission/discharge
 ├── staffing       # staff counts by unit/shift
 └── predictions    # predicted discharges

 ## ⚙️ Data Generation

Use the following script to generate sample data:

```bash
./generate_data.sh
```

This script runs the following steps:

1. Generates raw stay records using `mgeneratejs`
2. Computes a realistic discharge date using `jq`
3. Formats output into a consistent schema
4. Generates 500 records for stays, staffing, and predictions

---

## 🧹 Cleanup

To delete generated artifacts:

```bash
./clean_generated_data.sh
```

This removes:
- `stays_raw.json`
- `stays_admit.json`
- `stays_90days.json`
- Final output files (`stays.json`, `staffing.json`, `predictions.json`)

---

## ☁️ Importing to MongoDB Atlas

Use the provided Ansible playbook to import your data:

```bash
ansible-playbook import_mongo_data.yml -e "@secrets.yml"
```

### Example `secrets.yml`

```yaml
cluster_name: your-cluster-name
database_username: your-username
database_password: your-password
```

> 💡 Tip: Use `ansible-vault encrypt secrets.yml` to store your credentials securely.

This imports each collection into the `hospital_ops_db` database in your MongoDB Atlas cluster.

---

## 🔗 Dependencies

- [mgeneratejs](https://github.com/fakemongo/mgeneratejs)
- `jq`
- `mongoimport` (part of MongoDB Database Tools)
- `ansible`

---

## 🧪 Testing

You can verify the output using:

```bash
jq . stays.json | head -n 20
```

Or view metrics (e.g. average length of stay) using tools like MongoDB Charts or a dashboard interface.