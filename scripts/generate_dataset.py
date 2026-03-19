import random
from datetime import datetime, timedelta
import pandas as pd

random.seed(42)

NUM_TRANSACTIONS = 15000
countries = ["ES", "FR", "DE", "IT", "NL", "GB", "PL", "RO", "BR", "CO"]
payment_methods = ["card", "paypal", "wallet"]
currencies = ["EUR", "USD", "GBP"]

rows = []
start_date = datetime(2025, 1, 1)

for tx_id in range(1, NUM_TRANSACTIONS + 1):
    user_id = random.randint(1, 2500)
    account_age_hours = random.randint(1, 365 * 24)
    amount = round(random.uniform(5, 1500), 2)
    country = random.choice(countries)
    billing_country = random.choice(countries)
    ip_country = random.choice(countries)
    device_id = f"device_{random.randint(1, 3500)}"
    card_hash = f"card_{random.randint(1, 5000)}"
    payment_method = random.choice(payment_methods)
    currency = random.choice(currencies)
    timestamp = start_date + timedelta(minutes=random.randint(0, 180 * 24 * 60))
    card_attempts_last_1h = random.randint(1, 10)
    transactions_last_24h = random.randint(1, 20)
    email_age_days = random.randint(0, 365)
    is_vpn = random.choice([0, 1])
    has_chargeback_history = random.choice([0, 1])

    geo_mismatch = 1 if country != billing_country else 0
    ip_billing_mismatch = 1 if ip_country != billing_country else 0
    new_account = 1 if account_age_hours < 24 else 0
    high_amount = 1 if amount > 1000 else 0
    high_velocity = 1 if card_attempts_last_1h > 5 else 0
    fresh_email = 1 if email_age_days < 7 else 0

    fraud_score = 0
    fraud_score += 20 if geo_mismatch else 0
    fraud_score += 15 if ip_billing_mismatch else 0
    fraud_score += 15 if new_account else 0
    fraud_score += 10 if high_amount else 0
    fraud_score += 20 if high_velocity else 0
    fraud_score += 10 if is_vpn else 0
    fraud_score += 20 if has_chargeback_history else 0
    fraud_score += 10 if fresh_email else 0

    if fraud_score >= 70:
        decision = "block"
    elif fraud_score >= 50:
        decision = "3ds_required"
    elif fraud_score >= 30:
        decision = "review"
    else:
        decision = "approve"

    # Etiqueta simulada de fraude
    is_fraud = 1 if fraud_score >= 50 and random.random() < 0.75 else 0

    rows.append({
        "transaction_id": tx_id,
        "user_id": user_id,
        "account_age_hours": account_age_hours,
        "amount": amount,
        "country": country,
        "billing_country": billing_country,
        "ip_country": ip_country,
        "device_id": device_id,
        "card_hash": card_hash,
        "payment_method": payment_method,
        "currency": currency,
        "timestamp": timestamp,
        "card_attempts_last_1h": card_attempts_last_1h,
        "transactions_last_24h": transactions_last_24h,
        "email_age_days": email_age_days,
        "is_vpn": is_vpn,
        "has_chargeback_history": has_chargeback_history,
        "geo_mismatch": geo_mismatch,
        "ip_billing_mismatch": ip_billing_mismatch,
        "new_account": new_account,
        "high_amount": high_amount,
        "high_velocity": high_velocity,
        "fresh_email": fresh_email,
        "risk_score": fraud_score,
        "decision": decision,
        "is_fraud": is_fraud
    })

df = pd.DataFrame(rows)
df.to_csv("data/raw/transactions.csv", index=False)

print("Dataset generado en data/raw/transactions.csv")
print(df.head())
print(df["decision"].value_counts())
print(df["is_fraud"].value_counts())