USE_CASE_SHA=v19
MUSTACHE_SHA=v7.3.2

ROOT=$(shell pwd)

SRC_PATH=/tmp/xcode-mock-generator-src
USECASES_SRC_PATH=$(SRC_PATH)/usecases
MUSTACHE_SRC_PATH=$(SRC_PATH)/GRMustache
SWIFT_TOOLKIT_SRC_PATH=$(ROOT)/SwiftToolkit

DEST_PATH=$(ROOT)/lib
DEST_PATH_DEBUG=$(DEST_PATH)/Debug
DEST_PATH_RELEASE=$(DEST_PATH)/Release

KOTLINC=~/kotlin-native/bin/kotlinc-native

.PHONY: bootstrap clean usecases mkdestpath mkkotlinnative xcpretty mustache swift-toolkit

bootstrap: clean swift-toolkit usecases mustache

clean:
	rm -rf $(BUILD_PATH) || true
	rm -rf $(DEST_PATH) || true

# 1 - path to repo
# 2 - remote url
# 3 - branch or tag
define update_repo
	if [ -d "$(1)/.git" ]; then \
	  cd $(1); \
	  git fetch --depth 1 origin $(3); \
	  git checkout -b $(3) FETCH_HEAD || true; \
	else \
	  git clone --depth 1 $(2) $(1) -b $(3); \
	fi;
endef

# 1 - path to repo
# 2 - remote url
# 3 - sha
define update_repo_sha
	if [ -d "$(1)/.git" ]; then \
	  cd $(1); \
	  git fetch; \
	  git checkout $(3) || true; \
	else \
	  git clone $(2) $(1); \
	  git checkout $(3); \
	fi;
endef

usecases: mkdestpath mkkotlinnative
	$(call update_repo,$(USECASES_SRC_PATH),https://github.com/seanhenry/MockGenerator.git,$(USE_CASE_SHA))
	cd $(USECASES_SRC_PATH)/src/main/kotlin; \
	$(KOTLINC) -nomain -target macos_arm64 -p framework -o $(DEST_PATH_DEBUG)/arm64/UseCases .; \
	$(KOTLINC) -nomain -target macos_arm64 -p framework -opt -o $(DEST_PATH_RELEASE)/arm64/UseCases .; \
	$(KOTLINC) -nomain -target macos_x64 -p framework -o $(DEST_PATH_DEBUG)/x86_64/UseCases .; \
	$(KOTLINC) -nomain -target macos_x64 -p framework -opt -o $(DEST_PATH_RELEASE)/x86_64/UseCases .; \
	lipo -create -output $(DEST_PATH_DEBUG)/UseCases.framework/Versions/A/UseCases \
	  $(DEST_PATH_DEBUG)/x86_64/UseCases.framework/Versions/A/UseCases \
	  $(DEST_PATH_DEBUG)/arm64/UseCases.framework/Versions/A/UseCases; \
	lipo -create -output $(DEST_PATH_RELEASE)/UseCases.framework/Versions/A/UseCases \
	  $(DEST_PATH_RELEASE)/x86_64/UseCases.framework/Versions/A/UseCases \
	  $(DEST_PATH_RELEASE)/arm64/UseCases.framework/Versions/A/UseCases; \
	cp $(USECASES_SRC_PATH)/src/main/resources/*.mustache $(ROOT)/MockGenerator; \

mkkotlinnative:
	echo "Download and install Kotlin Native from https://github.com/JetBrains/kotlin/releases to ~/kotlin-native"

define MUSTACHE_MODULE_MAP
module GRMustache {
  umbrella header "GRMustache.h"
  export *
}
endef
export MUSTACHE_MODULE_MAP

# 1 - configuration
define build_mustache
	xcrun xcodebuild -project src/GRMustache.xcodeproj -scheme GRMustache7-MacOS -configuration $(1) -derivedDataPath build clean build MACOSX_DEPLOYMENT_TARGET=11.0 ONLY_ACTIVE_ARCH=NO | xcpretty
endef

mustache: xcpretty mkdestpath
	$(call update_repo,$(MUSTACHE_SRC_PATH),https://github.com/groue/GRMustache.git,$(MUSTACHE_SHA))
	cd $(MUSTACHE_SRC_PATH); \
	git submodule update --init src/vendor/groue/jrswizzle; \
	$(call build_mustache,Debug); \
    cp -Rf build/Build/Products/Debug/libGRMustache7-MacOS.a build/Build/Products/Debug/include $(DEST_PATH_DEBUG); \
	$(call build_mustache,Release); \
	cp -Rf build/Build/Products/Release/libGRMustache7-MacOS.a build/Build/Products/Release/include $(DEST_PATH_RELEASE); \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH_DEBUG)/include/GRMustache/module.modulemap; \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH_RELEASE)/include/GRMustache/module.modulemap;

mkdestpath:
	mkdir -p $(DEST_PATH_DEBUG)/x86_64 $(DEST_PATH_DEBUG)/arm64
	mkdir -p $(DEST_PATH_RELEASE)/x86_64 $(DEST_PATH_RELEASE)/arm64

xcpretty:
	gem install xcpretty || gem update xcpretty || true

swift-toolkit: mkdestpath
	if [ -d "$(SWIFT_TOOLKIT_SRC_PATH)/.git" ]; then \
	  cd $(SWIFT_TOOLKIT_SRC_PATH); \
	  git fetch; \
	  git pull; \
	else \
	  git clone git@bitbucket.org:seanhenry/swift-toolkit.git $(SWIFT_TOOLKIT_SRC_PATH); \
	fi;

	cd $(SWIFT_TOOLKIT_SRC_PATH); \
	make lib; \
	rm -rf "$(DEST_PATH_RELEASE)/SwiftToolkit.framework"; \
	rm -rf "$(DEST_PATH_DEBUG)/SwiftToolkit.framework"; \
	rm -rf "$(DEST_PATH_DEBUG)/TestHelper.framework"; \
	rm -rf "$(DEST_PATH_DEBUG)/SwiftyPluginTest.framework"; \
	cp -R lib/Release/SwiftToolkit.framework "$(DEST_PATH_RELEASE)"; \
	cp -R lib/Debug/SwiftToolkit.framework "$(DEST_PATH_DEBUG)"; \
	cp -R lib/Debug/TestHelper.framework "$(DEST_PATH_DEBUG)"; \
	cp -R lib/Debug/SwiftyPluginTest.framework "$(DEST_PATH_DEBUG)";
