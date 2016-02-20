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

export PATH=/system/bin

if [ -f /sys/devices/soc0/soc_id ]; then
    soc_hwid=`cat /sys/devices/soc0/soc_id`
else
    soc_hwid=`cat /sys/devices/system/soc/soc0/id`
fi

# Set ro.opengles.version based on chip id.
# MSM8939 variants supports OpenGLES 3.1
# 196608 is decimal for 0x30000 to report version 3.0
# 196609 is decimal for 0x30001 to report version 3.1
case "$soc_hwid" in
    233|239|240|241|242|243|263|268|269|270|271)
        setprop ro.opengles.version 196609
        ;;
    *)
        setprop ro.opengles.version 196608
        ;;
esac
