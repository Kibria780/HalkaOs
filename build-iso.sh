#!/bin/bash
# ============================================================
# HalkaOS 1.0 — এক-কমান্ড ISO বিল্ডার
# চালাও: sudo ./build-iso.sh
# প্রয়োজন: Debian 13 মেশিন (বা VM), root, ১৫GB ফ্রি ডিস্ক, ইন্টারনেট
# সময়: ৩০-৯০ মিনিট
# ============================================================
set -e

if [ "$(id -u)" -ne 0 ]; then
  echo "root হিসেবে চালাও: sudo ./build-iso.sh"
  exit 1
fi

cd "$(dirname "$0")"

echo "==> [1/4] বিল্ড টুল ইনস্টল করা হচ্ছে..."
apt-get update
apt-get install -y live-build debootstrap debian-archive-keyring \
  squashfs-tools xorriso isolinux syslinux-efi grub-pc-bin \
  grub-efi-amd64-bin mtools dosfstools

echo "==> [2/4] live-build কনফিগার করা হচ্ছে..."
chmod +x auto/config
./auto/config

echo "==> [3/4] ISO বিল্ড হচ্ছে (এই ধাপে সময় লাগবে, চা খেয়ে আসো)..."
lb build

echo "==> [4/4] ফাইনাল নাম + চেকসাম..."
# Ubuntu-এর live-build নিজের নামে ISO বানায় — HalkaOS নামে রিনেম করো
if ls live-image-*.iso >/dev/null 2>&1 && ! ls halkaos-*.iso >/dev/null 2>&1; then
  mv live-image-*.hybrid.iso halkaos-1.0-amd64.hybrid.iso 2>/dev/null || \
  mv live-image-*.iso halkaos-1.0-amd64.hybrid.iso
fi
sha256sum halkaos-*.iso > halkaos-1.0-amd64.iso.sha256

echo ""
echo "=============================================="
echo "  হোইসে! 🎉  ISO তৈরি:"
ls -lh halkaos-*.iso
echo "  SHA256:"
cat halkaos-1.0-amd64.iso.sha256
echo "=============================================="
echo "টেস্ট করো (৪GB RAM দিয়ে):"
echo "  qemu-system-x86_64 -m 4096 -cdrom halkaos-1.0-amd64.hybrid.iso"
echo "ভেতরে চালাও: free -h   →  লক্ষ্য: idle-তে ৬০০MB-এর নিচে"
