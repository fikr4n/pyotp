#!/bin/sh

# This is simpler but unsafe, consider using 'tauthenticator.sh' instead.
#
# Setup:
# 1. Scan the OTP QR code, copy the result.
#    - It should be an URI like "otpauth://totp/...?secret=ABC&issuer=...".
# 2. Put the URI in a file, e.g. 'secret.txt'.
#
# Usage:
# 1. Run:
#        unsafe-tauthenticator.sh [SECRET_FILE]
#    If not specified, 'SECRET_FILE' is 'secret.txt' by default.
# 2. Press Ctrl+C to exit.

secret_file="${1:-secret.txt}"

export PYTHONPATH=$(dirname "$0")/src
while true; do
  otp=$(python3 -Pm pyotp < "$secret_file")
  [ "$otp" = "$old_otp" ] || echo "$otp"
  old_otp="$otp"
  sleep 1
done
