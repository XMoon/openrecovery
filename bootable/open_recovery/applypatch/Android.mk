# Copyright (C) 2008 The Android Open Source Project
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

ifneq ($(TARGET_SIMULATOR),true)

ifeq ($(TARGET_ARCH),arm)
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := applypatch.c bspatch.c freecache.c imgpatch.c utils.c
LOCAL_MODULE := libapplypatch_orcvr
LOCAL_MODULE_TAGS := eng
LOCAL_C_INCLUDES += external/bzip2 external/zlib $(LOCAL_PATH)/.. 
LOCAL_STATIC_LIBRARIES += libmtdutils libmincrypt libbz libz

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := main.c
LOCAL_MODULE := applypatch-or
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := eng
LOCAL_C_INCLUDES += $(LOCAL_PATH)/.. 
LOCAL_STATIC_LIBRARIES += libapplypatch_orcvr libmtdutils libmincrypt libbz
LOCAL_STATIC_LIBRARIES += libz libcutils libstdc++ libc

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := imgdiff.c utils.c bsdiff.c
LOCAL_MODULE := imgdiff-or
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := eng
LOCAL_C_INCLUDES += external/zlib external/bzip2
LOCAL_STATIC_LIBRARIES += libz libbz

include $(BUILD_HOST_EXECUTABLE)

endif   # TARGET_ARCH == arm
endif  # !TARGET_SIMULATOR
