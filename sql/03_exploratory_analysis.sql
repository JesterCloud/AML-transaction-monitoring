
-------- Fraud Rate by country
SELECT
    country,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY country
ORDER BY fraud_rate_pct DESC;

--------- Geo Mismatch
SELECT
    geo_mismatch,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY geo_mismatch;

--------VPN Usage
SELECT
    is_vpn,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY is_vpn;


-------- Account Age

SELECT
    CASE
        WHEN account_age_hours < 24 THEN 'new'
        WHEN account_age_hours < 168 THEN 'medium'
        ELSE 'old'
    END AS account_segment,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY account_segment;

---- High amount
SELECT
    high_amount,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY high_amount;

----- Velocity
SELECT
    high_velocity,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY high_velocity;

------ Chargeback history
SELECT
    has_chargeback_history,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY has_chargeback_history;

---- Combinación fuerte
SELECT
    geo_mismatch,
    high_velocity,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY geo_mismatch, high_velocity
ORDER BY fraud_rate_pct DESC;

----- Geo + Velocity
SELECT
    geo_mismatch,
    high_velocity,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY geo_mismatch, high_velocity
ORDER BY fraud_rate_pct DESC;









