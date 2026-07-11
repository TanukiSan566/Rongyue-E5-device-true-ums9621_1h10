DEVICE_PATH := device/unisoc/ums9621_1h10

# API
PRODUCT_SHIPPING_API_LEVEL := 33

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
