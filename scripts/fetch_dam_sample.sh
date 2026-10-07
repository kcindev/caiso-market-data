#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="data/raw"
OUTPUT_FILE="${OUTPUT_DIR}/dam_lmp_np15_2026-10-01.zip"
TEMP_FILE="${OUTPUT_FILE}.part"

URL="https://oasis.caiso.com/oasisapi/SingleZip?resultformat=6&queryname=PRC_LMP&startdatetime=20261001T07:00-0000&enddatetime=20261002T07:00-0000&version=1&market_run_id=DAM&node=TH_NP15_GEN-APND"

mkdir -p "$OUTPUT_DIR"

if [[ -f "$OUTPUT_FILE" ]]; then
    echo "Raw artifact already exists: $OUTPUT_FILE"
    echo "Skipping download."
    exit 0
fi

rm -f "$TEMP_FILE"

curl \
    --fail \
    --show-error \
    --location \
    "$URL" \
    --output "$TEMP_FILE"

mv "$TEMP_FILE" "$OUTPUT_FILE"

echo "Downloaded: $OUTPUT_FILE"
