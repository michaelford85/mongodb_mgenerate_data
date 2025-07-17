#!/bin/bash

set -e  # Exit on first error
set -o pipefail  # Catch errors in piped commands

echo "Generating raw stays data..."
mgeneratejs "$(jq -c . stays_doc_template.json)" -n 500 > stays_raw.json

echo "Generating predictions data..."
mgeneratejs "$(jq -c . predictions_doc_template.json)" -n 500 > predictions.json

echo "Generating staffing data..."
mgeneratejs "$(jq -c . staffing_doc_template.json)" -n 500 > staffing.json

echo "Adding dischargeDate to stays..."
./discharge_jq_command.sh

echo "✅ All data generated successfully."