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

import com.cyanogenmod.settings.device.utils.FileUtils;

public final class CMActionsSettings {
    private static final String TAG = "CMActions";

    // Preference keys
    public static final String TOUCHSCREEN_C_GESTURE_KEY = "touchscreen_gesture_c";
    public static final String TOUCHSCREEN_E_GESTURE_KEY = "touchscreen_gesture_e";
    public static final String TOUCHSCREEN_S_GESTURE_KEY = "touchscreen_gesture_s";
    public static final String TOUCHSCREEN_V_GESTURE_KEY = "touchscreen_gesture_v";
    public static final String TOUCHSCREEN_W_GESTURE_KEY = "touchscreen_gesture_w";
    public static final String TOUCHSCREEN_Z_GESTURE_KEY = "touchscreen_gesture_z";

    // Proc nodes
    private static final String TOUCHSCREEN_GESTURE_MODE_NODE =
            "/sys/bus/i2c/devices/i2c-5/5-0038/gesture_mode";

    // Key Masks
    public static final int KEY_MASK_GESTURE_CONTROL = 0x40;
    public static final int KEY_MASK_GESTURE_C = 0x04;
    public static final int KEY_MASK_GESTURE_E = 0x08;
    public static final int KEY_MASK_GESTURE_S = 0x10;
    public static final int KEY_MASK_GESTURE_V = 0x01;
    public static final int KEY_MASK_GESTURE_W = 0x20;
    public static final int KEY_MASK_GESTURE_Z = 0x02;

    public CMActionsSettings() {
        // this class is not supposed to be instantiated
    }

    /* Use bitwise logic to set gesture_mode in kernel driver */
    public static void updateGestureMode(Context context) {
        int gestureMode = 0;
        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);

        if (sharedPrefs.getBoolean(TOUCHSCREEN_C_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_C;
        if (sharedPrefs.getBoolean(TOUCHSCREEN_E_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_E;
        if (sharedPrefs.getBoolean(TOUCHSCREEN_S_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_S;
        if (sharedPrefs.getBoolean(TOUCHSCREEN_V_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_V;
        if (sharedPrefs.getBoolean(TOUCHSCREEN_W_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_W;
        if (sharedPrefs.getBoolean(TOUCHSCREEN_Z_GESTURE_KEY, false))
            gestureMode = gestureMode ^ KEY_MASK_GESTURE_Z;
        if (gestureMode != 0)
            gestureMode = (gestureMode ^ KEY_MASK_GESTURE_CONTROL);

        Log.d(TAG, "finished gesture mode: " + gestureMode);
        FileUtils.writeLine(TOUCHSCREEN_GESTURE_MODE_NODE, String.format("%7s",
                Integer.toBinaryString(gestureMode)).replace(' ', '0'));
    }
}
