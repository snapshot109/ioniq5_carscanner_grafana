#!/bin/bash
set -x

BASE="/volume1/docker/telegraf/obd_logs"
NEW_DIR="$BASE/new/my22"
PROCESSING_DIR="$BASE/processing/my22"
DONE_DIR="$BASE/done/my22"

echo "=== Starting CSV processing ==="

mkdir -p "$NEW_DIR" "$PROCESSING_DIR" "$DONE_DIR"

# Neue CSVs nach processing verschieben
if ls $NEW_DIR/*.csv 1> /dev/null 2>&1; then
    echo "$(date): Moving CSVs to processing..."
    for file in $NEW_DIR/*.csv; do
        mv -v "$file" "$PROCESSING_DIR/"
        # WICHTIG: Timestamp aktualisieren!
        touch "$PROCESSING_DIR/$(basename "$file")"
    done
else
    echo "$(date): No CSV files in new/"
fi

# Alte CSVs (älter als 10 Minuten) nach done verschieben
echo "$(date): Checking for old files in processing (older than 10 min)..."
find $PROCESSING_DIR -name "*.csv" -type f -mmin +20 -exec echo "Moving to done: {}" \; -exec mv -v {} $DONE_DIR/ \;

echo "=== Finished ==="
