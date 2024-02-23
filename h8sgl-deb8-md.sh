#!/bin/sh

### CubePath Inc. Installation image, Fork of "https://github.com/hetzneronline/installimage" - installimage

PREREQ="mdadm mdrun multipath"

prereqs()
{
        echo "$PREREQ"
}

case $1 in
# get pre-requisites
prereqs)
        prereqs
        exit 0
        ;;
esac

mdadm --assemble --scan

