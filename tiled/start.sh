#!/usr/bin/env bash

echo "tiled ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

set -e
set -o pipefail
cd /project
su tiled -c "/usr/bin/tiled"
