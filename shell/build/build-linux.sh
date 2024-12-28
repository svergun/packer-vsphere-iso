#!/usr/bin/env bash

# set base directory
BASEDIR=$(dirname "$0")
# define Linux distributive list
DISTR_LIST=("debian" "rocky" "ubuntu-server")

# source functions
source $BASEDIR/../functions/rich-text.sh

# Functions
# ---------------------------------------
# set distributive version
set_distr_version() {
  print_title "Choose Version:"
  select DISTR_VERSION in "${DISTR_VERSIONS[@]}"; do
    DISTR_VERSION=$DISTR_VERSION; break
  done
}
# Packer command
packer_cmd() {
CMD=$(cat <<EOF
packer $1 \
-var os_distr_version="${DISTR_VERSION}" \
-var vmware_iso_url="${DISTR_ISO}" \
-var vmware_iso_url_checksum="file:${DISTR_ISO_CHECKSUM}" \
-var os_distr_name="linux-${DISTR}" \
-var vmware_cl_tmpl_name="linux-${DISTR}" \
-var-file=$BASEDIR/../../variables/linux-${DISTR}.pkrvars.hcl \
.
EOF
)
}
# ---------------------------------------
# End Functions

# Set Linux distributive
print_title "Choose Distributive:"
select DISTR in "${DISTR_LIST[@]}"; do
  DISTR=$DISTR; break
done

# set variables based on distributive
case $DISTR in
  debian)
    # set distributive versions
    DISTR_VERSIONS=("11.11.0" "current")
    set_distr_version
    print_title "Get Current Debian Version:"
    # set base distributive url
    DISTR_BASE_URL="https://cdimage.debian.org/mirror/cdimage"
    # workflow for current and archive versions
    if [ "$DISTR_VERSION" = "current" ]; then
      # set base url
      DISTR_BASE_URL="${DISTR_BASE_URL}/release/current/amd64/iso-cd"
      DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/SHA256SUMS"
      # get current version
      DISTR_CURRENT_VERSION=$(curl -s $DISTR_ISO_CHECKSUM | head -1 | awk '{print $2}' | awk -F'-' '{print $2}')
      if [ $? -ne 0 ]; then print_fail "Failed to get current version"; exit 1; fi
      print_ok "Current Version: ${DISTR_CURRENT_VERSION}"
      # set variables based on current version
      DISTR_VERSION=$DISTR_CURRENT_VERSION
      DISTR_ISO="${DISTR_BASE_URL}/debian-${DISTR_VERSION}-amd64-netinst.iso"
    else
      # set variables based on archive version
      DISTR_BASE_URL="${DISTR_BASE_URL}/archive/${DISTR_VERSION}/amd64/iso-cd"
      DISTR_ISO="${DISTR_BASE_URL}/debian-${DISTR_VERSION}-amd64-netinst.iso"
      DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/SHA256SUMS"
    fi
    ;;
  rocky)
    # set distributive versions
    DISTR_VERSIONS=("9-latest")
    set_distr_version
    print_title "Get Current Rocky ${DISTR_VERSION%-latest} Linux Version:"
    # set base distributive url
    DISTR_BASE_URL="https://download.rockylinux.org/pub/rocky"
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
    # set distributive versions
    DISTR_VERSIONS=("22.04" "24.04")
    set_distr_version
    print_title "Get Current Ubuntu ${DISTR_VERSION%-latest} Linux Version:"
    # set base distributive url
    DISTR_BASE_URL="https://releases.ubuntu.com/$DISTR_VERSION"
    # get current version
    DISTR_CURRENT_VERSION=$(curl -s $DISTR_BASE_URL/SHA256SUMS | grep "server" | awk -F'-' '{print $2}')
    if [ $? -ne 0 ]; then print_fail "Failed to get current version"; exit 1; fi
    print_ok "Current Version: ${DISTR_CURRENT_VERSION}"
    # set variables based on version and installation type
    DISTR_ISO="${DISTR_BASE_URL}/ubuntu-${DISTR_CURRENT_VERSION}-live-server-amd64.iso"
    DISTR_ISO_CHECKSUM="${DISTR_BASE_URL}/SHA256SUMS"
    ;;
esac

# validate packer configuration
print_title "Validate Packer Configuration:"
packer_cmd "validate"
print_cmd "${CMD}"
eval ${CMD}
if [ $? -ne 0 ]; then print_fail "Packer configuration is invalid"; exit 1; fi

# build packer image
print_title "Build Packer Image:"
packer_cmd "build"
print_cmd "${CMD}"
eval ${CMD}
if [ $? -ne 0 ]; then print_fail "Build failed"; exit 1; fi
if [ $? -eq 0 ]; then print_ok "Build completed successfully"; fi
