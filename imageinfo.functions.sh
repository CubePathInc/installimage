#!/usr/bin/env bash

#
# imageinfo functions
#
# (c) 2019-2022, CubePath Inc. Installation image, Fork of "https://github.com/hetzneronline/installimage"
#

debian_buster_image() {
  [[ "${IAM,,}" == 'debian' ]] || return 1
  ( ((IMG_VERSION >= 100)) && ((IMG_VERSION <= 109)) ) || ( ((IMG_VERSION >= 1010)) && ((IMG_VERSION < 1100)) )
}

debian_bullseye_image() {
  [[ "${IAM,,}" == 'debian' ]] || return 1
  ((IMG_VERSION >= 1100)) && ((IMG_VERSION <= 1200))
}

debian_bookworm_image() {
  [[ "${IAM,,}" == 'debian' ]] || return 1
  ((IMG_VERSION >= 1200)) && ((IMG_VERSION <= 1300))
}

other_image() {
  local image="$1"
  while read other_image; do
    [[ "${image##*/}" == "$other_image" ]] && return 0
  done < <(other_images)
  return 1
}

old_image() {
  local image="$1"
  image="$(readlink -f "$image")"
  [[ -e "$image" ]] || return 1
  [[ "${image%/*}" == "$(readlink -f "$OLDIMAGESPATH")" ]]
}

rhel_based_image() {
  [[ "$IAM" == 'centos' ]] ||
  [[ "$IAM" == 'rockylinux' ]] ||
  [[ "$IAM" == 'almalinux' ]] ||
  [[ "$IAM" == 'rhel' ]]
}

rhel_9_based_image() {
  [[ "$IAM" == 'centos' ]] && ((IMG_VERSION >= 90)) && ((IMG_VERSION != 610)) && return
  rhel_based_image && ((IMG_VERSION >= 90)) && return
  return 1
}

uses_network_manager() {
  [[ "$IAM" == 'centos' ]] && ((IMG_VERSION >= 80)) && ((IMG_VERSION != 610)) && ! is_cpanel_install && return
  [[ "$IAM" == 'rockylinux' ]] && return
  [[ "$IAM" == 'rhel' ]] && return
  [[ "$IAM" == 'almalinux' ]] && ! is_cpanel_install && return
  return 1
}

debian_based_image() {
  [[ "$IAM" == 'debian' ]] || [[ "$IAM" == 'ubuntu' ]]
}

hwe_image() {
  [[ "$IMAGE_FILE" =~ -hwe\. ]]
}

image_requires_xfs_version_check() {
  [[ "$IAM" == 'ubuntu' ]] && ((IMG_VERSION <= 2004)) && return 0
  [[ "$IAM" == 'debian' ]] && ((IMG_VERSION < 1100)) && return 0
  return 1
}

# vim: ai:ts=2:sw=2:et
