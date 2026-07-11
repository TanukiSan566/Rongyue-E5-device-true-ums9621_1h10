# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Inherit from TWRP product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Device specific configs
$(call inherit-product, device/unisoc/ums9621_1h10/device.mk)

# Device identifier
PRODUCT_DEVICE := ums9621_1h10
PRODUCT_NAME := twrp_ums9621_1h10
PRODUCT_BRAND := unisoc
PRODUCT_MODEL := LXX516
PRODUCT_MANUFACTURER := unisoc

PRODUCT_PROPERTY_OVERRIDES += ro.twrp.vendor_boot=true
