THEOS_DEVICE_IP = 192.168.123.13
include $(THEOS)/makefiles/common.mk

TOOL_NAME = AboutDevice
AboutDevice_CFLAGS = -fobjc-arc
AboutDevice_FILES = main.m
AboutDevice_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/tool.mk
