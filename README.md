# SeiTan-Emulator

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
