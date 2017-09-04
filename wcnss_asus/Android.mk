#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ifneq ($(filter Z00ED Z00RD,$(TARGET_DEVICE)),)
LOCAL_SRC_FILES := wcnss_Z00xD.cpp
LOCAL_CFLAGS += -Wall -std=c++11
else
LOCAL_SRC_FILES := wcnss_asus_client.c
LOCAL_CFLAGS += -Wall
endif

LOCAL_C_INCLUDES += $(call project-path-for,wlan)/wcnss_service
LOCAL_SHARED_LIBRARIES := libc libcutils libutils liblog

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libwcnss_qmi

include $(BUILD_SHARED_LIBRARY)
