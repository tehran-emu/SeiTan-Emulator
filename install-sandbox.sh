#!/bin/bash

# ======================================================
# SeiTan Emulator Sandbox - Windows 11 Temporary Virtual Machine
# نسخه جعبه شنی برای تست امنیتی فایل‌های مشکوک
# ======================================================

set -e

# ======================================================
# تنظیمات رنگ‌ها برای نمایش بهتر
# ======================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ======================================================
# توابع کمکی
# ======================================================
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_step() { echo -e "${PURPLE}=== $1 ===${NC}"; }
print_header() { 
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC} $1"
    echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
}

# ======================================================
# متغیرهای مسیرها
# ======================================================
HOME_DIR="/data/data/com.termux/files/home"
SANDBOX_DIR="$HOME_DIR/seitan-sandbox"
BACKUP_DIR="$HOME_DIR/seitan-backup"
WINDOWS_DIR="$SANDBOX_DIR/windows"
TEMP_DIR="$SANDBOX_DIR/temp"
DOWNLOADS_DIR="$SANDBOX_DIR/downloads"
RUNNER_SCRIPT="$HOME_DIR/run-sandbox.sh"
SECURITY_GUIDE="$HOME_DIR/sandbox-readme.txt"

# ======================================================
# مرحله 1: بررسی سیستم
# ======================================================
check_system() {
    print_step "بررسی سیستم"
    
    if ! command -v termux-setup-storage &> /dev/null; then
        print_error "این اسکریپت فقط در Termux اجرا می‌شود!"
        exit 1
    fi
    
    print_success "سیستم مناسب است"
}

# ======================================================
# مرحله 2: راه‌اندازی اولیه
# ======================================================
setup_initial() {
    print_step "راه‌اندازی اولیه Termux"
    
    print_info "درخواست دسترسی به حافظه..."
    termux-setup-storage || true
    
    print_info "بروزرسانی پکیج‌ها..."
    pkg update -y && pkg upgrade -y
    
    print_success "راه‌اندازی اولیه کامل شد"
}

# ======================================================
# مرحله 3: نصب وابستگی‌ها
# ======================================================
install_dependencies() {
    print_step "نصب وابستگی‌ها"
    
    local deps="proot-distro wget curl p7zip tar xz-utils pulseaudio termux-x11"
    
    print_info "نصب: $deps"
    pkg install -y $deps
    
    print_success "همه وابستگی‌ها نصب شدند"
}

# ======================================================
# مرحله 4: ایجاد محیط سندباکس
# ======================================================
create_sandbox_environment() {
    print_step "ایجاد محیط جعبه شنی (Sandbox)"
    
    # ایجاد دایرکتوری‌ها
    mkdir -p "$WINDOWS_DIR"
    mkdir -p "$TEMP_DIR"
    mkdir -p "$DOWNLOADS_DIR"
    mkdir -p "$BACKUP_DIR"
    
    # ایجاد فایل‌های هشدار
    cat > "$SANDBOX_DIR/WARNING.txt" << 'EOF'
⚠️  هشدار امنیتی!

این محیط یک جعبه شنی (Sandbox) برای تست فایل‌های مشکوک است.

✅ نکات ایمنی:
- هیچ تغییری روی سیستم اصلی اعمال نمی‌شود
- پس از هر بار اجرا، محیط کاملاً پاک می‌شود
- برای تست فایل‌های ناشناخته استفاده می‌شود

❌ هشدار:
- هرگز فایل‌های مهم را در این محیط باز نکنید
- برای تست بدافزار، حتماً اینترنت را قطع کنید
- پس از تست، گوشی را ریستارت کنید

موفق باشید!
SeiTan Security Team
EOF
    
    print_success "محیط سندباکس ایجاد شد"
}

# ======================================================
# مرحله 5: دانلود فایل‌های ویندوز
# ======================================================
download_windows() {
    print_step "دانلود فایل‌های ویندوز ۱۱"
    
    cd "$SANDBOX_DIR"
    
    print_warning "دانلود فایل‌های مورد نیاز (حدود ۲-۳ گیگابایت)..."
    print_info "این مرحله ممکن است زمان‌بر باشد"
    
    # دانلود فایل‌ها از منبع معتبر
    wget -c https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.001
    wget -c https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.002
    wget -c https://github.com/Android-PowerUser/Windroid_11/releases/download/2023.07.29/Win11.7z.003
    
    print_success "دانلود کامل شد"
}

# ======================================================
# مرحله 6: استخراج فایل‌ها
# ======================================================
extract_files() {
    print_step "استخراج فایل‌ها"
    
    print_info "استخراج فایل‌های ویندوز ۱۱ (حدود ۱۵ دقیقه)..."
    
    # استخراج به دایرکتوری ویندوز
    7z x "$SANDBOX_DIR/Win11.7z.001" -o"$WINDOWS_DIR/"
    
    # تنظیم مجوز اجرا
    chmod +x "$WINDOWS_DIR/Win11"
    
    print_success "استخراج کامل شد"
}

# ======================================================
# مرحله 7: ایجاد اولین پشتیبان پاک
# ======================================================
create_initial_backup() {
    print_step "ایجاد پشتیبان اولیه"
    
    print_info "گرفتن عکس‌فوری از وضعیت پاک..."
    rm -rf "$BACKUP_DIR/backup_latest"
    cp -r "$WINDOWS_DIR" "$BACKUP_DIR/backup_latest"
    
    print_success "پشتیبان اولیه ایجاد شد"
}

# ======================================================
# مرحله 8: ایجاد اسکریپت اجرا
# ======================================================
create_runner_script() {
    print_step "ایجاد اسکریپت اجرا"
    
    cat > "$RUNNER_SCRIPT" << 'EOF'
#!/bin/bash

# ======================================================
# SeiTan Sandbox Runner
# ======================================================

# تنظیمات
SANDBOX_DIR="/data/data/com.termux/files/home/seitan-sandbox"
BACKUP_DIR="/data/data/com.termux/files/home/seitan-backup"
WINDOWS_DIR="$SANDBOX_DIR/windows"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# رنگ‌ها
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# ======================================================
# توابع
# ======================================================
print_header() {
    echo ""
    echo -e "${PURPLE}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC} 🛡️  SeiTan Sandbox Mode"
    echo -e "${PURPLE}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
}

backup_current_state() {
    echo -e "${YELLOW}📸 گرفتن عکس‌فوری از وضعیت فعلی...${NC}"
    mkdir -p "$BACKUP_DIR/backup_$TIMESTAMP"
    cp -r "$WINDOWS_DIR" "$BACKUP_DIR/backup_$TIMESTAMP"
    echo -e "${GREEN}✅ پشتیبان در: $BACKUP_DIR/backup_$TIMESTAMP${NC}"
}

restore_clean_state() {
    echo -e "${YELLOW}🔄 بازگردانی به حالت پاک...${NC}"
    
    if [ -d "$BACKUP_DIR/backup_latest" ]; then
        rm -rf "$WINDOWS_DIR"
        cp -r "$BACKUP_DIR/backup_latest" "$WINDOWS_DIR"
        echo -e "${GREEN}✅ وضعیت پاک بازگردانی شد${NC}"
    else
        echo -e "${RED}❌ پشتیبان پاک یافت نشد!${NC}"
        exit 1
    fi
}

run_sandbox() {
    echo -e "${BLUE}🔒 راه‌اندازی محیط ایزوله...${NC}"
    
    # تنظیم متغیرهای محیطی
    export DISPLAY=:0
    export PULSE_SERVER=127.0.0.1
    
    # شروع سرویس‌ها
    pulseaudio --start 2>/dev/null || true
    
    # اجرای ویندوز
    cd "$WINDOWS_DIR"
    
    echo ""
    echo -e "${GREEN}🚀 ویندوز ۱۱ در حالت جعبه شنی در حال اجراست...${NC}"
    echo -e "${YELLOW}⚠️  هیچ تغییری روی سیستم اصلی اعمال نمی‌شود${NC}"
    echo -e "${RED}⚠️  برای بستن، پنجره Termux:X11 را ببندید${NC}"
    echo ""
    
    # اجرا با ورودی‌های خودکار
    ./Win11 << EOF
y
N
N
N
EOF
    
    # پس از بسته شدن
    echo ""
    echo -e "${GREEN}✅ جلسه سندباکس پایان یافت${NC}"
    
    # پاکسازی
    echo -e "${YELLOW}🧹 پاکسازی فایل‌های موقت...${NC}"
    rm -rf "$SANDBOX_DIR/temp/"*
    rm -rf "$SANDBOX_DIR/downloads/"*
    
    # بازگردانی
    restore_clean_state
    
    echo -e "${GREEN}✅ محیط کاملاً پاک شد${NC}"
    echo -e "${BLUE}💡 سیستم اصلی هیچ تغییری نکرده است${NC}"
}

# ======================================================
# منوی اصلی
# ======================================================
print_header

echo "1) اجرای ویندوز در حالت سندباکس (پاک - توصیه شده)"
echo "2) اجرا با حفظ تغییرات جلسه قبل (خطرناک‌تر)"
echo "3) گرفتن عکس‌فوری از وضعیت فعلی"
echo "4) بازگردانی به آخرین وضعیت پاک"
echo "5) حذف تمام محیط سندباکس"
echo "6) خروج"
echo ""
read -p "🔹 انتخاب شما (1-6): " choice

case $choice in
    1)
        backup_current_state
        run_sandbox
        ;;
    2)
        echo -e "${RED}⚠️  اجرا با تغییرات قبلی - خطرناک‌تر!${NC}"
        echo -e "${YELLOW}توصیه می‌شود فقط فایل‌های قبلاً شناخته شده را تست کنید${NC}"
        read -p "آیا مطمئن هستید؟ (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            run_sandbox
        else
            echo "لغو شد"
        fi
        ;;
    3)
        backup_current_state
        echo -e "${GREEN}✅ عکس‌فوری گرفته شد${NC}"
        ;;
    4)
        restore_clean_state
        ;;
    5)
        echo -e "${RED}⚠️  هشدار: تمام محیط سندباکس حذف خواهد شد!${NC}"
        read -p "آیا مطمئن هستید؟ (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            rm -rf "$SANDBOX_DIR"
            rm -rf "$BACKUP_DIR"
            echo -e "${GREEN}✅ محیط سندباکس حذف شد${NC}"
        else
            echo "لغو شد"
        fi
        ;;
    6)
        echo "خروج"
        exit 0
        ;;
    *)
        echo -e "${RED}❌ انتخاب نامعتبر!${NC}"
        ;;
esac
EOF

    chmod +x "$RUNNER_SCRIPT"
    print_success "اسکریپت اجرا ایجاد شد: ./run-sandbox.sh"
}

# ======================================================
# مرحله 9: ایجاد راهنمای امنیتی
# ======================================================
create_security_guide() {
    print_step "ایجاد راهنمای امنیتی"
    
    cat > "$SECURITY_GUIDE" << 'EOF'
═══════════════════════════════════════════════
🛡️  راهنمای امنیتی SeiTan Sandbox
═══════════════════════════════════════════════

🔒 این محیط برای تست فایل‌های مشکوک طراحی شده است.

⚠️  نکات امنیتی مهم:
─────────────────────
1. همیشه از حالت "پاک" (گزینه ۱) برای تست فایل‌های جدید استفاده کنید
2. هرگز فایل‌های مهم را در این محیط باز نکنید
3. پس از تست، حتماً ویندوز را ببندید تا محیط پاک شود
4. برای تست بدافزارها، اینترنت را قطع کنید
5. پس از هر جلسه تست، گوشی را ریستارت کنید

📂 مسیرهای مهم:
─────────────────────
• محیط سندباکس: ~/seitan-sandbox
• فایل‌های ویندوز: ~/seitan-sandbox/windows
• پشتیبان‌ها: ~/seitan-backup
• فایل‌های موقت: ~/seitan-sandbox/temp
• فایل‌های دانلود: ~/seitan-sandbox/downloads

🔄 نحوه کار:
─────────────────────
1. اجرای اسکریپت → ۲. انتخاب گزینه ۱ → ۳. تست فایل → ۴. بستن → ۵. پاکسازی خودکار

✅ مزایا:
─────────────────────
• هیچ تغییری روی سیستم اصلی ایجاد نمی‌شود
• پس از هر بار اجرا، محیط به حالت اولیه برمی‌گردد
• امکان گرفتن عکس‌فوری قبل از تست
• جداسازی کامل از سیستم میزبان

❌ محدودیت‌ها:
─────────────────────
• سرعت کمتر نسبت به ویندوز اصلی
• برخی برنامه‌ها ممکن است اجرا نشوند
• به حداقل ۴ گیگابایت رم نیاز دارد

🔍 برای تست فایل:
─────────────────────
1. فایل را در ~/seitan-sandbox/downloads قرار دهید
2. در ویندوز، به پوشه downloads بروید
3. فایل را اجرا کنید و رفتار آن را بررسی کنید
4. پس از بررسی، ویندوز را ببندید

📊 علائم خطرناک در بدافزارها:
─────────────────────
• تغییر تنظیمات سیستم
• اتصالات شبکه ناشناخته
• مصرف بالای CPU
• ایجاد فایل‌های مخفی
• تغییر در رجیستری

═══════════════════════════════════════════════
نسخه: 2.0.0 | تاریخ: 2026
ساخته شده با ❤️ برای جامعه امنیت سایبری
═══════════════════════════════════════════════
EOF

    print_success "راهنمای امنیتی ایجاد شد: cat sandbox-readme.txt"
}

# ======================================================
# مرحله 10: نمایش راهنمای نهایی
# ======================================================
show_final_guide() {
    print_header "نصب کامل شد!"
    
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}🛡️  SeiTan Emulator - Sandbox Edition${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}📌 نحوه اجرا:${NC}"
    echo -e "   ${CYAN}./run-sandbox.sh${NC}"
    echo ""
    echo -e "${YELLOW}📌 گزینه‌های اجرا:${NC}"
    echo "   1) حالت پاک (توصیه شده برای تست فایل‌های جدید)"
    echo "   2) حالت با تغییرات (برای ادامه کار قبلی)"
    echo "   3) گرفتن عکس‌فوری"
    echo "   4) بازگردانی به حالت پاک"
    echo "   5) حذف کامل محیط سندباکس"
    echo ""
    echo -e "${RED}⚠️  هشدار امنیتی:${NC}"
    echo "   • این محیط برای تست فایل‌های مشکوک طراحی شده"
    echo "   • پس از هر بار استفاده، محیط کاملاً پاک می‌شود"
    echo "   • هیچ فایلی روی سیستم اصلی ذخیره نمی‌شود"
    echo "   • برای تست بدافزار، اینترنت را قطع کنید"
    echo ""
    echo -e "${BLUE}💡 نکته:${NC} برای مشاهده راهنمای کامل:"
    echo -e "   ${CYAN}cat sandbox-readme.txt${NC}"
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
}

# ======================================================
# اجرای اصلی
# ======================================================
main() {
    print_header "نصب SeiTan Emulator Sandbox"
    
    check_system
    setup_initial
    install_dependencies
    create_sandbox_environment
    download_windows
    extract_files
    create_initial_backup
    create_runner_script
    create_security_guide
    show_final_guide
}

# اجرا
main "$@"