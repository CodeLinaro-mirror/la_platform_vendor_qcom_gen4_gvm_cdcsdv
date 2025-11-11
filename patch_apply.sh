#!/bin/bash -x
#Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. 
#SPDX-License-Identifier: BSD-3-Clause-Clear

prefix=_
cust=${TARGET_BOARD_DERIVATIVE_SUFFIX#"$prefix"}
if [ "$CUSTOM_PATCHES_MODE" == "apply" ]; then
    if [ -d vendor/qcom/opensource/automotive-patch-vendor ]; then
        echo "Calling Apply patches"
        vendor/qcom/opensource/automotive-patch-vendor/scripts/custom-patching.sh vendor/qcom/opensource/automotive-patch-vendor/patches/$cust/vendor_patches apply
        vendor/qcom/opensource/automotive-patch-vendor/scripts/custom-patching.sh vendor/qcom/opensource/automotive-patch-vendor/patches/$cust/kernel_patches apply
    else
        echo "Patches folder not found"
    fi
elif [ "$CUSTOM_PATCHES_MODE" == "clean" ]; then
    echo "Cleaning patches"
    vendor/qcom/opensource/automotive-patch-vendor/scripts/custom-patching.sh vendor/qcom/opensource/automotive-patch-vendor/patches/$cust/vendor_patches clean
    vendor/qcom/opensource/automotive-patch-vendor/scripts/custom-patching.sh vendor/qcom/opensource/automotive-patch-vendor/patches/$cust/kernel_patches clean
fi