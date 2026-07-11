# device_unisoc_ums9621_1h10 (v2 — 架构重写)

杂牌机（型号 LXX516，codename ums9621_1h10，Unisoc UMS9621）TWRP 设备树。

## 这次为什么整个重写

之前基于 OrangeFox 官方 `fox_12.1` 同步脚本（会给 twrp-12.1 源码打 OrangeFox 专属补丁）一直卡在
`recovery_intermediates/ramdisk_files-timestamp` 这一步的 `root` 目录缺失问题，反复尝试多种官方
标准配置（`BOARD_USES_GENERIC_KERNEL_IMAGE` 等）都无法解决 —— 后来找到一个同为 Unisoc GKI 平台
（`uis7870sc_2h10` / `ums9620`）、用 `BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT` 真正编译成功的
参考案例，发现它完全不走 OrangeFox 的补丁流程，而是直接用**未打补丁的纯 TWRP 源码**
（`minimal-manifest-twrp/platform_manifest_twrp_aosp`，`twrp-12.1` 分支）+ `make vendorbootimage`。

这次整棵设备树照着这个已验证成功的参考案例重写，关键差异：
- 顶层 product mk 用 `twrp_ums9621_1h10` 命名（不是 `fox_`），并 inherit 了关键的
  `$(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk`（这是之前一直缺的东西，
  专门处理 GKI 设备 vendor_boot ramdisk 生成）和 `vendor/twrp/config/common.mk`
- `recovery.fstab` 放在 `recovery/root/system/etc/recovery.fstab`（第三种、也是验证过对的位置）
- `TARGET_NO_KERNEL := true`，不再打包 boot.img 里的内核 —— vendorbootimage 只需要 ramdisk + dtb，
  内核继续用手机原本 boot 分区里的，完全不用动
- `recovery/root/lib/modules/` 下放了真机提取的全部 163 个内核模块（触摸屏驱动在内），不再靠
  运行时探测或手写 insmod，直接照抄参考案例的做法整份打包进去

## 这个版本编出来是纯 TWRP，不是 OrangeFox 皮肤

这是刻意的取舍：OrangeFox 的补丁正是之前一直卡住的原因，先把最基础的 recovery（触摸、MTP、
fastbootd、分区识别）跑通验证过，后面确认能正常用了，再考虑要不要在这个基础上叠 OrangeFox 的
UI 皮肤（那是另一个独立的、风险可控的步骤，不会再影响底层编译）。

## 配套的构建 workflow

这份设备树要配合单独的 "Recovery Build" workflow 使用（不是继续用 OrangeFox-Recovery-Builder-2024），
见随附的 builder 仓库压缩包。
