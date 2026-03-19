-- RECALCULATED RISK SCORE

SELECT
    transaction_id,
    user_id,
    geo_mismatch,
    ip_billing_mismatch,
    new_account,
    high_amount,
    high_velocity,
    is_vpn,
    has_chargeback_history,
    fresh_email,
    (
        CASE WHEN geo_mismatch = 1 THEN 20 ELSE 0 END +
        CASE WHEN ip_billing_mismatch = 1 THEN 15 ELSE 0 END +
        CASE WHEN new_account = 1 THEN 15 ELSE 0 END +
        CASE WHEN high_amount = 1 THEN 10 ELSE 0 END +
        CASE WHEN high_velocity = 1 THEN 20 ELSE 0 END +
        CASE WHEN is_vpn = 1 THEN 10 ELSE 0 END +
        CASE WHEN has_chargeback_history = 1 THEN 20 ELSE 0 END +
        CASE WHEN fresh_email = 1 THEN 10 ELSE 0 END
    ) AS calculated_risk_score,
    risk_score AS original_risk_score,
    decision,
    is_fraud
FROM transactions
ORDER BY calculated_risk_score DESC;

-- SCORE VALIDATION

SELECT
    COUNT(*) AS total_tx,
    SUM(
        CASE
            WHEN (
                CASE WHEN geo_mismatch = 1 THEN 20 ELSE 0 END +
                CASE WHEN ip_billing_mismatch = 1 THEN 15 ELSE 0 END +
                CASE WHEN new_account = 1 THEN 15 ELSE 0 END +
                CASE WHEN high_amount = 1 THEN 10 ELSE 0 END +
                CASE WHEN high_velocity = 1 THEN 20 ELSE 0 END +
                CASE WHEN is_vpn = 1 THEN 10 ELSE 0 END +
                CASE WHEN has_chargeback_history = 1 THEN 20 ELSE 0 END +
                CASE WHEN fresh_email = 1 THEN 10 ELSE 0 END
            ) = risk_score
            THEN 1 ELSE 0
        END
    ) AS matching_scores
FROM transactions;


-- RISK BANDS

SELECT
    CASE
        WHEN risk_score >= 70 THEN 'very_high'
        WHEN risk_score >= 50 THEN 'high'
        WHEN risk_score >= 30 THEN 'medium'
        ELSE 'low'
    END AS risk_band,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY risk_band
ORDER BY fraud_rate_pct DESC;

-- SIGNAL DISTRIBUTION IN HIGH RISK TRANSACTIONS

SELECT
    SUM(CASE WHEN geo_mismatch = 1 THEN 1 ELSE 0 END) AS geo_mismatch_hits,
    SUM(CASE WHEN ip_billing_mismatch = 1 THEN 1 ELSE 0 END) AS ip_billing_mismatch_hits,
    SUM(CASE WHEN new_account = 1 THEN 1 ELSE 0 END) AS new_account_hits,
    SUM(CASE WHEN high_amount = 1 THEN 1 ELSE 0 END) AS high_amount_hits,
    SUM(CASE WHEN high_velocity = 1 THEN 1 ELSE 0 END) AS high_velocity_hits,
    SUM(CASE WHEN is_vpn = 1 THEN 1 ELSE 0 END) AS vpn_hits,
    SUM(CASE WHEN has_chargeback_history = 1 THEN 1 ELSE 0 END) AS chargeback_hits,
    SUM(CASE WHEN fresh_email = 1 THEN 1 ELSE 0 END) AS fresh_email_hits
FROM transactions
WHERE risk_score >= 50;