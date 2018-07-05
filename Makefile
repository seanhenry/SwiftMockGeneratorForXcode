USE_CASE_SHA=776bad689e57b8958083f72c54827bf689488847
KOTLIN_NATIVE_SHA=v0.8
MUSTACHE_SHA=v7.3.2
SWIFT_TOOLKIT_SHA=master

ROOT=$(shell pwd)

SRC_PATH=/tmp/xcode-mock-generator-src
KOTLIN_NATIVE_SRC_PATH=$(SRC_PATH)/kotlinnative
USECASES_SRC_PATH=$(SRC_PATH)/usecases
MUSTACHE_SRC_PATH=$(SRC_PATH)/GRMustache
SWIFT_TOOLKIT_SRC_PATH=$(ROOT)/SwiftToolkit

DEST_PATH=$(ROOT)/lib

.PHONY: test bootstrap clean cleanbuild usecases mklib mkkotlinnative xcpretty mustache swift-toolkit

bootstrap: cleanbuild swift-toolkit usecases mustache swift-toolkit

cleanbuild:
	rm -rf $(BUILD_PATH) || true
	rm -rf $(DEST_PATH) || true

clean: cleanbuild
	rm -rf $(SRC_PATH) || true

# 1 - path to repo
# 2 - remote url
# 3 - sha
define update_repo
	if [ -d "$(1)/.git" ]; then \
	  cd $(1); \
	  git fetch --depth 1 origin $(3); \
	  git checkout -b $(3) FETCH_HEAD || true; \
	else \
	  git clone --depth 1 $(2) $(1) -b $(3); \
	fi;
endef

usecases: mklib mkkotlinnative
	$(call update_repo,$(USECASES_SRC_PATH),https://github.com/seanhenry/MockGenerator.git,$(USE_CASE_SHA))
	cd $(USECASES_SRC_PATH); \
	git checkout $(USE_CASE_SHA); \
	source ~/.bash_profile; \
	export PATH=$(KOTLIN_NATIVE_SRC_PATH)/dist/bin:$$PATH; \
	cd $(USECASES_SRC_PATH)/UseCases/src/main/java; \
	kotlinc -nomain -p framework -o $(DEST_PATH)/UseCases .;

mkkotlinnative:
	$(call update_repo,$(KOTLIN_NATIVE_SRC_PATH),https://github.com/JetBrains/kotlin-native.git,$(KOTLIN_NATIVE_SHA))
	cd $(KOTLIN_NATIVE_SRC_PATH); \
	git checkout $(KOTLIN_NATIVE_SHA); \
	./gradlew dependencies:update; \
    ./gradlew dist distPlatformLibs;

define MUSTACHE_MODULE_MAP
module GRMustache {
  umbrella header "GRMustache.h"
  export *
}
endef
export MUSTACHE_MODULE_MAP

mustache: xcpretty mklib
	$(call update_repo,$(MUSTACHE_SRC_PATH),https://github.com/groue/GRMustache.git,$(MUSTACHE_SHA))
	cd $(MUSTACHE_SRC_PATH); \
	git checkout $(MUSTACHE_SHA); \
    git submodule update --init src/vendor/groue/jrswizzle; \
	xcodebuild -project src/GRMustache.xcodeproj -scheme GRMustache7-MacOS -derivedDataPath build clean build MACOSX_DEPLOYMENT_TARGET=10.12 | xcpretty; \
	cp build/Build/Products/Debug/libGRMustache7-MacOS.a $(DEST_PATH); \
	cp -rf build/Build/Products/Debug/include $(DEST_PATH); \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH)/include/GRMustache/module.modulemap;

mklib:
	mkdir -p $(DEST_PATH)
	mkdir -p $(SWIFT_TOOLKIT_SRC_PATH)

cleansourcekitten:
	rm -rf $(SOURCEKITTEN_BUILD_PATH) || true

xcpretty:
	gem install xcpretty || true

swift-toolkit: mklib
	$(call update_repo,$(SWIFT_TOOLKIT_SRC_PATH),git@bitbucket.org:seanhenry/swift-toolkit.git,$(SWIFT_TOOLKIT_SHA))
	cd $(SWIFT_TOOLKIT_SRC_PATH); \
	make

