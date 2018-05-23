FROM alpine
LABEL maintainer="me@schneider.ax"

COPY run.sh /usr/local/bin/run.sh

RUN apk update && \
    apk add rsync openssh sshpass && \
    chmod +x /usr/local/bin/run.sh && \
    ssh-keygen -qf /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -qf /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
    ssh-keygen -qf /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa && \
    ssh-keygen -qf /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 && \
    printf "PermitRootLogin yes\nPasswordAuthentication yes" > /etc/ssh/sshd_config

EXPOSE 22
ENTRYPOINT /usr/local/bin/run.sh
