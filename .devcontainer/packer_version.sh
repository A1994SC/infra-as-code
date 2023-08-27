#! /bin/bash

# retrive packer release list
PACKER_VERSIONS=$(curl -s https://releases.hashicorp.com/packer/ | grep 'packer_')
VERSION_LIST=()

# backup IFS (internal field separator)
# and change to line endings
xIFS=$IFS
IFS=$'\n'

# for each link retrieved from packer
for pv in $PACKER_VERSIONS
do
  # line looks like:
  # <a href="/packer/1.3.3/">packer_1.3.3</a>
  # strip off everything before packer_1.3.3</a>
  # also strip off the </a>
  # result is plain number for version
  version_part_1=$(echo "$pv" | cut -d '_' -f 2)
  version=$(echo "$version_part_1" | cut -d '<' -f 1)
  VERSION_LIST+=("$version")
done
# reset IFS
IFS=$xIFS

latest=${VERSION_LIST[0]}

curl "https://releases.hashicorp.com/packer/${latest}/packer_${latest}_linux_amd64.zip" -o "/tmp/packer.zip" \
    && unzip -d /tmp/ /tmp/packer.zip \
    && mv /tmp/packer /usr/local/bin/packer \
