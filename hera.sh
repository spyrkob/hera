#!/bin/bash
set +u
readonly HERA_HOME=${HERA_HOME:-'./hera'}
export HERA_HOME
readonly HERA_DEBUG=${HERA_DEBUG}
export HERA_DEBUG
readonly HERA_CMD=${1}
shift

readonly HERA_SCRIPT=${HERA_HOME}/${HERA_CMD}.sh
set -u

echo "hera"
# shellcheck source=library.sh
source "${HERA_HOME}"/library.sh

is_defined "${HERA_HOME}"
is_dir "${HERA_HOME}"

exists "${HERA_SCRIPT}" "Invalid command - no script for ${HERA_CMD}"
is_executable "${HERA_SCRIPT}" "Invalid state - script exists, but is not executable : ${HERA_SCRIPT}."

if [ -z "${HERA_DEBUG}" ]; then
  # shellcheck disable=SC2068
  "${HERA_SCRIPT}" ${@}
else
  # shellcheck disable=SC2068
  bash -x "${HERA_SCRIPT}" ${@}
fi
