 /*
 * Copyright (C) 2014, The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//#define LOG_NDEBUG 0

#define LOG_TAG "wcnss_asus"

#include <cutils/log.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define SUCCESS 0
#define FAILED -1

#define NV_FILE "/factory/wifi.nv"

#define MAC_ADDR_SIZE 6
#define WLAN_ASUS_NV "MacAddress0"

//Author: https://github.com/balika011

extern "C"{
int wcnss_init_qmi(void);
void wcnss_qmi_deinit(void);
int wcnss_qmi_get_wlan_address(unsigned char *pBdAddr);
}

struct NVData
{
        char* index;
        char* value;
};

void trim(char* str, char v = ' ')
{
        int pos = 0;
        for (int i = 0; i < strlen(str); ++i)
                if (str[i] != v)
                {
                        str[pos] = str[i];
                        ++pos;
                }
        str[pos] = '\0';
}

NVData* splitNV(char* str)
{
        NVData* ret = new NVData;
        ret->index = nullptr;
        ret->value = nullptr;
        for (int i = 0; i < strlen(str); ++i)
        {
                if (str[i] == '=')
                {
                        str[i] = '\0';
                        ret->index = str;
                        ret->value = &str[i + 1];
                        break;
                }
        }

        return ret;
}

#define BUFFER_SIZE 1024

NVData** parseNVFile(const char* file)
{
        FILE* f = fopen(file, "r");
        if (!f)
                return nullptr;

        NVData** items = nullptr;
        int itemsc = 0;

        for (char* line; line = new char[BUFFER_SIZE], fgets(line, BUFFER_SIZE, f) != NULL;)
        {
                if (line[0] == '#')
                        continue;

                trim(line, ' ');
                trim(line, '\r');
                trim(line, '\n');

                NVData* nvd = splitNV(line);

                if (!nvd->index || !nvd->value)
                        continue;

                NVData** new_items = new NVData*[itemsc + 1];
                if (itemsc)
                        memcpy(new_items, items, itemsc * sizeof(NVData*));
                items = new_items;

                new_items[itemsc] = nvd;
                ++itemsc;
        }

        fclose(f);

        NVData* nvd = new NVData;
        nvd->index = nullptr;
        nvd->value = nullptr;

        NVData** new_items = new NVData*[itemsc + 1];
        if (items)
                memcpy(new_items, items, itemsc * sizeof(NVData*));
        new_items[itemsc] = nvd;
        ++itemsc;
        items = new_items;

        return items;
}

NVData** g_nvds = nullptr;

int wcnss_init_qmi(void)
{
        g_nvds = parseNVFile(NV_FILE);

        return g_nvds ? SUCCESS : FAILED;
}

void wcnss_qmi_deinit(void)
{
        if (g_nvds)
        {
                for (int i = 0; g_nvds[i]->index && g_nvds[i]->value; ++i)
                {
                        delete [] g_nvds[i]->index;
                        //We don't need to delete value, because of how I wrote splitNV.
                        delete [] g_nvds[i];
                }
                delete [] g_nvds;
        }
}

#define ASCIITOHEX(x) (x < 'A' ? x - '0' :  x - (x < 'a' ? 'A' : 'a') + 0xA)
#define MKCHAR(x, y) (x << 4 | y)

int wcnss_qmi_get_wlan_address(unsigned char *pBdAddr)
{
        if (!g_nvds)
                return FAILED;

        for (int i = 0; g_nvds[i]->index && g_nvds[i]->value; ++i)
        {
                if (strcmp(g_nvds[i]->index, WLAN_ASUS_NV) != 0)
                        continue;

                for (int j = 0; j < strlen(g_nvds[i]->value) / 2; ++j)
                        pBdAddr[j] = MKCHAR(ASCIITOHEX(g_nvds[i]->value[j * 2]), ASCIITOHEX(g_nvds[i]->value[j * 2 + 1]));

                return SUCCESS;
        }

        return FAILED;
}
