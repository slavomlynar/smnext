# SMNext: Fedora Kinoite (KDE Plasma, atomický) + hardening + macOS vzhľad.
# Štandardné Fedora jadro (signované, Secure Boot funguje); Surface Go 2 ho podporuje.
FROM ghcr.io/ublue-os/kinoite-main:latest

COPY system_files/ /
COPY build/build.sh /tmp/build.sh
RUN /tmp/build.sh && rm /tmp/build.sh && bootc container lint
