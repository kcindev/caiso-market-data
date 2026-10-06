# caiso oasis lmp source nottes

## dataset

source: CAISO OASIS

- Query name: `PRC_LMP`
- Market run: `DAM`
- Node: `TH_NP15_GEN-APND`
- Trade date investigated: 2026-10-01
- Output format: CSV packaged inside ZIP

CSV contained:

- 1 header row
- 120 data rows
- 24 hourly intervals
- 5 price-component rows per hour

Observed `XML_DATA_ITEM` values:

- `LMP_PRC`
- `LMP_ENE_PRC`
- `LMP_CONG_PRC`
- `LMP_LOSS_PRC`
- `LMP_GHG_PRC`

- `INTERVALSTARTTIME_GMT`
- `INTERVALENDTIME_GMT`
- `OPR_DT`
- `OPR_HR`
- `OPR_INTERVAL`
- `NODE_ID`
- `MARKET_RUN_ID`
- `XML_DATA_ITEM`
- `MW`

the `MW` column contains the numeric value even when the value represents a price component

## findings

each hour tested:

`LMP ≈ Energy + Congestion + Loss + GHG`

differences of approximately `0.00001` were observed due to roundinga

future validation should therefore use a numeric tolerance rather than exact equality

## other observations

- congestion and loss components may be negative
- source rows are not guaranteed to be returned in chronological order
