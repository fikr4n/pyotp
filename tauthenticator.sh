#!/bin/bash

# This requires `watch` and `gpg`.
#
# Setup:
# 1. Scan the QR code, take the secret param. For example, if the scanned URI
#    is "otpauth://totp/...?secret=ABC&issuer=..." then the secret is "ABC".
# 2. GPG-encrypt the secret and put it in a file in `secret/` directory, it's
#    recommended to name it `secret/default`. For example:
#    `gpg -er USER_ID > secret/default`, enter the secret, press Ctrl+D.
#
# Usage:
# 1. If you put the secret in `secret/default`, simply run
#    `./tauthenticator.sh`.
# 2. If, for example, you put it in `secret/something`, run
#    `./tauthenticator.sh something`.
# 3. Press Ctrl+C to close.

secret_file=${1:-default}

cd `dirname $0`/src
watch gpg -dq "../secret/$secret_file" \| \
  python3 -c \''import pyotp;print(pyotp.TOTP(input()).now())'\'

