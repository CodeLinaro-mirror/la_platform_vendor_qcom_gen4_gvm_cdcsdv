# Include the BoardConfig.mk of base product

include device/qcom/gen4_gvm_sdv/BoardConfig.mk
AB_OTA_PARTITIONS += system_dlkm

# Disable 32-bit secondary arch inherited from gen4_gvm base.
TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=
TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=

BOARD_SUPER_PARTITION_SIZE := 8589934592 #8GB
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648 #2GB

# Reset and redefine BOOTCONFIG/CMDLINE for CDC hardware.
BOARD_KERNEL_CMDLINE :=
BOARD_BOOTCONFIG :=

BOARD_BOOTCONFIG := androidboot.load_modules_parallel_mode=performance androidboot.hardware=qcom androidboot.selinux=enforcing androidboot.memcg=1 androidboot.recover_usb=1

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
-include $(QCPATH)/common/gen4_gvm_cdcsdv/BoardConfigVendor.mk

ENABLE_WIDEVINE_DRM := false
TARGET_FS_CONFIG_GEN  += device/google/sdv/sdv_core_base/config.fs
TARGET_FS_CONFIG_GEN  += device/qcom/gen4_gvm_cdcsdv/config.fs

# Override recovery fstab to remove length= constraint not applicable on CDC hardware.
TARGET_RECOVERY_FSTAB := device/qcom/gen4_gvm_cdcsdv/gen4_fstab_metadata_f2fs/fstab.gen4.qti

BOARD_VENDOR_SEPOLICY_DIRS += device/qcom/gen4_gvm_cdcsdv/sepolicy/vendor
# Set a target-specific soong config variable so that the QC someip stack agent
$(call soong_config_set,qti,qti_android_version_above_16_cdcsdv,true)
