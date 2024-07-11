#!/bin/sh

# This is simpler but unsafe, consider tauthenticator.sh.
#
# Simple setup:
# 1. Scan the QR code, take the secret param. For example, if the scanned URI
#    is "otpauth://totp/...?secret=ABC&issuer=..." then the secret is "ABC".
# 2. Put the secret in a file in `secret/` directory, it's recommended to
#    name it `secret/default`.
#
# Simple usage:
# 1. If you put the secret in `secret/default`, simply run
#    `./unsafe-tauthenticator.sh`.
# 2. If, for example, you put it in `secret/something`, run
#    `./unsafe-tauthenticator.sh something`.

secret_file=${1:-default}

cd $(dirname "$0")/src
while true; do
  script='import pyotp; o = pyotp.TOTP(input()).now(); print(o[:3], o[3:])'
  otp=$(python3 -c "$script" < "../secret/$secret_file")
  [ "$otp" = "$old_otp" ] || echo "$otp"
  old_otp="$otp"
  sleep 5
done

