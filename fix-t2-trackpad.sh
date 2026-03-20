#!/usr/bin/env bash
set -euo pipefail

# Add t2linux GPG key
echo "Adding t2linux GPG key..."
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" \
    | gpg --dearmor \
    | tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null

# Add t2linux apt repo for Ubuntu 25.10 (questing)
echo "Adding t2linux apt repo..."
curl -s --compressed \
    -o /etc/apt/sources.list.d/t2.list \
    "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
echo "deb [signed-by=/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg] https://github.com/AdityaGarg8/t2-ubuntu-repo/releases/download/questing ./" \
    >> /etc/apt/sources.list.d/t2.list

# Update and install T2 kernel
echo "Updating package lists..."
apt update

echo "Installing T2-patched kernel..."
apt install -y linux-t2

echo ""
echo "Done. Please reboot to load the new kernel."
echo "After rebooting, verify with: uname -r  (should show a *-t2 kernel)"
echo "Then check trackpad multitouch: cat /sys/class/input/input7/capabilities/abs"
echo "  (should no longer be all zeros)"
