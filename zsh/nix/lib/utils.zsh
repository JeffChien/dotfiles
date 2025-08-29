#!/usr/bin/env bash
# add new path to the path {{{
function addpath {
    # $1: directory to be added
    path=(
      "$1"
      "$path"
    )
    export PATH
    echo "adding path: $1"
}
# }}}


# sum {{{
function totalsum() {
    # http://stackoverflow.com/questions/450799/shell-command-to-sum-integers-one-per-line
    paste -s -d+ - | bc
}
# }}}

# osExport {{{
OS_NAME_MACOS='Darwin'
OS_NAME_GENERAL_LINUX='Linux'
function osExport () {
  # export environment variable base on OS_NAME
  #
  # OS_NAME can be obtained by `uname`
  #
  # $1: variable name
  # $2...: OS=VALUE, OS is the target OS name. if VALUE is empty, the variable name specify in $1 will be unset.

  OS_NAME=${OS_NAME:=`uname`}
  local varName osName varValue osMaps cmd
  varName=$1
  shift
  osMaps=("$@")

  for keyVal in "${osMaps[@]}"; do
    IFS='=' read -r osName varValue <<< "$keyVal"
    if [[ "$OS_NAME" == "$osName" ]]; then
      if [[ -z "$varValue" ]]; then
        cmd=`printf "unset %s" "$varName"`
      else
        cmd=`printf "export %s=%s" "$varName" "$varValue"`
      fi
      echo "$cmd"
      eval "$cmd"
      return
    fi
  done
}
# }}}

function get1stExistsPath () {
  # check all paths from parameters and return the first exists path.
  #
  #
  # $@: paths to check

  for lp in "$@"; do
    if [[ -e "$lp" ]]; then
      echo -n "$lp"
      break
    fi
  done
}

function exportIfAny () {
  # export environment variable only if value is not empty, otherwise unset.
  #
  # 
  # $1: variable name
  # $2: variable value

  local cmd
  if [[ -z "$2" ]]; then
    cmd=`printf "unset %s" "$1"`
  else
    cmd=`printf "export %s=%s" "$1" "$2"`
  fi
  eval "$cmd"
}

function _pv_as_cp () {
  pv < $1 > $2
}

# vim: fdm=marker
