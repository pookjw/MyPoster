TARGET := iphone:clang:latest
INSTALL_TARGET_PROCESSES = PosterBoard
THEOS_PACKAGE_SCHEME = rootless
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyPosterPBTweak
$(TWEAK_NAME)_CFLAGS = -fno-objc-arc -fno-objc-weak -Wno-module-import-in-extern-c -Wno-unused-variable -std=c++2b
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_FILES = init.mm

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/tool.mk
