#!/usr/bin/env bash

# Copies the qmk code from a qmk_firmware fork,
# to the firmware/qmk directory here.

set -ex

VIAL_QMK=${VIAL_QMK_HOME:-~/github/vial-qmk}

DEST=firmware/vial

# Check that the QMK_FIRMWARE directory has this branch
EXPECT_BRANCH="rgoulter-keyboards-and-layouts"

SYNC_DIRS=(
  keyboards/rgoulter/pico42/keymaps/vial/
  keyboards/rgoulter/pykey40/lite/keymaps/vial/
)

ACTUAL_BRANCH=$(git --git-dir="${VIAL_QMK}/.git" branch --show-current)

if [ "${ACTUAL_BRANCH}" != "${EXPECT_BRANCH}" ]; then
  echo "branch ${ACTUAL_BRANCH} is checked out in ${QMK_FIRMWARE};"
  echo "but expected ${EXPECT_BRANCH} to be checked out."
  exit 1
fi

for DIR in "${SYNC_DIRS[@]}"; do
  mkdir -p "${DEST}/${DIR}"
  rsync "${VIAL_QMK}/${DIR}"/* "${DEST}/${DIR}"
done
