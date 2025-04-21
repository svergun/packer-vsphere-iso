#!/usr/bin/env bash

# -*- mode: shell -*-
# vim: set filetype=sh :

# Packer command
packer_cmd() {
  local ACTION="$1"
  # create and return packer command
  cat <<EOF
packer ${ACTION} \\
-var os_distr_version="${DISTR_VERSION}" \\
-var vmware_iso_url="${DISTR_ISO}" \\
-var vmware_iso_url_checksum="file:${DISTR_ISO_CHECKSUM}" \\
-var os_distr_name="linux-${DISTR}" \\
-var vmware_cl_tmpl_name="linux-${DISTR}" \\
-var-file=$BASEDIR/../variables/linux-${DISTR}.pkrvars.hcl \\
.
EOF
}

# Execute packer command
packer_exec() {
  local ACTION="$1"
  local CMD

  print_title "Executing Packer Command: ${ACTION}"

  # configure packer command and execute it
  CMD=$(packer_cmd "${ACTION}")
  print_cmd "${CMD}"
  eval "${CMD}"

  # check if packer command was successful
  if [ $? -eq 0 ]; then
    print_ok "Packer ${ACTION} command executed successfully."
  else
    print_fail "Packer ${ACTION} command failed."
    return 1
  fi
  return 0
}