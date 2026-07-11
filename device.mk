DEVICE_PATH := device/unisoc/ums9621_1h10

# API
# 注意：这套 twrp-12.1 老源码的 BOARD_SYSTEMSDK_VERSIONS 校验是写死的白名单
# （只认 28-32），33 无论怎么配置都不被识别，所以这里必须降到 31，
# 跟已验证成功的参考树保持一致。这只是编译期的兼容性声明值，
# 不影响真机上安卓13系统的实际运行。
PRODUCT_SHIPPING_API_LEVEL := 31

# A/B —— 分区列表来自真机 dtb 里 vbmeta 节点的 parts 属性 [已核实]
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    dtbo \
    system \
    product \
    vendor \
    odm \
    vendor_dlkm \
    vbmeta \
    vendor_boot \
    vbmeta_system \
    vbmeta_vendor

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)
