import pyotp

# Currently support only TOTP.

secret = input()
try:
    totp = pyotp.parse_uri(secret)
except ValueError:
    totp = pyotp.TOTP(secret)
otp = totp.now()
print(otp[:3], otp[3:])
