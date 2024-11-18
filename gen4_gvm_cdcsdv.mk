#Configure derivative suffix for conditional compilation
PRODUCT_MANUFACTURER := Qualcomm
PRODUCT_COPY_FILES += \
                      device/qcom/gen4_gvm_cdcsdv/init.target.rc:vendor/etc/init/hw/init.target.rc \

# Inherit from the base product
include device/qcom/gen4_gvm_sdv/gen4_gvm_sdv.mk
TARGET_BOARD_DERIVATIVE_SUFFIX:=_cdcsdv

# Flag to identify CDC HW
TARGET_USES_CDC_HW := true

PRODUCT_NAME := gen4_gvm_cdcsdv
PRODUCT_DEVICE := gen4_gvm_cdcsdv
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_cdcsdv for arm64

#CUSTOM_PATCHES_MODE := apply

PRODUCT_PACKAGES += fstab.sdv

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)$(TARGET_BOARD_DERIVATIVE_SUFFIX)/$(KERNEL_MODULES_INSTALL)/lib/modules
LOCAL_ANDROIDBOOT_INIT_RC := /vendor/etc/init/hw/init.target.rc

PRODUCT_ENFORCE_VINTF_MANIFEST := false

#TARGET_USES_QMAA_OVERRIDE_FASTCV := false

# SOME/IP stack
PRODUCT_PACKAGES += \
                    qc_sdv_someip_stack_agent \
                    vsomeip_vlan1500.json \
                    vsomeip_vlan1510.json \
