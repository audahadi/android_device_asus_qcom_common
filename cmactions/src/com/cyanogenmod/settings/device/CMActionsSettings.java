/*
 * Copyright (C) 2015 The CyanogenMod Project
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

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.util.Log;

import org.cyanogenmod.internal.util.FileUtils;

public final class CMActionsSettings {
    private static final String TAG = "CMActions";

    // Proc nodes
    private static final String TOUCHSCREEN_GESTURE_MODE_NODE =
            "/sys/bus/i2c/devices/i2c-5/5-0038/gesture_mode";

    // Preference keys
    public static final String[] ALL_GESTURE_KEYS = {
        "touchscreen_gesture_c",
        "touchscreen_gesture_e",
        "touchscreen_gesture_s",
        "touchscreen_gesture_v",
        "touchscreen_gesture_w",
        "touchscreen_gesture_z",
    };

    // Key Masks
    private static final int KEY_MASK_GESTURE_CONTROL = 0x40;
    public static final int[] ALL_GESTURE_MASKS = {
        0x04, // c gesture mask
        0x08, // e gesture mask
        0x10, // s gesture mask
        0x01, // v gesture mask
        0x20, // w gesture mask
        0x02, // z gesture mask
    };

    private CMActionsSettings() {
        // this class is not supposed to be instantiated
    }

    /* Use bitwise logic to set gesture_mode in kernel driver */
    public static void updateGestureMode(Context context) {
        int gestureMode = 0;

        // Make sure both arrays are set up correctly
        if (ALL_GESTURE_KEYS.length != ALL_GESTURE_MASKS.length) {
            Log.w(TAG, "Array lengths do not match!");
            return;
        }

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);

        for (int i = 0; i < ALL_GESTURE_KEYS.length; i++) {
            if (sharedPrefs.getBoolean(ALL_GESTURE_KEYS[i], false)) {
                gestureMode |= ALL_GESTURE_MASKS[i];
            }
        }

        if (gestureMode != 0)
            gestureMode |= KEY_MASK_GESTURE_CONTROL;

        Log.d(TAG, "finished gesture mode: " + gestureMode);
        FileUtils.writeLine(TOUCHSCREEN_GESTURE_MODE_NODE, String.format("%7s",
                Integer.toBinaryString(gestureMode)).replace(' ', '0'));
    }
}
