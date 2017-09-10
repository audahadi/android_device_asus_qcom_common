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

import re

def FullOTA_PostValidate(info):
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "/dev/block/bootdevice/by-name/system");');
  info.script.AppendExtra('run_program("/tmp/install/bin/resize2fs_static", "/dev/block/bootdevice/by-name/system");');
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "/dev/block/bootdevice/by-name/system");');

def FullOTA_InstallEnd(info):
  info.script.AppendExtra('if getprop("ro.product.device") == "ASUS_Z010DD" then');
  info.script.AppendExtra('ui_print("installing Z010DD kernel and firmware....");');
  info.script.AppendExtra('package_extract_file("install/bin/etc", "/tmp/install/bin/etc");');
  info.script.Mount("/system")
  info.script.AppendExtra('package_extract_file("/tmp/install/bin/etc", "/system");');
  info.script.AppendExtra('symlink("/factory/wifi.nv", "/system/etc/firmware/wlan/prima/wifi.nv");');
  info.script.AppendExtra('symlink("/data/misc/wifi/WCNSS_qcom_cfg.ini", "/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini");');
  info.script.AppendExtra('set_metadata_recursive("/system", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0");');
  info.script.Unmount("/system")
  info.script.AppendExtra('run_program("/sbin/dd", "if=/tmp/install/bin/boot.img", "of=/dev/block/bootdevice/by-name/boot");');
  info.script.AppendExtra('endif;');

def FullOTA_Assertions(info):
  AddApidAssertion(info, info.input_zip)
  AddTrustZoneAssertion(info, info.input_zip)

def IncrementalOTA_Assertions(info):
  AddApidAssertion(info, info.input_zip)
  AddTrustZoneAssertion(info, info.input_zip)

def AddApidAssertion(info, input_zip):
  android_info = input_zip.read("OTA/android-info.txt")
  m = re.search(r"require\s+version-variant\s*=\s*(\S+)", android_info)
  if m:
    variants = m.group(1).replace("|", ", ")
    info.script.AppendExtra('assert(run_program("/sbin/grep", "1", "/proc/apid") != "1" || abort("Can\'t install on unsupported device. Supported devices: %s"););' % variants)

def AddTrustZoneAssertion(info, input_zip):
  android_info = info.input_zip.read("OTA/android-info.txt")
  m = re.search(r'require\s+version-trustzone\s*=\s*(\S+)', android_info)
  if m:
    versions = m.group(1).split('|')
    if len(versions) and '*' not in versions:
      cmd = 'assert(asus.verify_trustzone(' + ','.join(['"%s"' % tz for tz in versions]) + ') == "1");'
      info.script.AppendExtra(cmd)
