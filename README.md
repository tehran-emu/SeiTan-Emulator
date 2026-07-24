

# راهنمای کامل نصب SeiTan Emulator روی Termux

## 📖 درباره اسکریپت (About the Script)

**فارسی:**  
اسکریپت `install.sh` متعلق به پروژه **SeiTan Emulator**، یک ابزار خودکار برای نصب و اجرای ویندوز ۱۱ در محیط Termux روی دستگاه‌های اندرویدی است. این اسکریپت تمام مراحل مورد نیاز از جمله نصب وابستگی‌ها، دانلود فایل‌های ویندوز، استخراج و تنظیمات اولیه را به صورت کاملاً خودکار انجام می‌دهد [citation:9].

**English:**  
The `install.sh` script from the **SeiTan Emulator** project is an automated tool for installing and running Windows 11 within the Termux environment on Android devices. This script handles all necessary steps, including dependency installation, downloading Windows files, extraction, and initial setup, fully automatically [citation:9].

---

## 🚀 مراحل نصب در گیت‌هاب و ترموکس (GitHub & Termux Installation Steps)

### **مرحله ۱: آماده‌سازی Termux** (Step 1: Prepare Termux)
*   نسخه مناسب Termux را از **F-Droid** یا **GitHub** نصب کنید (نسخه Google Play محدودیت دارد) [citation:9].
*   دسترسی‌های لازم را به برنامه بدهید.

### **مرحله ۲: اجرای دستور نصب** (Step 2: Run the Installation Command)
یک دستور ساده کافی است. این دستور اسکریپت را از مخزن گیت‌هاب دانلود و اجرا می‌کند:

```bash
curl -s https://raw.githubusercontent.com/tehran-emu/SeiTan-Emulator/refs/heads/main/install.sh | bash
```

**توجه:** در صورت بروز مشکل در دانلود، می‌توانید مخزن را Clone کنید:
```bash
git clone https://github.com/tehran-emu/SeiTan-Emulator.git
cd SeiTan-Emulator
chmod +x install.sh
./install.sh
```

### **مرحله ۳: طی کردن فرآیند خودکار نصب** (Step 3: Follow the Automated Process)
اسکریپت به ترتیب زیر را انجام می‌دهد [citation:9]:
1.  **بررسی سیستم** (System Check): اطمینان از اجرا در Termux.
2.  **راه‌اندازی اولیه** (Initial Setup): درخواست دسترسی به حافظه و به‌روزرسانی پکیج‌ها (`pkg update`).
3.  **نصب وابستگی‌ها** (Install Dependencies): نصب خودکار ابزارهای مورد نیاز مانند `proot-distro`, `wget`, `p7zip`, `termux-x11` و غیره.
4.  **دانلود فایل‌های ویندوز** (Download Windows): دانلود فایل‌های ویندوز ۱۱ (حدود ۲-۳ گیگابایت) از منابع معتبر [citation:9].
5.  **استخراج فایل‌ها** (Extract Files): خارج‌سازی فایل‌ها در دایرکتوری خانه Termux (حدود ۱۵ دقیقه زمان می‌برد).
6.  **راه‌اندازی ویندوز** (Setup Windows): اجرای اسکریپت تنظیمات اولیه ویندوز.
7.  **ایجاد میانبر** (Create Shortcut): ساخت فایل اجرایی `start-windows11.sh` برای راه‌اندازی آسان‌تر.

### **مرحله ۴: اجرای ویندوز ۱۱** (Step 4: Run Windows 11)
پس از اتمام نصب، برای اجرای ویندوز ۱۱:
1.  اپلیکیشن **Termux:X11** را باز کنید (قبل از اجرا).
2.  در ترمینال Termux، دستور زیر را وارد کنید:
    ```bash
    ./start-windows11.sh
    ```
3.  منتظر بمانید تا محیط گرافیکی ویندوز ۱۱ بارگذاری شود.

---

## ⚠️ نکات حیاتی و عیب‌یابی (Important Notes & Troubleshooting)

### **۱. غیرفعال کردن Phantom Process Killer (اندروید ۱۲ و بالاتر)**
برای جلوگیری از بسته‌شدن خودکار فرآیندها توسط سیستم، این دستور را از طریق **ADB** اجرا کنید [citation:9]:
```bash
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
```

### **۲. رفع مشکل صفحه سیاه در Termux:X11**
اگر پس از اجرا صفحه سیاه دیدید، این دستورات را در Termux اجرا کنید:
```bash
for file in $(find /usr -type f -iname "*login1*"); do 
    mv -v $file "$file.back"
done
echo "chmod u+s /usr/lib/dbus-1.0/dbus-daemon-launch-helper" >> ~/.bashrc
exit
```

### **۳. حداقل نیازمندی‌های سخت‌افزاری**
*   **رم آزاد:** حداقل ۴ گیگابایت (توصیه ۶+ گیگابایت) [citation:9].
*   **فضای ذخیره‌سازی:** حداقل ۱۵ گیگابایت خالی [citation:9].
*   **پردازنده:** معماری ARM64 پشتیبانی می‌شود [citation:9].

### **۴. نکته عملکردی**
برای بهبود سرعت، در برنامه Termux:X11 کیفیت تصویر را روی حالت "High" تنظیم کنید.

---

## 📚 منابع و الهام‌گیری (Sources & Inspiration)
این پروژه بر اساس کارهای موفق جامعه منبع‌باز مانند **Windroid Emulator** [citation:9] و **BOXVIDRA Emulator** ساخته شده است.
# راهنمای کامل نصب SeiTan Emulator روی کامپیوتر (نسخه PC)

---

## 🖥️ مقدمه (Introduction)

**SeiTan Emulator PC Edition** یک راه‌حل برای اجرای محیط شبیه‌سازی‌شده Termux و ویندوز ۱۱ روی کامپیوترهای شخصی است. این نسخه به کاربران اجازه می‌دهد تا بدون نیاز به گوشی اندروید، از امکانات SeiTan Emulator برای تست امنیتی و بررسی فایل‌های مشکوک استفاده کنند [citation:9].

---

## 🎯 هدف نسخه PC (PC Edition Purpose)

- ✅ اجرای محیط Termux روی ویندوز، لینوکس و مک
- ✅ تست فایل‌های مشکوک در محیط ایزوله
- ✅ استفاده از منابع سخت‌افزاری قوی‌تر کامپیوتر
- ✅ کار با فایل‌های حجیم بدون محدودیت حافظه موبایل

---

## 🛠️ روش‌های نصب روی کامپیوتر (PC Installation Methods)

### روش ۱: نصب با شبیه‌ساز اندروید (Android Emulator) ⭐ ساده‌ترین

این روش برای کاربرانی که می‌خواهند دقیقاً همان تجربه موبایل را روی PC داشته باشند مناسب است.

#### **مرحله ۱: نصب شبیه‌ساز اندروید**
یکی از شبیه‌سازهای زیر را نصب کنید:
- **BlueStacks** (پیشنهادی برای کاربران عادی)
- **LDPlayer** (سبک و سریع)
- **NoxPlayer** (امکانات پیشرفته)
- **MEmu** (مناسب برای تست)

#### **مرحله ۲: نصب Termux در شبیه‌ساز**
```bash
# 1. Google Play را در شبیه‌ساز باز کنید
# 2. Termux را جستجو و نصب کنید
# 3. سپس دستورات نصب SeiTan را اجرا کنید:

termux-setup-storage
pkg update -y && pkg upgrade -y
pkg install proot p7zip pulseaudio wget -y
cd /sdcard/Download/

# دانلود فایل‌های ویندوز
wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.001
wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.002
wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.003

# استخراج و اجرا
7z x ./Win11.7z.001 -o/data/data/com.termux/files/home/
cd /data/data/com.termux/files/home/
chmod +x ./Win11
./Win11
```

#### **مزایا و معایب روش شبیه‌ساز:**
| مزایا (Pros) | معایب (Cons) |
|-------------|-------------|
| ✅ تجربه دقیقاً مشابه موبایل | ❌ مصرف بالای RAM و CPU |
| ✅ بدون نیاز به تنظیمات اضافی | ❌ کندتر از اجرای مستقیم |
| ✅ امکان تست روی سیستم‌عامل‌های مختلف | ❌ نیاز به نصب نرم‌افزار سنگین |

---

### روش ۲: اجرای مستقیم با WSL (Windows Subsystem for Linux) ⭐ پیشنهادی برای ویندوز

این روش برای کاربران ویندوز ۱۰/۱۱ که می‌خواهند محیط لینوکس را به‌صورت یکپارچه اجرا کنند، عالی است.

#### **مرحله ۱: نصب WSL**
```powershell
# PowerShell را به عنوان Administrator اجرا کنید
wsl --install

# پس از نصب، سیستم را ریستارت کنید
# سپس Ubuntu را از Microsoft Store نصب کنید
```

#### **مرحله ۲: نصب ابزارهای مورد نیاز در WSL**
```bash
# در ترمینال Ubuntu (WSL):
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl p7zip-full wine qemu-system-x86-64
```

#### **مرحله ۳: نصب SeiTan Emulator در WSL**
```bash
# ایجاد دایرکتوری
mkdir -p ~/seitan-pc
cd ~/seitan-pc

# دانلود اسکریپت
wget https://raw.githubusercontent.com/tehran-emu/SeiTan-Emulator/main/install-sandbox.sh
chmod +x install-sandbox.sh

# اجرا با تنظیمات مخصوص PC
./install-sandbox.sh --pc-mode
```

#### **مرحله ۴: اجرای محیط سندباکس**
```bash
# اجرا با تنظیمات گرافیکی
export DISPLAY=:0
./run-sandbox.sh
```

> **نکته:** برای نمایش گرافیکی در WSL، نیاز به نصب X Server مانند VcXsrv یا Xming دارید.

#### **مزایا و معایب روش WSL:**
| مزایا (Pros) | معایب (Cons) |
|-------------|-------------|
| ✅ سرعت بالا (نزدیک به سیستم اصلی) | ❌ نیاز به ویندوز ۱۰/۱۱ |
| ✅ مصرف منابع بهینه | ❌ تنظیمات اولیه پیچیده‌تر |
| ✅ دسترسی کامل به سخت‌افزار | ❌ نیاز به دانش لینوکس |

---

### روش ۳: استفاده از ماشین مجازی (Virtual Machine) برای لینوکس و مک

#### **نصب روی لینوکس:**
```bash
# نصب QEMU یا VirtualBox
sudo apt install qemu-kvm qemu-utils -y

# ایجاد دیسک مجازی
qemu-img create -f qcow2 seitan-pc.qcow2 30G

# اجرای ویندوز ۱۱ در ماشین مجازی
qemu-system-x86_64 -m 4096 -cpu host -enable-kvm \
  -drive file=seitan-pc.qcow2,format=qcow2 \
  -cdrom Windows11.iso -boot d
```

#### **نصب روی مک:**
```bash
# نصب Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# نصب QEMU
brew install qemu

# اجرای ماشین مجازی
qemu-system-x86_64 -m 4096 -accel hvf \
  -drive file=seitan-pc.qcow2,format=qcow2 \
  -cdrom Windows11.iso -boot d
```

---

### روش ۴: نصب مستقیم Wine روی ویندوز و لینوکس

برای اجرای برنامه‌های ویندوز بدون نیاز به ماشین مجازی کامل:

#### **روی لینوکس:**
```bash
# نصب Wine
sudo apt install wine wine32 wine64 -y

# اجرای فایل اجرایی
wine suspect_file.exe
```

#### **روی ویندوز:**
```bash
# 1. Wine را دانلود و نصب کنید
# 2. سپس فایل اجرایی را با Wine باز کنید
```

---

## 📁 ساختار دایرکتوری نسخه PC

```
~/seitan-pc/                    # دایرکتوری اصلی
│
├── install-sandbox.sh         # اسکریپت نصب
├── run-sandbox.sh             # اسکریپت اجرا
│
├── windows/                    # فایل‌های ویندوز
│   ├── Win11                  # فایل اجرایی
│   └── [فایل‌های سیستمی]
│
├── temp/                       # فایل‌های موقت
├── downloads/                  # فایل‌های تست
│
├── backups/                    # پشتیبان‌ها
│   └── backup_latest/
│
├── config/                     # تنظیمات
│   ├── wine.conf              # تنظیمات Wine
│   └── qemu.conf             # تنظیمات QEMU
│
└── logs/                       # لاگ‌ها
    └── sandbox.log
```

---

## 🎮 منوی اجرا در نسخه PC

```bash
./run-sandbox.sh
```

منوی زیر نمایش داده می‌شود:
```
╔═══════════════════════════════════════════════╗
║ 🖥️  SeiTan PC Sandbox Mode
╚═══════════════════════════════════════════════╝

1) اجرای ویندوز در حالت سندباکس (پاک - توصیه شده) ⭐
2) اجرا با حفظ تغییرات جلسه قبل (خطرناک‌تر) ⚠️
3) گرفتن عکس‌فوری از وضعیت فعلی 📸
4) بازگردانی به آخرین وضعیت پاک 🔄
5) اجرا با Wine (برای فایل‌های EXE) 🍷
6) اجرا با QEMU (ماشین مجازی کامل) 🖥️
7) حذف تمام محیط سندباکس 🗑️
8) خروج 🚪
```

---

## ⚙️ تنظیمات پیشرفته (Advanced Settings)

### ۱. تنظیم حافظه اختصاصی
```bash
# تنظیم مقدار RAM برای ویندوز مجازی
export SEITAN_RAM=4096  # 4GB

# یا در فایل config/wine.conf
[Memory]
Size=4096
```

### ۲. فعال‌سازی شتاب سخت‌افزاری
```bash
# برای WSL
export DISPLAY=:0
export LIBGL_ALWAYS_SOFTWARE=0

# برای QEMU
qemu-system-x86_64 -enable-kvm -cpu host
```

### ۳. تنظیمات شبکه
```bash
# قطع کامل اینترنت برای تست امنیتی
sudo ufw default deny outgoing
# یا
export SEITAN_OFFLINE=true
```

---

## 🧪 تست فایل مشکوک در نسخه PC

### **مرحله ۱: انتقال فایل**
```bash
# کپی فایل به پوشه downloads
cp ~/Downloads/suspect_file.exe ~/seitan-pc/downloads/
```

### **مرحله ۲: انتخاب روش اجرا**

#### **گزینه A: اجرا با Wine (سریع‌ترین)**
```bash
# انتخاب گزینه 5 در منو
# یا اجرای مستقیم:
wine ~/seitan-pc/downloads/suspect_file.exe
```

#### **گزینه B: اجرا در سندباکس کامل (ایمن‌ترین)**
```bash
# انتخاب گزینه 1 در منو
./run-sandbox.sh
# سپس فایل را در ویندوز مجازی باز کنید
```

#### **گزینه C: اجرا در ماشین مجازی QEMU (ایزوله‌ترین)**
```bash
# انتخاب گزینه 6 در منو
# یا اجرای مستقیم:
qemu-system-x86_64 -m 4096 -enable-kvm \
  -drive file=~/seitan-pc/windows/Win11.qcow2 \
  -net none  # شبکه غیرفعال
```

---

## 🛡️ مقایسه روش‌های اجرا روی PC

| روش (Method) | امنیت (Security) | سرعت (Speed) | سهولت (Ease) | کارایی (Performance) |
|-------------|-----------------|--------------|--------------|---------------------|
| **شبیه‌ساز اندروید** | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| **WSL + Wine** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **QEMU/VM** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Wine مستقیم** | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## 🔧 رفع مشکلات رایج نسخه PC

### **مشکل ۱: صفحه سیاه در WSL**
```bash
# نصب X Server
# برای ویندوز: VcXsrv یا Xming نصب کنید
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
```

### **مشکل ۲: کندی در شبیه‌ساز اندروید**
```bash
# در تنظیمات شبیه‌ساز:
- افزایش RAM اختصاصی به ۴GB+
- فعال‌سازی VT-x/AMD-V
- استفاده از حالت Compatibility
```

### **مشکل ۳: خطای Permission در WSL**
```bash
# تغییر مجوزها
sudo chmod -R 755 ~/seitan-pc/
sudo chown -R $USER:$USER ~/seitan-pc/
```

### **مشکل ۴: عدم نمایش گرافیک در QEMU**
```bash
# نصب VNC Viewer
qemu-system-x86_64 -vnc :1 -vga std
# سپس با VNC Viewer به localhost:5901 متصل شوید
```

---

## 📊 نیازمندی‌های سخت‌افزاری نسخه PC

| کامپوننت (Component) | حداقل (Minimum) | توصیه شده (Recommended) |
|---------------------|-----------------|------------------------|
| **پردازنده (CPU)** | Intel Core i3 / AMD Ryzen 3 | Intel Core i7 / AMD Ryzen 7 |
| **رم (RAM)** | ۶ گیگابایت | ۱۶+ گیگابایت |
| **فضای ذخیره‌سازی** | ۲۰ گیگابایت | ۵۰+ گیگابایت |
| **کارت گرافیک** | Intel HD Graphics | NVIDIA/AMD با ۲GB+ VRAM |
| **سیستم‌عامل** | ویندوز ۱۰، لینوکس، macOS 10.15+ | آخرین نسخه سیستم‌عامل |

---

## ❓ سوالات متداول نسخه PC (PC FAQ)

<details>
<summary><b>آیا می‌توانم SeiTan Emulator را روی مک اجرا کنم؟</b></summary>
<br>
بله، با استفاده از روش QEMU یا شبیه‌سازهای اندروید (مثل BlueStacks برای مک) امکان‌پذیر است.
</details>

<details>
<summary><b>کدام روش برای تست بدافزار ایمن‌تر است؟</b></summary>
<br>
روش QEMU با شبکه غیرفعال و جداسازی کامل سخت‌افزاری، ایمن‌ترین گزینه است. روش WSL در رتبه دوم قرار دارد.
</details>

<details>
<summary><b>آیا نسخه PC از گوشی سریع‌تر است؟</b></summary>
<br>
بله، به دلیل سخت‌افزار قوی‌تر، نسخه PC به طور قابل‌توجهی سریع‌تر از نسخه موبایل است.
</details>

<details>
<summary><b>آیا می‌توانم از ویندوز اصلی به عنوان میزبان استفاده کنم؟</b></summary>
<br>
بله، از طریق WSL می‌توانید ویندوز اصلی را حفظ کنید و محیط ایزوله را در کنار آن اجرا کنید.
</details>

---

## 📞 پشتیبانی نسخه PC

- **مخزن گیت‌هاب:** [github.com/tehran-emu/SeiTan-Emulator](https://github.com/tehran-emu/SeiTan-Emulator)
- **بخش Issues:** گزارش مشکلات مرتبط با PC
- **بخش Discussions:** تبادل نظر و راهنمایی

---

<div dir="rtl">

**ساخته شده با ❤️ برای جامعه امنیت سایبری و کاربران حرفه‌ای**

</div>

---

*نسخه: ۲.۱.۰ (PC Edition) | آخرین به‌روزرسانی: جولای ۲۰۲۶*
