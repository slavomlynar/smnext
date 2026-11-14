# SMNext

Atomický linuxový systém na báze **Fedora Kinoite (KDE Plasma)**, vyladený pre PC aj Surface Go 2.
Obraz sa zostavuje automaticky na GitHube a do počítača sa dostane ako aktualizácia.

## Čo obsahuje
- **Bezpečnosť:** štandardné signované Fedora jadro (Secure Boot funguje), SELinux, spevnené kernel parametre (`kargs.d`) a sysctl, prísny firewall (zóna `public`), vypnuté avahi/mDNS, bez telemetrie.
- **Anonymita:** náhodná MAC pri Wi-Fi aj Ethernete, IPv6 privacy adresy, DNS cez TLS (Quad9), nainštalovaný Tor, Tor Browser a WireGuard.
- **Stabilita:** atomické aktualizácie s rollbackom (`bootc rollback`), aplikácie vo Flatpak sandboxoch.
- **Plynulosť:** zram + ladenie `vm.*` pre malú RAM (Surface Go 2 má 4 alebo 8 GB).
- **Dotyk:** Maliit klávesnica, automatická rotácia (iio-sensor-proxy).
- **Vyhľadávanie:** Baloo s indexovaním obsahu súborov + Recoll na hlbšie fulltextové hľadanie.
- **Vzhľad:** téma WhiteSur (macOS štýl).

## Inštalácia (raz)
1. Na GitHube vytvor **nový repozitár** (napr. `smnext`), nahraj doň obsah tohto priečinka a v záložke *Actions* povoľ workflow. Po prvom builde (cca 15 min) sa objaví balík v *Packages*, nastav ho ako **Public**.
2. Stiahni **Fedora Kinoite ISO**, daj na USB. Surface Go 2 má len USB-C, treba hub. Do UEFI sa dostaneš tak, že pri zapnutí držíš tlačidlo hlasitosti hore. Secure Boot nechaj zapnutý.
3. Pri inštalácii zvoľ **šifrovanie disku (LUKS)** a jazyk/klávesnicu.
4. Po prvom štarte:
   ```
   sudo bootc switch ghcr.io/<tvoj-github-login>/smnext:latest
   systemctl reboot
   ```
5. Po reštarte (aj po prvom Flatpak stiahnutí, chvíľu trvá) spusti `smnext-look` pre macOS vzhľad.

## Poznámky
- Obraz **nebol zostavený ani spustený** v prostredí, kde vznikol (nie je tam podman). Prvý build môže vyžadovať drobné opravy. Chyby z GitHub Actions mi pošli.
- Kamera na Surface Go 2 je na Linuxe slabá, je to obmedzenie hardvéru, nie tohto obrazu.
- Claude, ChatGPT a Gemini nemajú oficiálne desktopové aplikácie pre Linux, používaj ich cez prehliadač (môžeš ich pripnúť ako web aplikácie).
- Tor/VPN je zatiaľ **nainštalovaný, nie vynútený** pre všetku prevádzku. Vynútený kill-switch je ďalšia etapa.

---
SMNext © mlynar.org. Verzia je v súbore `VERSION`, zmeny v `CHANGELOG.md`.
