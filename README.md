# SeiTan-Emulator
### **English Explanation**  
This Bash script (`install.sh`) is an **automated installer** for running **Windows 11** on Android devices via **Termux** and **Termux:X11**. It is designed to handle the entire setup process with minimal user intervention. Here is a breakdown of its core functionality:

1. **System Validation**  
   - It first checks if the script is running inside Termux by verifying the presence of the `termux-setup-storage` command. If not, it exits with an error.

2. **Initial Setup & Dependencies**  
   - Requests storage permissions (`termux-setup-storage`).  
   - Updates and upgrades Termux packages (`pkg update && pkg upgrade`).  
   - Installs required tools: `proot-distro`, `wget`, `curl`, `p7zip`, `tar`, `xz-utils`, `pulseaudio`, and `termux-x11`.

3. **Downloading Windows 11 Files**  
   - Creates a download directory (`/sdcard/Download/windows11`).  
   - Downloads three split archive files (`Win11.7z.001`, `.002`, `.003`) from a **Windroid_11** release on GitHub ([citation:9]). The total size is approximately **2–3 GB**.

4. **Extraction & Configuration**  
   - Extracts the downloaded archives using `7z` into the Termux home directory (`/data/data/com.termux/files/home/`).  
   - Makes the extracted `Win11` script executable.  
   - Automatically runs the `Win11` setup script with predefined inputs (`y`, `N`, `N`, `N`) to accept default configurations.

5. **Creating a Shortcut**  
   - Generates a startup script (`start-windows11.sh`) that sets the `DISPLAY` environment variable, starts `pulseaudio`, and launches the `Win11` script. This shortcut is placed in the Termux home directory for easy access.

6. **Final Instructions**  
   - Displays a completion message with step-by-step instructions to:  
     - Open the **Termux:X11** app.  
     - Run `./start-windows11.sh` in Termux.  
   - Highlights important notes:  
     - On **Android 12+**, you must disable the **Phantom Process Killer** using an ADB command ([citation:9]).  
     - Minimum requirements: **4 GB RAM**, **15 GB free storage**, and an **ARM64** processor.

In essence, this script turns a complex, multi-step process into a **single-command installation** for running Windows 11 on an Android device through Termux.

---

### **توضیحات فارسی**  
این اسکریپت bash (با نام `install.sh`) یک **نصب‌کننده خودکار** برای اجرای **ویندوز ۱۱** روی دستگاه‌های اندروید از طریق **Termux** و **Termux:X11** است. هدف آن انجام تمام مراحل راه‌اندازی با کمترین دخالت کاربر است. عملکرد اصلی آن به شرح زیر است:

1. **اعتبارسنجی سیستم**  
   - ابتدا بررسی می‌کند که اسکریپت در محیط Termux اجرا می‌شود یا نه (با بررسی وجود دستور `termux-setup-storage`). در غیر این صورت، با خطا خارج می‌شود.

2. **راه‌اندازی اولیه و وابستگی‌ها**  
   - درخواست دسترسی به حافظه (`termux-setup-storage`).  
   - به‌روزرسانی و ارتقای پکیج‌های Termux (`pkg update && pkg upgrade`).  
   - نصب ابزارهای مورد نیاز: `proot-distro`، `wget`، `curl`، `p7zip`، `tar`، `xz-utils`، `pulseaudio` و `termux-x11`.

3. **دانلود فایل‌های ویندوز ۱۱**  
   - ایجاد پوشه دانلود (`/sdcard/Download/windows11`).  
   - دانلود سه فایل آرشیو چندبخشی (`Win11.7z.001`، `.002` و `.003`) از یک انتشار در GitHub مربوط به **Windroid_11** ([citation:9]). حجم کل تقریباً **۲ تا ۳ گیگابایت** است.

4. **استخراج و پیکربندی**  
   - استخراج آرشیوهای دانلود شده با استفاده از `7z` در پوشه خانه Termux (`/data/data/com.termux/files/home/`).  
   - قابل اجرا کردن اسکریپت `Win11` استخراج شده.  
   - اجرای خودکار اسکریپت راه‌اندازی `Win11` با ورودی‌های از پیش تعیین شده (`y`، `N`، `N`، `N`) برای پذیرش تنظیمات پیش‌فرض.

5. **ایجاد میانبر**  
   - تولید یک اسکریپت راه‌اندازی (`start-windows11.sh`) که متغیر محیطی `DISPLAY` را تنظیم، `pulseaudio` را شروع و اسکریپت `Win11` را اجرا می‌کند. این میانبر در پوشه خانه Termux قرار می‌گیرد تا دسترسی آسان باشد.

6. **دستورالعمل نهایی**  
   - نمایش پیام تکمیل با راهنمای گام‌به‌گام برای:  
     - باز کردن اپلیکیشن **Termux:X11**.  
     - اجرای `./start-windows11.sh` در Termux.  
   - تأکید بر نکات مهم:  
     - در **اندروید ۱۲ و بالاتر**، باید **Phantom Process Killer** را با استفاده از دستور ADB غیرفعال کنید ([citation:9]).  
     - حداقل نیازمندی‌ها: **۴ گیگابایت رم**، **۱۵ گیگابایت فضای خالی** و پردازنده **ARM64**.
