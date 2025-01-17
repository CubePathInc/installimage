#!/usr/bin/env bash

# (c) 2023, CubePath Inc. Installation image, Fork of "https://github.com/hetzneronline/installimage"

trap 'mv /etc/pam.d/common-passwor{d.bak,d}' exit

cp /etc/pam.d/common-passwor{d,d.bak}

{
  echo "password        [success=1 default=ignore]      pam_unix.so obscure $1"
  echo "password        requisite                       pam_deny.so"
  echo "password        required                        pam_permit.so"
} > /etc/pam.d/common-password

shift

passwd "$@"

# vim: ai:ts=2:sw=2:et
