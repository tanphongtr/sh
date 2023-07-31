#!/bin/bash

# Kiểm tra xem script được chạy với quyền root hay không
if [[ $EUID -ne 0 ]]; then
    echo "Bạn cần chạy script này với quyền root hoặc sử dụng sudo." 
    exit 1
fi

# Kiểm tra xem Nginx đã được cài đặt hay chưa
if command -v nginx &>/dev/null; then
    echo "Nginx đã được cài đặt trên hệ thống."
    exit 0
fi

# Cài đặt Nginx trên Rocky Linux
echo "Bắt đầu cài đặt Nginx..."
dnf install -y nginx

# Kiểm tra xem Nginx đã được cài đặt thành công hay không
if command -v nginx &>/dev/null; then
    echo "Nginx đã được cài đặt thành công."
else
    echo "Có lỗi xảy ra trong quá trình cài đặt Nginx."
    exit 1
fi

# Khởi động dịch vụ Nginx
echo "Khởi động dịch vụ Nginx..."
systemctl start nginx

# Cấu hình Nginx tự động khởi động cùng hệ thống
echo "Cấu hình Nginx tự động khởi động cùng hệ thống..."
systemctl enable nginx

echo "Hoàn tất cài đặt và cấu hình Nginx."