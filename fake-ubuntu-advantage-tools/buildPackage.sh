#!/usr/bin/env bash
set -euo pipefail

DEPS="dpkg-dev debhelper"

for d in $DEPS; do
  if [[ "$(dpkg --get-selections $d | awk '{print $2}')" != "install" ]]; then
    echo "$d needed, please install"
    exit 1
  fi
done

if [[ -n "$DEB_SIGN_KEYID" ]]; then
  dpkg_buildpackage_opts=""
else
  dpkg_buildpackage_opts="-us -uc"
fi

cd src && dpkg-buildpackage $dpkg_buildpackage_opts
