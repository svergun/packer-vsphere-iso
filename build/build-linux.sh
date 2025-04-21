#!/usr/bin/env bash

# -*- mode: shell -*-
# vim: set filetype=sh :

# PARSE COMMAND LINE ARGUMENTS
#--------------------------------------------------
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      printf "\nUsage: $(basename "$0") [options]\n"
      printf "Options:\n"
      printf "  -h, --help        Show this help message and exit\n"
      printf "  -s, --skip-build  Skip packer build. Use this option to skip the packer build step and validate packer configuration only.\n"
      printf "  -d, --debug       Enable debug mode. Use this option to enable debug mode for the script.\n"
      exit 0 ;;
    -s|--skip-build)
      PACKER_BUILD="false"; shift ;;
    -d|--debug)
      set -x; shift ;;
    *)
      printf "Unknown option: $1\n"
      printf "run $(basename "$0") -h for help\n"
      exit 1 ;;
  esac
done


# SET SCRIPT VARIABLES
#--------------------------------------------------
# set base directory
BASEDIR=$(dirname "$0")
# set source directoris list
SOURCE_FOLDERS=(
  "functions"
  "vars"
)

# ERROR HANDLING
#--------------------------------------------------
set -euo pipefail
trap 'echo "Script terminated unexpectedly"; exit 1' ERR INT


# SOURCE FUNCTIONS AND VARIABLES
#--------------------------------------------------
# get list of source files
for FOLDER in "${SOURCE_FOLDERS[@]}"; do
  if [ ! -d "$BASEDIR/$FOLDER" ]; then
    echo "Error: Directory $BASEDIR/$FOLDER not found!"
    exit 1
  fi
  # sort files alphabetically
  FILES+=($(find "$BASEDIR/$FOLDER" -type f | sort))
done
# source files
echo "Sourcing files..."
for FILE in "${FILES[@]}"; do
  echo "$FILE"
  source "$FILE"
done

# CHECK REQUIRED PACKAGES
#--------------------------------------------------
print_title "Checking required packages..."
for package in "${REQUIRED_PACKAGES[@]}"; do
  if ! command -v "$package" &> /dev/null; then
    print_fail "$package is not installed. Please install $package and try again."
    exit 1
  fi
  print_ok "$package"
done

# SELECT DISTRIBUTIVE AND VERSION
#--------------------------------------------------
print_title "Choose Distributive:"
select DISTR in "${DISTR_LIST[@]}"; do
  # check if distributive is set
  if [ -z "$DISTR" ]; then
    print_fail "Distributive is not set"
    exit 1
  fi

  distr_set_version ${DISTR_VERSIONS["$DISTR"]}
  distr_iso_urls "$DISTR" "$DISTR_VERSION"
  break
done

# RUN PACKER
#--------------------------------------------------
if [ "${PACKER_BUILD:-false}" = "false" ]; then
  packer_exec "validate"
  print_info "Skip build option is set. Skipping packer build."
  exit 0
else
  packer_exec "validate"
  packer_exec "build"
fi
