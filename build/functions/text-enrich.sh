#!/usr/bin/env bash

TEXT_RED="\033[0;31m"
TEXT_GREEN="\033[0;32m"
TEXT_YELLOW="\033[0;33m"
TEXT_CYAN="\033[0;36m"
TEXT_BLUE="\033[0;34m"

TEXT_LCYAN="\033[0;96m"

TEXT_BOLD="\033[1m"
TEXT_RESET="\033[0m"

# Print [OK]
#--------------------------------------------------
print_ok() {
  printf "[${TEXT_GREEN}OK${TEXT_RESET}] $1\n"
}

# Print [FAIL]
#--------------------------------------------------
print_fail() {
  printf "[${TEXT_RED}FAIL${TEXT_RESET}] $1\n"
}

# Print [INFO]
#--------------------------------------------------
print_info() {
  printf "[${TEXT_LCYAN}INFO${TEXT_RESET}] $1\n"
}

# Print Title using input string
#--------------------------------------------------
print_title() {
  printf "\n${TEXT_BOLD}$1${TEXT_RESET}\n"
}

# Print CMD using input string
#--------------------------------------------------
print_cmd() {
  printf "${TEXT_BLUE}$1${TEXT_RESET}\n"
}
