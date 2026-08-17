#Configure derivative suffix for conditional compilation
PRODUCT_MANUFACTURER := Qualcomm

# Flag to identify CDC HW - must be set BEFORE including gen4_gvm_sdv.mk
TARGET_USES_CDC_HW := true

# registered first. Android PRODUCT_COPY_FILES is first-wins: when gen4_gvm_sdv.mk
PRODUCT_COPY_FILES += \
    device/qcom/gen4_gvm_cdcsdv/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.rc \
    device/qcom/gen4_gvm_cdcsdv/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.gen4.sdv.qcom \
    device/qcom/gen4_gvm_cdcsdv/fstab.sdv:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.gen4.sdv.qcom

# Inherit from the base product
include device/qcom/gen4_gvm_sdv/gen4_gvm_sdv.mk
TARGET_BOARD_DERIVATIVE_SUFFIX:=_cdcsdv

PRODUCT_NAME := gen4_gvm_cdcsdv
PRODUCT_DEVICE := gen4_gvm_cdcsdv
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_cdcsdv for arm64

CUSTOM_PATCHES_MODE := apply

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)$(TARGET_BOARD_DERIVATIVE_SUFFIX)/$(KERNEL_MODULES_INSTALL)/lib/modules
LOCAL_ANDROIDBOOT_INIT_RC := /vendor/etc/init/hw/init.target.rc

PRODUCT_ENFORCE_VINTF_MANIFEST := false

# TARGET_ENABLE_AIS_CUST disabled - libgbm_la not available in this workspace
# TARGET_ENABLE_AIS_CUST    := true
# TARGET_ENABLE_AIS_CUST_RN := true
TARGET_ENABLE_C11_COMPATIBLE := true

#TARGET_USES_QMAA_OVERRIDE_FASTCV := false

PRODUCT_PACKAGES += qc_sdv_someip_stack_agent \
                    someip_stack_agent_testapp \
                    qc_sdv_someip_framework_compatibility_matrix.xml

PRODUCT_PACKAGES += vsomeip_vlan1500.json \
                    vsomeip_vlan1510.json

# -----------------------------------------------------------------------------
# Remove unwanted DRM libraries from PRODUCT_PACKAGES after vendor additions.
# These libraries should never ship in RBVM (DRM not supported).
# -----------------------------------------------------------------------------
RBVM_REMOVE_DRM_LIBS := \
    libtzdrmgenprov \
    libdrmMinimalfsHelper \
    libprdrmengine

PRODUCT_PACKAGES := $(filter-out $(RBVM_REMOVE_DRM_LIBS), $(PRODUCT_PACKAGES))

# PRODUCT_PACKAGES += \
#    sdvcarpowermanagerclient

# VLAN scripts and whitelist — vendor/bin (gen4_gvm_cdcsdv)
PRODUCT_COPY_FILES += \
    device/qcom/gen4_gvm_cdcsdv/scripts/create_vlan_vm_1.sh:$(TARGET_COPY_OUT_VENDOR)/bin/create_vlan_vm_1.sh \
    device/qcom/gen4_gvm_cdcsdv/scripts/create_whitelist_rbvm.sh:$(TARGET_COPY_OUT_VENDOR)/bin/create_whitelist_rbvm.sh \
    vendor/qcom/proprietary/commonsys/cne/automs_vlan/whitelist_rbvm.csv:$(TARGET_COPY_OUT_VENDOR)/bin/whitelist_rbvm.csv \
    device/qcom/gen4_gvm_cdcsdv/vlan_cdcsdv.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vlan_cdcsdv.rc

PRODUCT_PACKAGES += \
    android.sdv.hardware.security.keymint-service.nonsecure
