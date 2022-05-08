#!/bin/bash

#set -e

_cmake() {
  local cmd="${1##*/}"
  local word="${COMP_WORDS[COMP_CWORD]}"
  local line="${COMP_LINE}"
  local all='-P -S . --build --list-presets --preset'

  if echo "${line}" | awk '!/--build --preset .+ --target .+ /{exit 1}'
  then
    all=''
  elif echo "${line}" | awk '!/--build --preset .+ --target /{exit 1}'
  then
    all='all help clean test install package package_source'
  elif echo "${line}" | awk '!/--build --preset .+ /{exit 1}'
  then
    all='--target'
  elif echo "${line}" | awk '!/--build --preset .+ /{exit 1}'
  then
    all='--target'
  elif [[ "${line}" == *"--build --preset"* ]]
  then
    if [[ -f "./CMakePresets.json" ]]
    then
      all=$(cmake -S . --list-presets | xargs | cut -f2 -d':' | xargs)
    else
      all=''
    fi
  elif [[ "${line}" == *"--build"* ]]
  then
    all='--preset'
  elif echo "${line}" | awk '!/-S . --preset .+ /{exit 1}'
  then
    all=''
  elif [[ "${line}" == *"-S . --preset"* ]]
  then
    if [[ -f "./CMakePresets.json" ]]
    then
      all=$(cmake -S . --list-presets | xargs | cut -f2 -d':' | xargs)
    else
      all=''
    fi
  elif [[ "${line}" == *"-S . --list-presets"* ]]
  then
    all=''
  elif [[ "${line}" == *"-S ."* ]]
  then
    all='--list-presets --preset'
  elif [[ "${line}" == *"-S"* ]]
  then
    all=". $(ls -d */ | cut -f1 -d'/')"
  elif [[ "${line}" == *"-P"* ]]
  then
    all=""
  else
    all='-P -S --build'
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

complete -o bashdefault -o default -F _cmake cmake.exe cmake
