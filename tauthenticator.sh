#!/bin/sh

# Setup:
# 1. Make sure you have 'gpg' installed.
# 2. Scan the OTP QR code, copy the result.
#    - It should be an URI like "otpauth://totp/...?secret=ABC&issuer=...".
# 3. Encrypt the URI using 'gpg' into a file.
#    - Example: Run 'gpg -er USER_ID > secret.gpg', paste the URI, and press Ctrl+D.
#
# Usage:
# 1. Run:
#        tauthenticator.sh [SECRET_FILE]
#    If not specified, 'SECRET_FILE' is 'secret.gpg' by default.
# 2. Press Ctrl+C to exit.

secret_file="${1:-secret.gpg}"

export PYTHONPATH=$(dirname "$0")/src
while true; do
  otp=$(gpg -dq "$secret_file" | python3 -Pm pyotp)
  [ "$otp" = "$old_otp" ] || echo "$otp"
  old_otp="$otp"
  sleep 1
done
