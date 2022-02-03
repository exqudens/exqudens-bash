#!/bin/bash

#set -e

_conan() {
  local cmd="${1##*/}"
  local word="${COMP_WORDS[COMP_CWORD]}"
  local line="${COMP_LINE}"
  local all='--version export export-pkg install remove search user'

  if [[ "${line}" == *"--version"* ]]
  then
    all=''
  elif [[ "${line}" == *"export-pkg"* ]]
  then
    all=""
  elif [[ "${line}" == *"export"* ]]
  then
    all=""
  elif [[ "${line}" == *"install"* ]]
  then
    all=""
  elif [[ "${line}" == *"remove"* ]]
  then
    all=""
  elif [[ "${line}" == *"search"* ]]
  then
    all=""
  elif [[ "${line}" == *"user"* ]]
  then
    all=""
  fi

  if [[ "${all}" == "" ]]
  then
    COMPREPLY=()
  elif [[ "${word}" == "" ]]
  then
    COMPREPLY=($(compgen -W "${all}"))
  elif [[ "${all}" == *"${word}"* ]]
  then
    COMPREPLY=($(compgen -W "${all}" -- "${word}"))
  else
    COMPREPLY=()
  fi
}

complete -F _conan conan.exe conan
