USE_CASE_SHA=7d323898e1b337b9c7e93b0f0c6d63a483bef0fc
MUSTACHE_SHA=v7.3.2
KOTLIN_NATIVE_SHA=v0.8
KOTLINC_VERSION=0.8-dev

ROOT=$(shell pwd)

SRC_PATH=/tmp/xcode-mock-generator-src
KOTLIN_NATIVE_SRC_PATH=$(SRC_PATH)/kotlinnative
USECASES_SRC_PATH=$(SRC_PATH)/usecases
MUSTACHE_SRC_PATH=$(SRC_PATH)/GRMustache
SWIFT_TOOLKIT_SRC_PATH=$(ROOT)/SwiftToolkit

DEST_PATH=$(ROOT)/lib
DEST_PATH_DEBUG=$(DEST_PATH)/Debug
DEST_PATH_RELEASE=$(DEST_PATH)/Release
KOTLINNATIVE_DEST_PATH=$(ROOT)/bin

KOTLINC=$(KOTLINNATIVE_DEST_PATH)/dist/bin/kotlinc

.PHONY: test bootstrap clean usecases mkdestpath mkkotlinnative xcpretty mustache swift-toolkit

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
	fi;
endef

usecases: mkdestpath mkkotlinnative
	$(call update_repo_sha,$(USECASES_SRC_PATH),https://github.com/seanhenry/MockGenerator.git,$(USE_CASE_SHA))
	cd $(USECASES_SRC_PATH)/UseCases/src/main/java; \
	$(KOTLINC) -nomain -p framework -o $(DEST_PATH_DEBUG)/UseCases .; \
	$(KOTLINC) -nomain -p framework -opt -o $(DEST_PATH_RELEASE)/UseCases .;

mkkotlinnative:
	if [[ "$$($(KOTLINC) -version)" =~ '$(KOTLINC_VERSION)' ]]; then \
		echo "kotlin native already installed"; \
	else \
		$(call update_repo,$(KOTLIN_NATIVE_SRC_PATH),https://github.com/JetBrains/kotlin-native.git,$(KOTLIN_NATIVE_SHA)) \
		cd $(KOTLIN_NATIVE_SRC_PATH); \
		./gradlew dependencies:update; \
		./gradlew dist distPlatformLibs; \
		cp -Rf $(KOTLIN_NATIVE_SRC_PATH)/dist $(KOTLINNATIVE_DEST_PATH); \
	fi

define MUSTACHE_MODULE_MAP
module GRMustache {
  umbrella header "GRMustache.h"
  export *
}
endef
export MUSTACHE_MODULE_MAP

# 1 - configuration
define build_mustache
	xcrun xcodebuild -project src/GRMustache.xcodeproj -scheme GRMustache7-MacOS -configuration $(1) -derivedDataPath build clean build MACOSX_DEPLOYMENT_TARGET=10.12 | xcpretty
endef

mustache: xcpretty mkdestpath
	$(call update_repo,$(MUSTACHE_SRC_PATH),https://github.com/groue/GRMustache.git,$(MUSTACHE_SHA))
	cd $(MUSTACHE_SRC_PATH); \
	git submodule update --init src/vendor/groue/jrswizzle; \
	$(call build_mustache,Debug); \
	$(call build_mustache,Release); \
	cp -Rf build/Build/Products/Debug/libGRMustache7-MacOS.a build/Build/Products/Debug/include $(DEST_PATH_DEBUG); \
	cp -Rf build/Build/Products/Release/libGRMustache7-MacOS.a build/Build/Products/Release/include $(DEST_PATH_RELEASE); \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH_DEBUG)/include/GRMustache/module.modulemap; \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH_RELEASE)/include/GRMustache/module.modulemap;

mkdestpath:
	mkdir -p $(DEST_PATH_DEBUG)
	mkdir -p $(DEST_PATH_RELEASE)
	mkdir -p $(KOTLINNATIVE_DEST_PATH)

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
	make

