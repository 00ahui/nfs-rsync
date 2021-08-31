# NFS Rsync

Docker image for synchronizing data to NFS Share

## Build

```sh
docker build -t 00ahui/nfs-rsync .
```

## Variables

### Enviorments

- NFS_SHARE:   NFS Share path, example: 10.96.171.215:/
- NFS_OPTIONS: NFS mount options, example: nfsvers=4.2,port=2049
- DELETE:      Delete target files if not exist in source, yes/true or no/false
- VERBOSE:     Show verbose information, yes/true or no/false

### Volumes

- /source:     Source Directory


## How to

### Run docker

Need to run as privildeged in order to mount nfs share

```sh
docker run --privileged \
           -v /mnt/dir1:/source \
           -e NFS_SHARE="8.46.188.30:/" \
           -e NFS_OPTIONS="nfsvers=4.2,port=31154" \
           -e DELETE="false" \
           -e VERBOSE="true" \
           00ahui/nfs-rsync
```

### Run K8S Job

A job template hack/template.yaml can be used to generate K8S Job

```sh
sh hack/nfs-rsync-job.sh job1 source-pvc "8.46.188.30:/" "nfsvers=4.2,port=31154"
```

