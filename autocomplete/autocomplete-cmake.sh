#!/bin/bash

#set -e

_cmake() {
  local cmd="${1##*/}"
  local word="${COMP_WORDS[COMP_CWORD]}"
  local line="${COMP_LINE}"
  local all='-S . --list-presets --preset'

  if echo "${line}" | awk '!/-S . --preset .+ --target .+ /{exit 1}'
  then
    all=''
  elif echo "${line}" | awk '!/-S . --preset .+ --target /{exit 1}'
  then
    all='all help clean test install package package_source'
  elif echo "${line}" | awk '!/-S . --preset .+ /{exit 1}'
  then
    all='--target'
  elif [[ "${line}" == *"-S . --preset"* ]]
  then
    if [[ -f "./CMakePresets.json" ]]
    then
      all=$(cmake -S . --list-presets | xargs | cut -f2 -d':' | xargs)
    else
      all=''
    fi
  elif [[ "${line}" == *"-S ."* ]]
  then
    all='--list-presets --preset'
  elif [[ "${line}" == *"-S"* ]]
  then
    all=". $(ls -d */ | cut -f1 -d'/')"
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

complete -F _cmake cmake.exe cmake
