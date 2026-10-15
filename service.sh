#!/system/bin/sh

# ============================================================
# Module: Hide ACE Kernel Interfaces
# Author: stuffed-cat
# Description: Conceals Oplus/Tencent kernel anti-cheat proc nodes
#              by bind-mounting empty files over them.
# ============================================================

MODDIR=${0%/*}
LOG_TAG="HIDE-ACE-KERNEL"

log() {
    echo "$LOG_TAG: $1"
}

# 目标 Proc 文件列表
# 根据之前的代码分析，这些是暴露给用户空间的检测接口
PROC_TARGETS=(
    "/proc/inte_ko"
    "/proc/inte_systbl"
    "/proc/inte_status"
)

# 用于挂载的空文件目录
FAKE_DIR="/data/local/tmp/.ksu_hide_ace"

# 初始化环境
init_env() {
    mkdir -p "$FAKE_DIR"
    
    # 为每个目标创建一个对应的空文件
    for target in "${PROC_TARGETS[@]}"; do
        local basename=$(basename "$target")
        local fake_file="$FAKE_DIR/$basename"
        
        # 如果空文件不存在，则创建
        if [ ! -f "$fake_file" ]; then
            touch "$fake_file"
            chmod 644 "$fake_file"
            chown root:root "$fake_file"
            log "Created fake empty file for $basename"
        fi
    done
}

# 执行隐藏操作
hide_proc_nodes() {
    log "Starting to hide ACE kernel proc nodes..."
    
    for target in "${PROC_TARGETS[@]}"; do
        local basename=$(basename "$target")
        local fake_file="$FAKE_DIR/$basename"

        # 检查目标文件是否存在
        if [ ! -e "$target" ]; then
            log "$target does not exist, skipping."
            continue
        fi

        # 检查是否已经挂载过（避免重复挂载）
        if mount | grep -q "$target"; then
            log "$target is already mounted/hidden, skipping."
            continue
        fi

        # 执行绑定挂载
        # 这将使读取 $target 的用户看到空内容（即“无异常”）
        mount --bind "$fake_file" "$target"

        if [ $? -eq 0 ]; then
            log "Successfully hid $target"
        else
            log "Failed to hide $target. Check permissions."
        fi
    done
    
    log "Hide operation completed."
}

# 主执行流程
main() {

    for i in $(seq 1 30); do
        if [ "$(getprop sys.boot_completed)" = "1" ]; then
            break
        fi
        sleep 1
    done
    
    # 确保 procfs 已就绪 
    for i in $(seq 1 15); do
        if [ -f /proc/inte_ko ] || [ -f /proc/inte_systbl ]; then
            break
        fi
        sleep 1
    done
    init_env
    hide_proc_nodes
}

# 运行主函数
main