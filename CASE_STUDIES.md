# Case Studies

## Case 1
- Transaction ID: 5351
- Decision: block
- Risk Score: 105
- Signals:
  - geo_mismatch = 1
  - high_velocity = 1
  - has_chargeback_history = 1
  - is_vpn = 0
  - new_account = 0
  - high_amount = 1
  This transaction was blocked because it combined multiple strong fraud indicators, geo mismatch, velocity, and prior chargeback history.

## Case 2
- Transaction ID: 8648
- Decision: block
- Risk Score: 80
- Signals:
  - geo_mismatch = 1
  - high_velocity = 1
  - has_chargeback_history = 0
  - is_vpn = 0
  - new_account = 1
  - high_amount = 0
- Interpretation:
  This transaction was blocked due to a combination of strong fraud signals, geo mismatch and high transaction velocity. The presence of a new account increased the risk score.

## Case 3
- Transaction ID: 2309
- Decision: block
- Risk Score: 65
- Signals:
  - geo_mismatch = 1
  - high_velocity = 1
  - has_chargeback_history = 0
  - is_vpn = 1
  - new_account = 0
  - high_amount = 0
- Interpretation:
  Flagged for 3DS authentication due to multiple moderate-to-strong risk signals, geo mismatch, high velocity, and VPN usage. While the risk score is high, it does not reach the threshold for blocking, still inside 3DS range.