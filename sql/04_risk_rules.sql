-- RULE 1: GEO MISMATCH + HIGH VELOCITY

SELECT
    transaction_id,
    user_id,
    geo_mismatch,
    high_velocity,
    risk_score,
    decision,
    is_fraud
FROM transactions
WHERE geo_mismatch = 1
  AND high_velocity = 1
ORDER BY risk_score DESC;

-- RULE 1 SUMMARY

SELECT
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
WHERE geo_mismatch = 1
  AND high_velocity = 1;

-- RULE 2: NEW ACCOUNT + HIGH AMOUNT

SELECT
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
WHERE new_account = 1
  AND high_amount = 1;

-- RULE 3: CHARGEBACK HISTORY + VPN

SELECT
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
WHERE has_chargeback_history = 1
  AND is_vpn = 1;

-- RULE 4: GEO MISMATCH + HIGH VELOCITY + CHARGEBACK HISTORY

SELECT
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
WHERE geo_mismatch = 1
  AND high_velocity = 1
  AND has_chargeback_history = 1;
