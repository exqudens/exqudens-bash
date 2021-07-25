#!/bin/bash

set -e

if test -f "tmp/msvc-paths.txt"
then
  SCRIPT_MSVC_ENV=$(cat "tmp/msvc-paths.txt")
else
  SCRIPT_MSVC_ENV=$(cmake -P "/c/git/exqudens-cmake/src/main/cmake/msvc-paths.cmake" 16 2>&1)
  echo "${SCRIPT_MSVC_ENV}" > "tmp/msvc-paths.txt"
fi

SCRIPT_MSVC_X86_ENV=$(echo "${SCRIPT_MSVC_ENV}" | awk '/X86_X86_ENV_START/{flag=1;next}/X86_X86_ENV_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

SCRIPT_MSVC_X86_LIBPATH=$(echo "${SCRIPT_MSVC_X86_ENV}" | awk '/LIBPATH_START/{flag=1;next}/LIBPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_LIB=$(echo "${SCRIPT_MSVC_X86_ENV}" | awk '/LIB_START/{flag=1;next}/LIB_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_BASH_CLPATH=$(echo "${SCRIPT_MSVC_X86_ENV}" | awk '/BASH_CLPATH_START/{flag=1;next}/BASH_CLPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_BASH_RCPATH=$(echo "${SCRIPT_MSVC_X86_ENV}" | awk '/BASH_RCPATH_START/{flag=1;next}/BASH_RCPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

export MSVC_X86_LIBPATH="${SCRIPT_MSVC_X86_LIBPATH}"
export MSVC_X86_LIB="${SCRIPT_MSVC_X86_LIB}"
export MSVC_X86_BASH_CLPATH="${SCRIPT_MSVC_X86_BASH_CLPATH}"
export MSVC_X86_BASH_RCPATH="${SCRIPT_MSVC_X86_BASH_RCPATH}"

SCRIPT_MSVC_X64_X86_ENV=$(echo "${SCRIPT_MSVC_ENV}" | awk '/X64_X86_ENV_START/{flag=1;next}/X64_X86_ENV_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

SCRIPT_MSVC_X64_X86_LIBPATH=$(echo "${SCRIPT_MSVC_X64_X86_ENV}" | awk '/LIBPATH_START/{flag=1;next}/LIBPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_X86_LIB=$(echo "${SCRIPT_MSVC_X64_X86_ENV}" | awk '/LIB_START/{flag=1;next}/LIB_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_X86_BASH_CLPATH=$(echo "${SCRIPT_MSVC_X64_X86_ENV}" | awk '/BASH_CLPATH_START/{flag=1;next}/BASH_CLPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_X86_BASH_RCPATH=$(echo "${SCRIPT_MSVC_X64_X86_ENV}" | awk '/BASH_RCPATH_START/{flag=1;next}/BASH_RCPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

export MSVC_X64_X86_LIBPATH="${SCRIPT_MSVC_X64_X86_LIBPATH}"
export MSVC_X64_X86_LIB="${SCRIPT_MSVC_X64_X86_LIB}"
export MSVC_X64_X86_BASH_CLPATH="${SCRIPT_MSVC_X64_X86_BASH_CLPATH}"
export MSVC_X64_X86_BASH_RCPATH="${SCRIPT_MSVC_X64_X86_BASH_RCPATH}"

SCRIPT_MSVC_X64_ENV=$(echo "${SCRIPT_MSVC_ENV}" | awk '/X64_X64_ENV_START/{flag=1;next}/X64_X64_ENV_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

SCRIPT_MSVC_X64_LIBPATH=$(echo "${SCRIPT_MSVC_X64_ENV}" | awk '/LIBPATH_START/{flag=1;next}/LIBPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_LIB=$(echo "${SCRIPT_MSVC_X64_ENV}" | awk '/LIB_START/{flag=1;next}/LIB_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_BASH_CLPATH=$(echo "${SCRIPT_MSVC_X64_ENV}" | awk '/BASH_CLPATH_START/{flag=1;next}/BASH_CLPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X64_BASH_RCPATH=$(echo "${SCRIPT_MSVC_X64_ENV}" | awk '/BASH_RCPATH_START/{flag=1;next}/BASH_RCPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

export MSVC_X64_LIBPATH="${SCRIPT_MSVC_X64_LIBPATH}"
export MSVC_X64_LIB="${SCRIPT_MSVC_X64_LIB}"
export MSVC_X64_BASH_CLPATH="${SCRIPT_MSVC_X64_BASH_CLPATH}"
export MSVC_X64_BASH_RCPATH="${SCRIPT_MSVC_X64_BASH_RCPATH}"

SCRIPT_MSVC_X86_X64_ENV=$(echo "${SCRIPT_MSVC_ENV}" | awk '/X86_X64_ENV_START/{flag=1;next}/X86_X64_ENV_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

SCRIPT_MSVC_X86_X64_LIBPATH=$(echo "${SCRIPT_MSVC_X86_X64_ENV}" | awk '/LIBPATH_START/{flag=1;next}/LIBPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_X64_LIB=$(echo "${SCRIPT_MSVC_X86_X64_ENV}" | awk '/LIB_START/{flag=1;next}/LIB_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_X64_BASH_CLPATH=$(echo "${SCRIPT_MSVC_X86_X64_ENV}" | awk '/BASH_CLPATH_START/{flag=1;next}/BASH_CLPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')
SCRIPT_MSVC_X86_X64_BASH_RCPATH=$(echo "${SCRIPT_MSVC_X86_X64_ENV}" | awk '/BASH_RCPATH_START/{flag=1;next}/BASH_RCPATH_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

export MSVC_X86_X64_LIBPATH="${SCRIPT_MSVC_X86_X64_LIBPATH}"
export MSVC_X86_X64_LIB="${SCRIPT_MSVC_X86_X64_LIB}"
export MSVC_X86_X64_BASH_CLPATH="${SCRIPT_MSVC_X86_X64_BASH_CLPATH}"
export MSVC_X86_X64_BASH_RCPATH="${SCRIPT_MSVC_X86_X64_BASH_RCPATH}"

SCRIPT_MSVC_X86_X64_INCLUDE=$(echo "${SCRIPT_MSVC_X86_X64_ENV}" | awk '/INCLUDE_START/{flag=1;next}/INCLUDE_STOP/{flag=0}flag' | awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }')

export MSVC_INCLUDE="${SCRIPT_MSVC_X64_INCLUDE}"
