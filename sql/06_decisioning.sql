-- RECALCULATED DECISION ENGINE

SELECT
    transaction_id,
    user_id,
    risk_score,
    CASE
        WHEN risk_score >= 70 THEN 'block'
        WHEN risk_score >= 50 THEN '3ds_required'
        WHEN risk_score >= 30 THEN 'review'
        ELSE 'approve'
    END AS calculated_decision,
    decision AS original_decision,
    is_fraud
FROM transactions
ORDER BY risk_score DESC;

-- DECISION VALIDATION

SELECT
    COUNT(*) AS total_tx,
    SUM(
        CASE
            WHEN
                CASE
                    WHEN risk_score >= 70 THEN 'block'
                    WHEN risk_score >= 50 THEN '3ds_required'
                    WHEN risk_score >= 30 THEN 'review'
                    ELSE 'approve'
                END = decision
            THEN 1 ELSE 0
        END
    ) AS matching_decisions
FROM transactions;

-- FRAUD RATE BY DECISION

SELECT
    decision,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM transactions
GROUP BY decision
ORDER BY fraud_rate_pct DESC;

-- DECISION DISTRIBUTION

SELECT
    decision,
    COUNT(*) AS total_tx,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions), 2) AS decision_pct
FROM transactions
GROUP BY decision
ORDER BY total_tx DESC;

-- FALSE POSITIVES BY DECISION

SELECT
    decision,
    COUNT(*) AS total_tx,
    SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END) AS legit_tx,
    ROUND(
        SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS legit_rate_pct
FROM transactions
GROUP BY decision
ORDER BY legit_rate_pct DESC;

-- SAMPLE CASES BY DECISION

SELECT
    transaction_id,
    user_id,
    risk_score,
    decision,
    geo_mismatch,
    high_velocity,
    has_chargeback_history,
    is_vpn,
    new_account,
    high_amount,
    is_fraud
FROM transactions
WHERE decision IN ('block', '3ds_required', 'review', 'approve')
ORDER BY risk_score DESC
LIMIT 50;