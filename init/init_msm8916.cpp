/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.
   Copyright (C) 2016 The CyanogenMod Project.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/sysinfo.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

char const *device;
char const *family;
char const *heapstartsize;
char const *heapgrowthlimit;
char const *heapsize;
char const *heapminfree;

void check_device()
{
    int PRJ_ID, PRJ_SKU, PRJ_HD;
    struct sysinfo sys;
    FILE *fp;

    fp = fopen("/proc/apid", "r");
    fscanf(fp, "%d", &PRJ_ID);
    fclose(fp);

    fp = fopen("/proc/aprf", "r");
    fscanf(fp, "%d", &PRJ_SKU);
    fclose(fp);

    fp = fopen("/proc/aphd", "r");
    fscanf(fp, "%d", &PRJ_HD);
    fclose(fp);

    sysinfo(&sys);

    if (PRJ_HD == 1) {
        family = "Z00L";
        if (PRJ_ID == 0) {
            if (PRJ_SKU == 3) {
                device = "Z00W"; // ZE550KG
            } else {
                device = "Z00L"; // ZE550KL
            }
        } else if (PRJ_ID == 1) {
            device = "Z00M"; // ZE600KL
        }

        // from - phone-xhdpi-2048-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "192m";
        heapsize = "512m";
        heapminfree = "512k";
    } else if (PRJ_HD == 0) {
        family = "Z00T";
        if (PRJ_ID == 0) {
            device = "Z00T"; // ZE551KL
        } else if (PRJ_ID == 1) {
            device = "Z011"; // ZE601KL
        } else if (PRJ_ID == 2) {
            device = "Z00C"; // ZX550KL
        } else if (PRJ_ID == 3) {
            device = "Z00U"; // ZD551KL
        }

        if (sys.totalram > 2048ull * 1024 * 1024) {
            // from - phone-xxhdpi-3072-dalvik-heap.mk
            heapstartsize = "8m";
            heapgrowthlimit = "288m";
            heapsize = "768m";
            heapminfree = "512k";
        } else if (sys.totalram > 1024ull * 1024 * 1024) {
            // from - phone-xxhdpi-2048-dalvik-heap.mk
            heapstartsize = "16m";
            heapgrowthlimit = "192m";
            heapsize = "512m";
            heapminfree = "2m";
        } else {
            // from - phone-xhdpi-1024-dalvik-heap.mk
            heapstartsize = "8m";
            heapgrowthlimit = "96m";
            heapsize = "256m";
            heapminfree = "2m";
        }
    }
}

static void init_alarm_boot_properties()
{
    int boot_reason;
    FILE *fp;

    fp = fopen("/proc/sys/kernel/boot_reason", "r");
    fscanf(fp, "%d", &boot_reason);
    fclose(fp);

    /*
     * Setup ro.alarm_boot value to true when it is RTC triggered boot up
     * For existing PMIC chips, the following mapping applies
     * for the value of boot_reason:
     *
     * 0 -> unknown
     * 1 -> hard reset
     * 2 -> sudden momentary power loss (SMPL)
     * 3 -> real time clock (RTC)
     * 4 -> DC charger inserted
     * 5 -> USB charger inserted
     * 6 -> PON1 pin toggled (for secondary PMICs)
     * 7 -> CBLPWR_N pin toggled (for external power supply)
     * 8 -> KPDPWR_N pin toggled (power key pressed)
     */
     if (boot_reason == 3) {
        property_set("ro.alarm_boot", "true");
     } else {
        property_set("ro.alarm_boot", "false");
     }
}

void vendor_load_properties()
{
    char b_description[PROP_VALUE_MAX], b_fingerprint[PROP_VALUE_MAX];
    char p_carrier[PROP_VALUE_MAX], p_device[PROP_VALUE_MAX], p_model[PROP_VALUE_MAX];

    std::string platform = property_get("ro.board.platform");
    if (platform != ANDROID_TARGET)
        return;

    check_device();
    init_alarm_boot_properties();

    sprintf(b_description, "%s-user 6.0.1 MMB29P WW_user_21.40.1220.2056_20170224 release-keys", family);
    sprintf(b_fingerprint, "asus/WW_%s/ASUS_%s:6.0.1/MMB29P/WW_user_21.40.1220.2056_20170224:user/release-keys", device, device);
    sprintf(p_model, "ASUS_%sD", device);
    sprintf(p_device, "ASUS_%s", device);
    sprintf(p_carrier, "US-ASUS_%s-WW_%s", device, device);

    property_set("ro.build.product", family);
    property_set("ro.build.description", b_description);
    property_set("ro.build.fingerprint", b_fingerprint);
    property_set("ro.product.carrier", p_carrier);
    property_set("ro.product.device", p_device);
    property_set("ro.product.model", p_model);

    property_set("dalvik.vm.heapstartsize", heapstartsize);
    property_set("dalvik.vm.heapgrowthlimit", heapgrowthlimit);
    property_set("dalvik.vm.heapsize", heapsize);
    property_set("dalvik.vm.heaptargetutilization", "0.75");
    property_set("dalvik.vm.heapminfree", heapminfree);
    property_set("dalvik.vm.heapmaxfree", "8m");

    INFO("Setting build properties for %s device of %s family\n", device, family);
}
