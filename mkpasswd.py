#!/usr/bin/env python3

# based on https://stackoverflow.com/a/17992126/117471
# useful for Mac machines without 'mkpasswd' installed

import sys
from getpass import getpass
from passlib.hash import sha512_crypt

passwd = input() if not sys.stdin.isatty() else getpass()
print(sha512_crypt.encrypt(passwd))

