#!/usr/bin/env bash

groupmod -g ${GID} -n ${USERNAME} code
usermod -u ${UID} -l ${USERNAME} -m -d /home/${USERNAME} code
#chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} /code
echo "${USERNAME}	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

if [ ${PORT} ]; then

    mkdir -p /var/run/sshd
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

    echo "${USERNAME}:${USERNAME}" | chpasswd
    sed -i "/^Port /c\Port ${PORT}" /etc/ssh/sshd_config

    /usr/sbin/sshd -D

else

    set -e
    set -o pipefail
    cd /project
    sudo -H -u ${USERNAME} "$@"

fi
