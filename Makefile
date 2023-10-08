package::
	xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'MyPoster.xcodeproj' -scheme MyPoster -configuration Debug -arch arm64 -sdk iphoneos -derivedDataPath ".xcodebuild" CODE_SIGNING_ALLOWED=NO ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
	ldid -S"MyPoster/entitlements.xml" ".xcodebuild/Build/Products/Debug-iphoneos/MyPoster.app"
	ldid -S"MyPosterPlugin/entitlements.xml" ".xcodebuild/Build/Products/Debug-iphoneos/MyPoster.app/PlugIns/MyPosterPlugin.appex"
	rm -rf "layout"
	mkdir -p "layout/var/jb/Applications"
	mv -f ".xcodebuild/Build/Products/Debug-iphoneos/MyPoster.app" "layout/var/jb/Applications"
clean::
	rm -rf "layout"
	rm -rf ".xcodebuild"

THEOS_PACKAGE_SCHEME = rootless
include $(THEOS)/makefiles/common.mk
SUBPROJECTS += MyPosterPBTweak
include $(THEOS_MAKE_PATH)/aggregate.mk
