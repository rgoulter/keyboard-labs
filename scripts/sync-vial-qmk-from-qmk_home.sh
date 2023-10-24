#!/usr/bin/env bash

# Syncs my keyboard definitions from my qmk_firmware fork,
# to my vial-qmk fork.
#
# Copies the qmk code from a qmk_firmware fork,
# to a vial-qmk directory,
# just for some of the keyboards under keyboards/rgoulter.

set -ex

QMK_FIRMWARE=${QMK_HOME:-~/github/qmk_firmware}
VIAL_QMK=${VIAL_QMK_HOME:-~/github/vial-qmk}

DEST=${VIAL_QMK}

# Check that the QMK_FIRMWARE directory has this branch
EXPECT_BRANCH="rgoulter-keyboards-and-layouts"

SYNC_DIRS=(
  keyboards/rgoulter/pykey40
  keyboards/rgoulter/pico42
)

ACTUAL_BRANCH=$(git --git-dir="${QMK_FIRMWARE}/.git" branch --show-current)

if [ "${ACTUAL_BRANCH}" != "${EXPECT_BRANCH}" ]; then
  echo "branch ${ACTUAL_BRANCH} is checked out in ${QMK_FIRMWARE};"
  echo "but expected ${EXPECT_BRANCH} to be checked out."
  exit 1
fi

for DIR in "${SYNC_DIRS[@]}"; do
  mkdir -p "${DEST}/${DIR}"
  rsync "${QMK_FIRMWARE}/${DIR}"/* "${DEST}/${DIR}/"
done
