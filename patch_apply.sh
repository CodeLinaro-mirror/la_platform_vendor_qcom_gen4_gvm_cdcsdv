#!/bin/bash -x

prefix=_
cust=${TARGET_BOARD_DERIVATIVE_SUFFIX#"$prefix"}

if [ "$CUSTOM_PATCHES_MODE" == "apply" ]; then
    if [ -d vendor/qcom/proprietary/automotive-patch-internal-vendor ]; then
        echo "Calling Apply patches"
        vendor/qcom/proprietary/automotive-patch-internal-vendor/scripts/custom-patching.sh vendor/qcom/proprietary/automotive-patch-internal-vendor/patches/$cust/vendor_patches apply
	if [ $? -ne 0 ]
        then
            echo "Vendor patches not applied properly. Please Rebase and apply."
            exit 1
        fi
        vendor/qcom/proprietary/automotive-patch-internal-vendor/scripts/custom-patching.sh vendor/qcom/proprietary/automotive-patch-internal-vendor/patches/$cust/kernel_patches apply
	if [ $? -ne 0 ]
        then
            echo "Kernel patches not applied properly. Please Rebase and apply."
            exit 1
        fi
    else
        echo "Patches folder not found"
    fi
elif [ "$CUSTOM_PATCHES_MODE" == "clean" ]; then
    echo "Cleaning patches"
    vendor/qcom/proprietary/automotive-patch-internal-vendor/scripts/custom-patching.sh vendor/qcom/proprietary/automotive-patch-internal-vendor/patches/$cust/vendor_patches clean
    if [ $? -ne 0 ]
    then
        echo "Vendor patches not cleaned properly. Please set the CUSTOM_PATCHES_MODE=clean and try again"
        exit 1
    fi
    vendor/qcom/proprietary/automotive-patch-internal-vendor/scripts/custom-patching.sh vendor/qcom/proprietary/automotive-patch-internal-vendor/patches/$cust/kernel_patches clean
    if [ $? -ne 0 ]
    then
        echo "Kernel patches not cleaned properly. Please set the CUSTOM_PATCHES_MODE=clean and try again"
        exit 1
    fi
fi
