ARG ALPINE_VERSION=3.8
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="Gabriele Diener <g.diener@me.com>" \
        image="gdiener/ansible" \
        version="1.0" \
        tag="1.0" \
        vendor="gdiener" \
        description="Ansible command line tools." \
        license="MIT"

ARG DEPS=openssh
ARG UID=1000
ARG GID=1000
ARG UNAME=ansible
ARG GNAME=ansible
ARG ANSIBLE_VERSION=2.5.5-r0

ENV SSH_KEY ''

RUN apk add ansible=${ANSIBLE_VERSION} ${DEPS}

RUN addgroup -g ${GID} -S ${GNAME} && \
    adduser -u ${UID} -S -G ${GNAME} ${UNAME}
USER ${UID}:${GID}

RUN mkdir -p /home/${UNAME}/.ssh/

COPY src/entrypoint.sh /bin/entrypoint

WORKDIR /playbook

VOLUME [ "/playbook", "/etc/ansible" ]

ENTRYPOINT [ "entrypoint" ]
CMD [ "ansible", "-h" ]