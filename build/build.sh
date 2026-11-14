#!/usr/bin/bash
set -euxo pipefail

# Balíky: fulltext (recoll), Tor/VPN nástroje, dotyk (klávesnica, rotácia), Kvantum téma engine
dnf5 install -y recoll poppler-utils tor torsocks wireguard-tools \
    maliit-keyboard iio-sensor-proxy kvantum rsms-inter-fonts

# macOS vzhľad (WhiteSur); nainštaluje sa systémovo do /usr/share
t=$(mktemp -d)
for r in WhiteSur-kde WhiteSur-icon-theme WhiteSur-cursors; do
    curl -fsSL "https://github.com/vinceliuice/$r/archive/refs/heads/master.tar.gz" | tar -xz -C "$t"
    (cd "$t/$r-master" && ./install.sh)
done
rm -rf "$t"

# Firewall: prísna predvolená zóna (Fedora Workstation zóna otvára porty 1025-65535)
sed -i 's/^DefaultZone=.*/DefaultZone=public/' /etc/firewalld/firewalld.conf

# Menej úniku informácií do siete: mDNS (avahi), countme štatistika
systemctl disable avahi-daemon.service avahi-daemon.socket || true
systemctl mask rpm-ostree-countme.timer

# Flatpaky sa nainštalujú pri prvom štarte siete
systemctl enable smnext-flatpaks.service

chmod +x /usr/bin/smnext-look /usr/bin/smnext-netlock
dnf5 clean all

# Branding + verzia (ID zostáva fedora kvôli kompatibilite nástrojov)
v=$(cat /usr/share/smnext/VERSION)
sed -i "s/^PRETTY_NAME=.*/PRETTY_NAME=\"SMNext $v (Fedora Kinoite base)\"/" /usr/lib/os-release
printf 'IMAGE_ID=smnext\nIMAGE_VERSION=%s\n' "$v" >> /usr/lib/os-release
