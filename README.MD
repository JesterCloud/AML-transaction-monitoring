# Payment Fraud Risk Engine

AML portfolio project lab focused on payment fraud analysis, fraud rules, risk scoring, and decisioning using SQL, PostgreSQL, DBeaver, Pandas and Python.

## Objective
This project simulates a payment fraud environment and demonstrates how to:
- analyze fraud signals with SQL
- build fraud rules and risk logic
- create a risk scoring model
- assign decisions such as approve, review, 3DS required, and block
- evaluate fraud performance with business metrics

## Tech
- PostgreSQL
- DBeaver
- Python
- Pandas
- SQL

## Project Structure
- `screenshots/` → query outputs, samples and SQL analysis
- `data/raw/transactions.csv` → synthetic transaction dataset
- `sql/` → SQL scripts for analysis, rules, scoring, and decisioning
- `CASE_STUDIES.md` → examples of risk decisions
- `README.md` → project info.

## Dataset Features
- geo mismatch *
- IP vs billing mismatch
- high transaction velocity *
- chargeback history
- VPN usage
- account age
- email age
- transaction amount

## Risk Scoring
- geo mismatch = +20
- IP vs billing mismatch = +15
- new account = +15
- high amount = +10
- high velocity = +20
- VPN usage = +10
- chargeback history = +20
- fresh email = +10

- 0–29 → approve
- 30–49 → review
- 50–69 → 3DS required
- 70+ → block

## Key Findings
- Geo mismatch and high velocity were the strongest fraud indicators.
- Combining multiple signals significantly increased fraud probability.
- High and very high risk bands showed strong fraud concentration.
- The scoring model clearly separated low-risk from high-risk transactions.

## Business Interpretation
This project shows how a fraud analyst can move from raw signals to scoring and decisioning, while balancing fraud prevention and customer friction.
