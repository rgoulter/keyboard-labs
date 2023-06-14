#!/usr/bin/env bash

# Copies the qmk code from a qmk_firmware fork,
# to the firmware/qmk directory here.

set -ex

QMK_FIRMWARE=${QMK_HOME:-~/github/qmk_firmware}

DEST=firmware/qmk

# Check that the QMK_FIRMWARE directory has this branch
EXPECT_BRANCH="rgoulter-keyboards-and-layouts"

SYNC_DIRS=(
  keyboards/rgoulter/
  layouts/community/planck_mit/rgoulter/
  layouts/community/planck_mit/rgoulter/
  users/rgoulter/
)

ACTUAL_BRANCH=$(git --git-dir="${QMK_FIRMWARE}/.git" branch --show-current)

if [ "${ACTUAL_BRANCH}" != "${EXPECT_BRANCH}" ]; then
  echo "branch ${ACTUAL_BRANCH} is checked out in ${QMK_FIRMWARE};"
  echo "but expected ${EXPECT_BRANCH} to be checked out."
  exit 1
fi

for DIR in "${SYNC_DIRS[@]}"; do
  rsync --recursive --delete "${QMK_FIRMWARE}/${DIR}" "${DEST}/${DIR}"
done
