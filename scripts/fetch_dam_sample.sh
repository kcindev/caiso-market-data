#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="${OUTPUT_DIR:-data/raw}"
OUTPUT_FILE="${OUTPUT_FILE:-${OUTPUT_DIR}/dam_lmp_np15_2026-10-01.zip}"
TEMP_FILE="${OUTPUT_FILE}.part"

URL="${URL:-https://oasis.caiso.com/oasisapi/SingleZip?resultformat=6&queryname=PRC_LMP&startdatetime=20261001T07:00-0000&enddatetime=20261002T07:00-0000&version=1&market_run_id=DAM&node=TH_NP15_GEN-APND}"

mkdir -p "$OUTPUT_DIR"

if [[ -f "$OUTPUT_FILE" ]]; then
    echo "Raw artifact already exists: $OUTPUT_FILE"
    echo "Skipping download."
    exit 0
fi

cleanup() {
    rm -f "$TEMP_FILE"
}

trap cleanup EXIT

curl \
    --fail \
    --show-error \
    --location \
    "$URL" \
    --output "$TEMP_FILE"

if ! unzip -t "$TEMP_FILE" > /dev/null 2>&1; then
    echo "ERROR: Downloaded artifact is not a valid ZIP archive." >&2
    exit 1
fi

mv "$TEMP_FILE" "$OUTPUT_FILE"

trap - EXIT

echo "Downloaded and validated: $OUTPUT_FILE"
