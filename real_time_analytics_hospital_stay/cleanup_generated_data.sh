#!/bin/bash

set -e

echo "Cleaning up generated data files..."

rm -f stays_raw.json
rm -f stays_admit.json
rm -f stays_90days.json
rm -f stays.json
rm -f predictions.json
rm -f staffing.json

echo "✅ Cleanup complete."