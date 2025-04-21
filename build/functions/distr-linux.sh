#!/usr/bin/env bash

# -*- mode: shell -*-
# vim: set filetype=sh :

# set Linux distributive version
distr_set_version() {
  # get list of distributive versions
  local VERSIONS=${@}
  # convert space separated string to array
  IFS=' ' read -r -a VERSIONS_ARRAY <<< "$VERSIONS"
  print_title "Choose Version:"
  select DISTR_VERSION in "${VERSIONS_ARRAY[@]}"; do
    DISTR_VERSION=$DISTR_VERSION; break
  done
}

# get Linux distributive urls
distr_iso_urls() {
  local DISTR=$1
  local DISTR_VERSION=$2

  # check if distributive version is set
  if [ -z "$DISTR_VERSION" ]; then
    print_fail "Distributive version is not set"
    exit 1
  fi

  print_title "Fetching ISO URLs for ${DISTR} ${DISTR_VERSION}"
  # print_title "Get Current Debian Version:"

  case $DISTR in
    debian)
      if [ "$DISTR_VERSION" = "current" ]; then
        # set base url
        DISTR_BASE_URL=${DISTR_BASE_URL["$DISTR"]}
        DISTR_BASE_URL="$DISTR_BASE_URL/release/current/amd64/iso-cd"
        DISTR_ISO_CHECKSUM="$DISTR_BASE_URL/SHA256SUMS"
        # get current version
        DISTR_CURRENT_VERSION=$(curl -s $DISTR_ISO_CHECKSUM | head -1 | awk '{print $2}' | awk -F'-' '{print $2}')
        if [ $? -ne 0 ]; then print_fail "Failed to get current version"; exit 1; fi
        print_ok "Current Version: ${DISTR_CURRENT_VERSION}"
        # set variables based on current version
        DISTR_VERSION=$DISTR_CURRENT_VERSION
        DISTR_ISO="${DISTR_BASE_URL}/debian-${DISTR_VERSION}-amd64-netinst.iso"
      else
        # set variables based on archive version
        DISTR_BASE_URL=${DISTR_BASE_URL["$DISTR"]}"/archive/${DISTR_VERSION}/amd64/iso-cd"
        DISTR_ISO="${DISTR_BASE_URL}/debian-${DISTR_VERSION}-amd64-netinst.iso"
        DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/SHA256SUMS"
      fi
    ;;
    rocky)
      DISTR_BASE_URL=${DISTR_BASE_URL["$DISTR"]}
      # get current version
      DISTR_VERSION=$(curl -s "$DISTR_BASE_URL/${DISTR_VERSION%-latest}/isos/x86_64/CHECKSUM" | \
        awk '!/^#/ && /minimal/ && $2 ~ /-'${DISTR_VERSION%-latest}'\.[0-9]/ {
            gsub(/.*-'${DISTR_VERSION%-latest}'\./, '${DISTR_VERSION%-latest}'".");
            gsub(/[^0-9.].*$/, "");
            print
        }')
      if [ $? -ne 0 ]; then print_fail "Failed to get current version"; exit 1; fi
      print_ok "Current Version: ${DISTR_VERSION}"
      # set variables based on current version or archive version
      DISTR_ISO="${DISTR_BASE_URL}/${DISTR_VERSION}/isos/x86_64/Rocky-${DISTR_VERSION}-x86_64-minimal.iso"
      DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/${DISTR_VERSION}/isos/x86_64/Rocky-${DISTR_VERSION}-x86_64-minimal.iso.CHECKSUM"
    ;;
    ubuntu-server)
      # set base distributive url
      DISTR_BASE_URL=${DISTR_BASE_URL["$DISTR"]}"/$DISTR_VERSION"
      # get current version
      DISTR_CURRENT_VERSION=$(curl -s $DISTR_BASE_URL/SHA256SUMS | grep "server" | awk -F'-' '{print $2}')
      if [ $? -ne 0 ]; then print_fail "Failed to get current version"; exit 1; fi
      print_ok "Current Version: ${DISTR_CURRENT_VERSION}"
      # set variables based on version and installation type
      DISTR_ISO="${DISTR_BASE_URL}/ubuntu-${DISTR_CURRENT_VERSION}-live-server-amd64.iso"
      DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/SHA256SUMS"
    ;;
    *)
      print_fail "Unsupported Linux distributive: ${DISTR}"
      exit 1
  esac
  # check ISO urls are valid
  for ISO_URL in "$DISTR_ISO" "$DISTR_ISO_CHECKSUM"; do
    if ! curl --output /dev/null --silent --head --fail "$ISO_URL"; then
      print_fail "URL is not valid: ${ISO_URL}"
      exit 1
    fi
  done

  print_ok "Distributive ISO URL is valid: ${DISTR_ISO}"
  print_ok "Distributive ISO Checksum URL is valid: ${DISTR_ISO_CHECKSUM}"
}
