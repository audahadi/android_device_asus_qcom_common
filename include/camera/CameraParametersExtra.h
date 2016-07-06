/*
 * Copyright (C) 2016 The CyanogenMod Project
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

#define CAMERA_PARAMETERS_EXTRA_C \
const char CameraParameters::KEY_QC_LONGSHOT_SUPPORTED[] = "longshot-supported"; \
const char CameraParameters::KEY_QC_MANUAL_FOCUS_POSITION[] = "manual-focus-position"; \
const char CameraParameters::KEY_QC_MANUAL_FOCUS_POS_TYPE[] = "manual-focus-pos-type"; \
const char CameraParameters::KEY_QC_FOCUS_POSITION_SCALE[] = "cur-focus-scale"; \
const char CameraParameters::KEY_QC_FOCUS_POSITION_DIOPTER[] = "cur-focus-diopter"; \
const char CameraParameters::KEY_QC_SUPPORTED_HDR_NEED_1X[] = "hdr-need-1x-values"; \

#define CAMERA_PARAMETERS_EXTRA_H \
    static const char KEY_QC_LONGSHOT_SUPPORTED[]; \
    static const char KEY_QC_MANUAL_FOCUS_POSITION[]; \
    static const char KEY_QC_MANUAL_FOCUS_POS_TYPE[]; \
    static const char KEY_QC_FOCUS_POSITION_SCALE[]; \
    static const char KEY_QC_FOCUS_POSITION_DIOPTER[]; \
    static const char KEY_QC_SUPPORTED_HDR_NEED_1X[]; \
