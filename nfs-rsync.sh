#!/bin/sh
if [ -z "${NFS_SHARE}" ]; then
  echo "The NFS_SHARE environment variable not set, exiting..."
  exit 1
fi

if [ -z "${NFS_OPTIONS}" ]; then
  NFS_OPTIONS="rw"
fi

RSYNC="rsync -a -u"

if [ "${VERBOSE}" == "yes" -o "${VERBOSE}" == "true" ]; then
  RSYNC="${RSYNC} -v"
fi

if [ "${DELETE}" == "yes" -o "${DELETE}" == "true" ]; then
  RSYNC="${RSYNC} --delete"
fi

SOURCE_DIR="/source"
TARGET_DIR="/target"

rpcbind

echo "mount nfs server and sync from source ..."

mount -o ${NFS_OPTIONS} ${NFS_SHARE} ${TARGET_DIR} && \
${RSYNC} "${SOURCE_DIR}/" "${TARGET_DIR}"

