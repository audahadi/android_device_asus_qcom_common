#!/system/bin/sh
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

# Restore laser calibration data
cp -n /factory/LaserFocus_Calibration10.txt /persist/
cp -n /factory/LaserFocus_Calibration40.txt /persist/

# Restore correct permissions on laser calibration files
if [ ! `stat -c %a /persist/LaserFocus_Calibration10.txt` = "775" ]; then
    chmod 775 /persist/LaserFocus_Calibration10.txt
fi
if [ ! `stat -c %a /persist/LaserFocus_Calibration40.txt` = "775" ]; then
    chmod 775 /persist/LaserFocus_Calibration40.txt
fi

# Restore .bt_nv.bin file
if [ ! -f /persist/.bt_nv.bin ]; then
    cp /factory/bt_nv.bin /persist/.bt_nv.bin

    chmod 600 /persist/.bt_nv.bin
    chown bluetooth:bluetooth /persist/.bt_nv.bin
    restorecon /persist/.bt_nv.bin
fi

# Create /persist/alarm if necessary
if [ ! -d /persist/alarm ]; then
    mkdir /persist/alarm
    chown system:system /persist/alarm
fi
