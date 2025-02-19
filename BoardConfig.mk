# Include the BoardConfig.mk of base product

include device/qcom/gen4_gvm_sdv/BoardConfig.mk
AB_OTA_PARTITIONS += system_dlkm

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=
TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=


BOARD_KERNEL_CMDLINE :=
BOARD_BOOTCONFIG :=

ifneq ( ,$(filter V VanillaIceCream 15 W Baklava 16,$(PLATFORM_VERSION)))
TARGET_ANDROID_BELOW_V15 := false
else
TARGET_ANDROID_BELOW_V15 := true
endif

BOARD_BOOTCONFIG := androidboot.hardware=qcom androidboot.selinux=permissive androidboot.memcg=1 androidboot.recover_usb=1
BOARD_KERNEL_CMDLINE := debug user_debug=31 loglevel=9 print-fatal-signals=1  init=/init swiotlb=4096  kpti=0 pcie_ports=compat firmware_class.path=/vendor/firmware_mnt/image

BOARD_BOOTCONFIG += androidboot.console=ttyAMA0

BOARD_BOOTCONFIG += androidboot.init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC) \
                    kernel.vmw_vsock_virtio_transport_common.virtio_transport_max_vsock_pkt_buf_size=16384 \
                    androidboot.microdroid.debuggable=1 \
                    androidboot.sdv.rpc.interface=eth0 \
                    androidboot.adb.enabled=1

BOARD_KERNEL_CMDLINE += log_buf_len=4M \
                         audit=1 \
                         panic=-1 \
                         init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC)

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USERIMAGES_SPARSE_F2FS_DISABLED := false

#Overwrite required variables below this
# Base product BoardConfigVendor.mk will already be included. So, use below to set new variables or to override old ones

-include $(QCPATH)/common/gen4_gvm_cdcsdv/BoardConfigVendor.mk

ENABLE_WIDEVINE_DRM := false
