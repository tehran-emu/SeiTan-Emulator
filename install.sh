#!/bin/bash

# SeiTan Emulator - Windows 11 Installer for Termux
# این اسکریپت به صورت خودکار ویندوز ۱۱ را در ترموکس نصب می‌کند

set -e

# رنگ‌ها برای نمایش بهتر
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# توابع نمایش
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${YELLOW}=== $1 ===${NC}"
}

# بررسی سیستم
check_system() {
    print_step "بررسی سیستم"
    
    if ! command -v termux-setup-storage &> /dev/null; then
        print_error "این اسکریپت فقط در Termux اجرا می‌شود!"
        exit 1
    fi
    
    print_success "سیستم مناسب است"
}

# راه‌اندازی اولیه
setup_initial() {
    print_step "راه‌اندازی اولیه Termux"
    
    print_info "درخواست دسترسی به حافظه..."
    termux-setup-storage
    
    print_info "بروزرسانی پکیج‌ها..."
    pkg update -y
    pkg upgrade -y
    
    print_success "راه‌اندازی اولیه کامل شد"
}

# نصب وابستگی‌ها
install_dependencies() {
    print_step "نصب وابستگی‌ها"
    
    local deps="proot-distro wget curl p7zip tar xz-utils pulseaudio termux-x11"
    
    print_info "نصب: $deps"
    pkg install -y $deps
    
    # نصب proot-distro برای اجرای توزیع‌های لینوکس
    print_info "نصب proot-distro..."
    pkg install proot-distro -y
    
    print_success "همه وابستگی‌ها نصب شدند"
}

# دانلود فایل‌های ویندوز ۱۱
download_windows() {
    print_step "دانلود فایل‌های ویندوز ۱۱"
    
    local download_dir="/sdcard/Download/windows11"
    mkdir -p "$download_dir"
    
    print_info "دانلود فایل‌های مورد نیاز (حدود ۲-۳ گیگابایت)..."
    print_info "این مرحله ممکن است زمان‌بر باشد"
    
    # دانلود فایل‌های ویندوز ۱۱ (مشابه روش Windroid) [citation:9]
    cd "$download_dir"
    wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.001
    wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.002
    wget https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.003
    
    print_success "دانلود کامل شد"
}

# استخراج فایل‌ها
extract_files() {
    print_step "استخراج فایل‌ها"
    
    print_info "استخراج فایل‌های ویندوز ۱۱ (حدود ۱۵ دقیقه)..."
    
    # استخراج به دایرکتوری خانه ترموکس
    7z x /sdcard/Download/windows11/Win11.7z.001 -o/data/data/com.termux/files/home/
    
    # تنظیم مجوز اجرا
    chmod +x /data/data/com.termux/files/home/Win11
    
    print_success "استخراج کامل شد"
}

# راه‌اندازی ویندوز ۱۱
setup_windows() {
    print_step "راه‌اندازی ویندوز ۱۱"
    
    print_info "اجرای اسکریپت راه‌اندازی ویندوز..."
    
    cd /data/data/com.termux/files/home/
    ./Win11 << EOF
y
N
N
N
EOF
    
    print_success "تنظیمات اولیه ویندوز انجام شد"
}

# ایجاد فایل راه‌اندازی سریع
create_shortcut() {
    print_step "ایجاد میانبر"
    
    cat > /data/data/com.termux/files/home/start-windows11.sh << 'EOF'
#!/bin/bash
# شروع ویندوز ۱۱ در Termux:X11

# تنظیمات اولیه
export DISPLAY=:0
pulseaudio --start

# اجرای ویندوز
cd /data/data/com.termux/files/home/
./Win11
EOF
    
    chmod +x /data/data/com.termux/files/home/start-windows11.sh
    
    print_success "میانبر ایجاد شد: ./start-windows11.sh"
}

# نمایش راهنمای نهایی
show_final_guide() {
    print_step "نصب کامل شد!"
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}🎉 ویندوز ۱۱ با موفقیت نصب شد!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${YELLOW}مراحل اجرا:${NC}"
    echo "1. اپلیکیشن Termux:X11 را باز کنید"
    echo "2. در ترموکس دستور زیر را اجرا کنید:"
    echo -e "   ${BLUE}./start-windows11.sh${NC}"
    echo ""
    echo -e "${YELLOW}نکات مهم:${NC}"
    echo "• در اندروید ۱۲ و بالاتر، Phantom Process Killer را غیرفعال کنید [citation:9]"
    echo "• با دستور زیر این کار را انجام دهید:"
    echo -e "   ${BLUE}adb shell \"/system/bin/device_config put activity_manager max_phantom_processes 2147483647\"${NC}"
    echo ""
    echo -e "${RED}⚠️  هشدار:${NC}"
    echo "• برای اجرا حداقل ۴ گیگابایت رم آزاد نیاز است"
    echo "• فضای خالی حداقل ۱۵ گیگابایت لازم است"
    echo "• پردازنده ARM64 پشتیبانی می‌شود"
}

# اجرای اصلی
main() {
    print_step "شروع نصب SeiTan Emulator"
    echo ""
    
    check_system
    setup_initial
    install_dependencies
    download_windows
    extract_files
    setup_windows
    create_shortcut
    show_final_guide
}

# اجرا
main "$@"