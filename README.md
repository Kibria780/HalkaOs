# HalkaOS 🪶

**হালকা OS, ভারী অভিজ্ঞতা।** মাত্র ৪GB RAM-এ প্রিমিয়াম ডেস্কটপ।

HalkaOS একটি ওপেন-সোর্স Linux ডিস্ট্রিবিউশন — Debian 13 "trixie"-এর স্থিতিশীল ভিত্তির উপর
LXQt ডেস্কটপ, আগ্রাসী RAM অপ্টিমাইজেশন (zram + zero-bloat নীতি), আর বাংলা-বান্ধব ডিফল্ট নিয়ে।

- **লক্ষ্য:** boot-এর পর idle-তে **৬০০MB-এর নিচে** RAM ব্যবহার
- **ডেস্কটপ:** LXQt + Openbox + LightDM
- **ইনস্টলার:** Calamares (গ্রাফিক্যাল)
- **বাংলা:** Lohit Bengali ফন্ট + ibus (প্রভাত/জাতীয় লেআউট)

## ISO বানাও

**উপায় ১ — নিজের মেশিনে:**
```bash
git clone https://github.com/halkaos/halkaos.git
cd halkaos
sudo ./build-iso.sh
```
প্রয়োজন: Debian 13, root, ১৫GB ফ্রি ডিস্ক, ইন্টারনেট। ৩০–৯০ মিনিট লাগবে।

**উপায় ২ — GitHub Actions (ক্লাউডে, ফ্রি):**
Actions ট্যাব → "Build HalkaOS ISO" → **Run workflow** → ISO আর্টিফ্যাক্ট ডাউনলোড করো।

## টেস্ট করো
```bash
qemu-system-x86_64 -m 4096 -cdrom halkaos-1.0-amd64.hybrid.iso
# ভেতরে: free -h
```

## লাইসেন্স
GPL — ফ্রি ও ওপেন সোর্স, চিরকাল।
