-- GLOBAL METRICS

SELECT
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM transactions;

-- APPROVAL RATE

SELECT
    ROUND(
        SUM(CASE WHEN decision = 'approve' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS approval_rate_pct
FROM transactions;

-- BLOCK RATE

SELECT
    ROUND(
        SUM(CASE WHEN decision = 'block' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS block_rate_pct
FROM transactions;

-- FALSE POSITIVE RATE (CRÍTICO)

SELECT
    ROUND(
        SUM(CASE WHEN decision = 'block' AND is_fraud = 0 THEN 1 ELSE 0 END) * 100.0
        / NULLIF(SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END), 0),
        2
    ) AS false_positive_rate_pct
FROM transactions;