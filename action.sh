#!/system/bin/sh

# action.sh - KernelSU 自动识别的动作脚本
# 用户点击 KSU 管理器中的 ⚡ 按钮时触发

MODDIR="/data/adb/modules/hide_ace_kernel"
MARK_FILE="/data/local/tmp/.ace_unload_panic_mark"

echo "=== Manual Reset Triggered ==="

# 1. 清除崩溃标记
if [ -f "$MARK_FILE" ]; then
    rm -f "$MARK_FILE"
    echo "Panic mark cleared."
else
    echo "No panic mark found. System state is normal."
fi

# 2. 立即尝试卸载
echo "Attempting to unload 'inte' module..."
rmmod inte 2>&1 | while read line; do echo "$line"; done

RET=$?
if [ $RET -eq 0 ]; then
    echo "✅ Unload successful!"
else
