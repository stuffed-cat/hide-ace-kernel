#!/system/bin/sh

# ============================================================
# Module: Hide ACE Kernel Interfaces
# Author: stuffed-cat
# Description: Unloads the inte kernel module after boot.
# ============================================================

LOG_TAG="HIDE-ACE-KERNEL"
MARK_FILE="/data/local/tmp/.ace_unload_panic_mark"

log() {
    echo "$LOG_TAG: $1"
}

main() {
    
    for i in $(seq 1 30); do
        if [ "$(getprop sys.boot_completed)" = "1" ]; then
            break
        fi
        sleep 1
    done


    # 1. 崩溃检测逻辑
    if [ -f "$MARK_FILE" ]; then
        log "警告：检测到上次卸载导致崩溃(Panic)，已自动跳过卸载以保护系统。"
        log "如需重试，请在 KernelSU 管理器中重新切换模块开关（Reset）。"
        exit 0
    fi

    log "Trying to unload inte kernel module..."

    touch "$MARK_FILE"

    if rmmod inte 2>/dev/null; then
        log "Successfully unloaded inte"
    else
        log "Failed to unload inte. It may not be loaded or permissions are insufficient."
    fi

    rm -f "$MARK_FILE"
}

# 运行主函数
main