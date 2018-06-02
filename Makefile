SOURCE_KITTEN_SHA=0.20.0
SWIFTAST_SHA=v0.4.2
USE_CASE_SHA=7ef9af8f6d52a1b6127cc9141e2b670c28a1dd3b
KOTLIN_NATIVE_SHA=v0.7
MUSTACHE_SHA=v7.3.2

ROOT=$(shell pwd)

SRC_PATH=$(ROOT)/lib-src
KOTLIN_NATIVE_SRC_PATH=$(SRC_PATH)/kotlinnative
USECASES_SRC_PATH=$(SRC_PATH)/usecases
SOURCEKITTEN_SRC_PATH=$(SRC_PATH)/sourcekitten
SWIFTAST_SRC_PATH=$(SRC_PATH)/swift-ast
MUSTACHE_SRC_PATH=$(SRC_PATH)/GRMustache

BUILD_PATH=$(ROOT)/lib-build
SOURCEKITTEN_BUILD_PATH=$(BUILD_PATH)/sourcekitten

SOURCEKITTEN_PRODUCTS=$(SOURCEKITTEN_BUILD_PATH)/Build/Products/Debug
SOURCEKITTEN_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework
SOURCEKITTEN_DSYM=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework.dSYM
SWXMLHASH_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SWXMLHash.framework
YAMS_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/Yams.framework

SWIFTAST_PRODUCTS=$(SWIFTAST_SRC_PATH)/build/Build/Products/Debug
LEXER_FRAMEWORK=$(SWIFTAST_PRODUCTS)/Lexer.framework
BOCHO_FRAMEWORK=$(SWIFTAST_PRODUCTS)/Bocho.framework
DIAGNOSTIC_FRAMEWORK=$(SWIFTAST_PRODUCTS)/Diagnostic.framework
SOURCE_FRAMEWORK=$(SWIFTAST_PRODUCTS)/Source.framework

DEST_PATH=$(ROOT)/lib

.PHONY: test bootstrap clean cleanbuild sourcekitten usecases mklib cleansourcekitten mkkotlinnative swiftast xcpretty mustache

bootstrap: cleanbuild sourcekitten swiftast usecases mustache

cleanbuild:
	rm -rf $(BUILD_PATH) || true
	rm -rf $(DEST_PATH) || true

clean: cleanbuild
	rm -rf $(SRC_PATH) || true

sourcekitten: cleansourcekitten mklib xcpretty
	if [ -d "$(SOURCEKITTEN_SRC_PATH)/.git" ]; \
	then \
	cd $(SOURCEKITTEN_SRC_PATH); \
	git fetch; \
	else \
	git clone https://github.com/jpsim/SourceKitten.git $(SOURCEKITTEN_SRC_PATH); \
	cd $(SOURCEKITTEN_SRC_PATH); \
	fi; \
	git checkout $(SOURCE_KITTEN_SHA); \

	cd $(SOURCEKITTEN_SRC_PATH); \
	make bootstrap; \
	xcrun xcodebuild -workspace SourceKitten.xcworkspace -scheme SourceKittenFramework -configuration Debug -derivedDataPath $(SOURCEKITTEN_BUILD_PATH) clean build | xcpretty

	cp -Rf $(SOURCEKITTEN_FRAMEWORK) $(SOURCEKITTEN_DSYM) $(SWXMLHASH_FRAMEWORK) $(YAMS_FRAMEWORK) $(DEST_PATH)

swiftast: xcpretty
	if [ -d "$(SWIFTAST_SRC_PATH)/.git" ]; \
	then \
	cd $(SWIFTAST_SRC_PATH); \
	git fetch; \
	else \
	git clone https://github.com/yanagiba/swift-ast.git $(SWIFTAST_SRC_PATH); \
	cd $(SWIFTAST_SRC_PATH); \
	fi; \
	git checkout $(SWIFTAST_SHA); \
	make xcodegen; \
	xcodebuild -scheme SwiftAST -derivedDataPath build clean build | xcpretty; \
	rm -rf $(DEST_PATH)/Lexer.framework $(DEST_PATH)/Bocho.framework $(DEST_PATH)/Diagnostic.framework $(DEST_PATH)/Source.framework || true
	cp -R $(LEXER_FRAMEWORK) $(BOCHO_FRAMEWORK) $(DIAGNOSTIC_FRAMEWORK) $(SOURCE_FRAMEWORK) $(DEST_PATH);

usecases: mklib mkkotlinnative
	if [ -d "$(USECASES_SRC_PATH)/.git" ]; \
	then \
	cd $(USECASES_SRC_PATH); \
	git fetch; \
	else \
	git clone https://github.com/seanhenry/MockGenerator.git $(USECASES_SRC_PATH); \
	cd $(USECASES_SRC_PATH); \
	fi; \
	git checkout $(USE_CASE_SHA)

	source ~/.bash_profile; \
	export PATH=$(KOTLIN_NATIVE_SRC_PATH)/dist/bin:$$PATH; \
	cd $(USECASES_SRC_PATH)/UseCases/src/main/java; \
	kotlinc -nomain -p framework -o $(DEST_PATH)/UseCases .;

mkkotlinnative:
	if [ -d "$(KOTLIN_NATIVE_SRC_PATH)/.git" ]; \
    then \
    cd $(KOTLIN_NATIVE_SRC_PATH); \
    git fetch; \
    else \
    git clone https://github.com/JetBrains/kotlin-native.git $(KOTLIN_NATIVE_SRC_PATH); \
    cd $(KOTLIN_NATIVE_SRC_PATH); \
    fi; \
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
	if [ -d "$(MUSTACHE_SRC_PATH)/.git" ]; \
    then \
    cd $(MUSTACHE_SRC_PATH); \
    git fetch; \
    else \
    git clone https://github.com/groue/GRMustache.git $(MUSTACHE_SRC_PATH); \
    cd $(MUSTACHE_SRC_PATH); \
    fi; \
    git checkout $(MUSTACHE_SHA); \
    git submodule update --init src/vendor/groue/jrswizzle; \
	xcodebuild -project src/GRMustache.xcodeproj -scheme GRMustache7-MacOS -derivedDataPath build clean build MACOSX_DEPLOYMENT_TARGET=10.12 | xcpretty; \
	cp build/Build/Products/Debug/libGRMustache7-MacOS.a $(DEST_PATH); \
	cp -rf build/Build/Products/Debug/include $(DEST_PATH); \
	echo "$$MUSTACHE_MODULE_MAP" > $(DEST_PATH)/include/GRMustache/module.modulemap;

mklib:
	mkdir -p $(DEST_PATH)

cleansourcekitten:
	rm -rf $(SOURCEKITTEN_BUILD_PATH) || true

xcpretty:
	gem install xcpretty || true
