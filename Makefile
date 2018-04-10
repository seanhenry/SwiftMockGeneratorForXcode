SOURCE_KITTEN_SHA=e06eb730499439ae32c5fbb6f72809ebec2371fd
SWIFTAST_SHA=87888a78bc264a57536e6c628f4ad4ad02eadd06
USE_CASE_SHA=1b8f92147545cfb7013699224ee35139acee9579
KOTLIN_NATIVE_SHA=e1e4a5ce82051b642511bef7299d6297f29ca2b4

ROOT=$(shell pwd)

SRC_PATH=$(ROOT)/lib-src
KOTLIN_NATIVE_SRC_PATH=$(SRC_PATH)/kotlinnative
USECASES_SRC_PATH=$(SRC_PATH)/usecases
SOURCEKITTEN_SRC_PATH=$(SRC_PATH)/sourcekitten
SWIFTAST_SRC_PATH=$(SRC_PATH)/swift-ast

BUILD_PATH=$(ROOT)/lib-build
SOURCEKITTEN_BUILD_PATH=$(BUILD_PATH)/sourcekitten

SOURCEKITTEN_PRODUCTS=$(SOURCEKITTEN_BUILD_PATH)/Build/Products/Debug
SOURCEKITTEN_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework
SOURCEKITTEN_DSYM=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework.dSYM
SWXMLHASH_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SWXMLHash.framework
YAMS_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/Yams.framework

DEST_PATH=$(ROOT)/lib

.PHONY: test bootstrap clean cleanbuild sourcekitten usecases mklib cleansourcekitten mkkotlinnative swiftast xcpretty

bootstrap: cleanbuild sourcekitten swiftast usecases

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
	cp -Rf build/Build/Products/Debug/*.framework $(DEST_PATH);


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

mklib:
	mkdir -p $(DEST_PATH)

cleansourcekitten:
	rm -rf $(SOURCEKITTEN_BUILD_PATH) || true

xcpretty:
	gem install xcpretty || true
