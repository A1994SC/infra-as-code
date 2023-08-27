#! /bin/bash

# retrive terraform release list
TERRAFORM_VERSIONS=$(curl -s https://releases.hashicorp.com/terraform/ | grep 'terraform_')
VERSION_LIST=()

# backup IFS (internal field separator)
# and change to line endings
xIFS=$IFS
IFS=$'\n'

# for each link retrieved from terraform
for pv in $TERRAFORM_VERSIONS
do
  # line looks like:
  # <a href="/terraform/0.12.8/">terraform_0.12.8</a>
  # strip off everything before terraform_0.12.8</a>
  # also strip off the </a>
  # result is plain number for version
  version_part_1=$(echo "$pv" | cut -d '_' -f 2)
  version=$(echo "$version_part_1" | cut -d '<' -f 1)
  VERSION_LIST+=("$version")
done
# reset IFS
IFS=$xIFS

latest=${VERSION_LIST[0]}

curl "https://releases.hashicorp.com/terraform/${latest}/terraform_${latest}_linux_amd64.zip" -o "/tmp/terraform.zip" \
    && unzip -d /tmp/ /tmp/terraform.zip \
    && mv /tmp/terraform /usr/local/bin/terraform \
