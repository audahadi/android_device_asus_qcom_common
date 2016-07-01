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

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#define ISMATCH(a,b)    (!strncmp(a,b,PROP_VALUE_MAX))

char const *device;
char const *family;

void check_device()
{
    char PRJ_ID[PROP_VALUE_MAX];
    char PRJ_SKU[PROP_VALUE_MAX];
    char PRJ_HD[PROP_VALUE_MAX];
    FILE *fp;

    fp = fopen("/proc/apid", "r");
    fgets(PRJ_ID, sizeof(PRJ_ID), fp);
    pclose(fp);

    fp = fopen("/proc/aprf", "r");
    fgets(PRJ_SKU, sizeof(PRJ_SKU), fp);
    pclose(fp);

    fp = fopen("/proc/aphd", "r");
    fgets(PRJ_HD, sizeof(PRJ_HD), fp);
    pclose(fp);

    if (ISMATCH(PRJ_HD, "1\n")) {
        family = "Z00L";
        if (ISMATCH(PRJ_ID, "0\n")) {
            if (ISMATCH(PRJ_SKU, "3\n")) {
                device = "Z00W"; // ZE550KG
            } else {
                device = "Z00L"; // ZE550KL
            }
        } else if (ISMATCH(PRJ_ID, "1\n")) {
            device = "Z00M"; // ZE600KL
        }
    } else if (ISMATCH(PRJ_HD, "0\n")) {
        family = "Z00T";
        if (ISMATCH(PRJ_ID, "0\n")) {
            device = "Z00T"; // ZE551KL
        } else if (ISMATCH(PRJ_ID, "1\n")) {
            device = "Z011"; // ZE601KL
        } else if (ISMATCH(PRJ_ID, "2\n")) {
            device = "Z00C"; // ZX550KL
        } else if (ISMATCH(PRJ_ID, "3\n")) {
            device = "Z00U"; // ZD551KL
        }
    }
}

void vendor_load_properties()
{
    char b_description[PROP_VALUE_MAX], b_fingerprint[PROP_VALUE_MAX];
    char p_carrier[PROP_VALUE_MAX], p_device[PROP_VALUE_MAX], p_model[PROP_VALUE_MAX];
    char platform[PROP_VALUE_MAX];
    int rc;

    rc = property_get("ro.board.platform", platform);
    if (!rc || !ISMATCH(platform, ANDROID_TARGET))
        return;

    check_device();

    sprintf(b_description, "%s-user 6.0.1 MMB29P WW_user_21.40.0.1692_20160615 release-keys", family);
    sprintf(b_fingerprint, "asus/WW_%s/ASUS_%s:6.0.1/MMB29P/WW_user_21.40.0.1692_20160615:user/release-keys", device, device);
    sprintf(p_model, "ASUS_%sD", device);
    sprintf(p_device, "ASUS_%s", device);
    sprintf(p_carrier, "US-ASUS_%s-WW_%s", device, device);

    property_set("ro.build.product", family);
    property_set("ro.build.description", b_description);
    property_set("ro.build.fingerprint", b_fingerprint);
    property_set("ro.product.carrier", p_carrier);
    property_set("ro.product.device", p_device);
    property_set("ro.product.model", p_model);

    INFO("Setting build properties for %s device of %s family\n", device, family);
}
