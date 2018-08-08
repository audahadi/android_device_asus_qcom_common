#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PATH)/permissions/asus.software.azs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/asus.software.azs.xml \
    $(LOCAL_PATH)/permissions/asus.software.zenui.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/asus.software.zenui.xml

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8916 \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

PRODUCT_PACKAGES += \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@2.0-service \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.audio.effect@2.0-service \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.soundtrigger@2.0-service

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml

# XML Audio configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:/$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:/$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:/$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:/$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:/$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_General_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Global_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Handset_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Headset_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MP/MTP_MP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MP/MTP_MP_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb:system/etc/acdbdata/MTP/msm8939-tapan-snd-card/MTP_WCD9306_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_General_cal.acdb:system/etc/acdbdata/MTP/MTP_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Global_cal.acdb:system/etc/acdbdata/MTP/MTP_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Handset_cal.acdb:system/etc/acdbdata/MTP/MTP_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Headset_cal.acdb:system/etc/acdbdata/MTP/MTP_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb

# Audio prop
ifneq ($(filter Z00ED Z00RD,$(TARGET_DEVICE)),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=none
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=fluence
endif

# ANT+
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl-legacy \
    bspcapability \
    libshims_camera \
    camera.msm8916

PRODUCT_PACKAGES += \
    Snap

# Connectivity Engine support
PRODUCT_PACKAGES += \
    libcnefeatureconfig

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.memtrack@1.0-impl \
    copybit.msm8916 \
    gralloc.msm8916 \
    hwcomposer.msm8916 \
    libgenlock \
    memtrack.msm8916

# FM
PRODUCT_PACKAGES += \
    FMRadio \
    libfmjni

# For android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# GNSS HAL
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl

# GPS
PRODUCT_PACKAGES += \
    gps.msm8916 \
    libshims_flp \
    libshims_get_process_name

PRODUCT_PACKAGES += \
    flp.conf \
    gps.conf \
    izat.conf \
    sap.conf

# HIDL
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest.xml:system/vendor/manifest.xml

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

#PRODUCT_PACKAGES += \
#    keystore.msm8916

# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl

# Light
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    lights.msm8916

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_8939.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_8939.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance_8939.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_8939.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml

PRODUCT_PACKAGES += \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Power HAL
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    power.msm8916

# QMI
PRODUCT_PACKAGES += \
    libtinyxml

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.opengles.sh \
    init.qcom.power.sh \
    init.qcom.factory.sh

PRODUCT_PACKAGES += \
    init.qcom.rc \
    init.qcom.power.rc \
    init.qcom.usb.rc \
    init.recovery.qcom.rc \
    ueventd.qcom.rc

# Recovery
PRODUCT_PACKAGES += \
    librecovery_updater_asus \
    resize2fs_static


# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# RIL
PRODUCT_PACKAGES += \
    librmnetctl \
    libxml2

# Include IMSEnabler
PRODUCT_PACKAGES += \
    IMSEnabler

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/_hals.conf:system/vendor/etc/sensors/_hals.conf

PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    sensors.msm8916

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal/thermal-engine-8916.conf:system/etc/thermal-engine-8916.conf \
    $(LOCAL_PATH)/thermal/thermal-engine-8939.conf:system/etc/thermal-engine-8939.conf

# USB HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl

# Voice recognition
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    $(LOCAL_PATH)/audio/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml

# WiFi HAL
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service

# Wifi
PRODUCT_PACKAGES += \
    libwcnss_qmi \
    libwpa_client \
    wificond

PRODUCT_PACKAGES += \
    wcnss_service

PRODUCT_PACKAGES += \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# wifi
PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf

ifneq ($(filter Z00ED Z00RD,$(TARGET_DEVICE)),)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini
else
PRODUCT_COPY_FILES += \
    kernel/asus/msm8916/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/asus/msm8916/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/vendor/etc/wifi/WCNSS_qcom_cfg.ini
endif

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/ASUS_TransKeyboard.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/ASUS_TransKeyboard.kl \
    $(LOCAL_PATH)/keylayout/focal-touchscreen.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/focal-touchscreen.kl \
    $(LOCAL_PATH)/keylayout/ft5x06_ts.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/ft5x06_ts.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/i-rocks_Bluetooth_Keyboard.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/i-rocks_Bluetooth_Keyboard.kl \
    $(LOCAL_PATH)/keylayout/synaptics_dsx.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/synaptics_dsx.kl \
    $(LOCAL_PATH)/keylayout/synaptics_rmi4_i2c.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/synaptics_rmi4_i2c.kl
