#!/bin/sh
if [ $# -ne 4 ]; then
  echo "USAGE: $0 JOB_NAME PVC_NAME NFS_SHARE NFS_OPTIONS"
  exit 1
fi

BASE_DIR=$(dirname "$0")

JOB_NAME="$1"
PVC_NAME="$2"
NFS_SHARE="$3"
NFS_OPTIONS="$4"

VERBOSE="true"
DELETE="true"

NFS_RSYNC_IMAGE="00ahui/nfs-rsync:latest"

TEMPLATE="${BASE_DIR}/template.yaml"
TEST_NAME="${JOB_NAME}-${PVC_NAME}-nfs-rsync"

cat ${TEMPLATE} | sed "
  s@{{NFS_RSYNC_IMAGE}}@${NFS_RSYNC_IMAGE}@g
  s@{{JOB_NAME}}@${JOB_NAME}@g
  s@{{PVC_NAME}}@${PVC_NAME}@g
  s@{{NFS_SHARE}}@${NFS_SHARE}@g
  s@{{NFS_OPTIONS}}@${NFS_OPTIONS}@g
  s@{{VERBOSE}}@${VERBOSE}@g
  s@{{DELETE}}@${DELETE}@g" > /tmp/${TEST_NAME}.yaml

kubectl apply -f /tmp/${TEST_NAME}.yaml

kubectl wait --for=condition=complete job/${TEST_NAME}

kubectl logs job/${TEST_NAME}

kubectl delete -f /tmp/${TEST_NAME}.yaml

rm -f /tmp/${TEST_NAME}.yaml

