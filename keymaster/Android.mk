ifneq ($(filter Z00ED Z00RD,$(TARGET_DEVICE)),)

ifeq ($(TARGET_HW_KEYMASTER_V03),true)
LOCAL_PATH := $(call my-dir)

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

keymaster-def := -fvisibility=hidden -Wall
ifeq ($(TARGET_BOARD_PLATFORM),msm8084)
keymaster-def += -D_ION_HEAP_MASK_COMPATIBILITY_WA
endif

include $(CLEAR_VARS)

LOCAL_MODULE := keystore.qcom

LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_SRC_FILES := keymaster_qcom.cpp

LOCAL_C_INCLUDES := $(TARGET_OUT_HEADERS)/common/inc \
                    $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
                    external/openssl/include

LOCAL_CFLAGS := $(keymaster-def)

LOCAL_SHARED_LIBRARIES := \
        libcrypto \
        liblog \
        libc \
        libdl

LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif # TARGET_BOARD_PLATFORM
else
LOCAL_MODULE := keystore.qcom
$(info Removing keymaster v0.3 bins)
$(shell rm -rf $(TARGET_OUT_INTERMEDIATES)/SHARED_LIBRARIES/$(LOCAL_MODULE)_intermediates )
$(shell rm -rf $(TARGET_OUT)/lib/hw/$(LOCAL_MODULE).so )
$(shell rm -rf $(TARGET_OUT)/lib64/hw/$(LOCAL_MODULE).so )
$(shell rm -rf $(TARGET_OUT)/../symbols/system/lib/hw/$(LOCAL_MODULE).so )
$(shell rm -rf $(TARGET_OUT_INTERMEDIATES)/lib/$(LOCAL_MODULE).so )
$(shell rm -fr $(TARGET_OUT_INTERMEDIATES)/lib64/$(LOCAL_MODULE).so )

endif # end of TARGET_HW_KEYMASTER_V03
endif # end of TARGET_DEVICE
