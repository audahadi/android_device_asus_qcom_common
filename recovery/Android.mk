LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := bootable/recovery \
    bootable/recovery/updater/include
LOCAL_SRC_FILES := recovery_updater.cpp
LOCAL_MODULE := librecovery_updater_asus
LOCAL_MODULE_TAGS := eng
include $(BUILD_STATIC_LIBRARY)
