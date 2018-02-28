SOURCE_KITTEN_SHA=71e8297e5d95118588f8aa8e1de892762346dc9d
USE_CASE_SHA=6e25d0a542ac588a488aade9098a29dd372936f4
KOTLIN_NATIVE_SHA=eae130e246dff2502a3f79ee146e333cdc5024bf

ROOT=$(shell pwd)

SRC_PATH=$(ROOT)/lib-src
KOTLIN_NATIVE_SRC_PATH=$(SRC_PATH)/kotlinnative
USECASES_SRC_PATH=$(SRC_PATH)/usecases
SOURCEKITTEN_SRC_PATH=$(SRC_PATH)/sourcekitten

BUILD_PATH=$(ROOT)/lib-build
SOURCEKITTEN_BUILD_PATH=$(BUILD_PATH)/sourcekitten

SOURCEKITTEN_PRODUCTS=$(SOURCEKITTEN_BUILD_PATH)/Build/Products/Debug
SOURCEKITTEN_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework
SOURCEKITTEN_DSYM=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework.dSYM
SWXMLHASH_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SWXMLHash.framework
YAMS_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/Yams.framework

DEST_PATH=$(ROOT)/lib

.PHONY: test bootstrap clean cleanbuild sourcekitten usecases mklib cleansourcekitten mkkotlinnative

bootstrap: cleanbuild sourcekitten usecases

cleanbuild:
	rm -rf $(BUILD_PATH) || true
	rm -rf $(DEST_PATH) || true

clean: cleanbuild
	rm -rf $(SRC_PATH) || true

sourcekitten: cleansourcekitten mklib

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
	xcrun xcodebuild -workspace SourceKitten.xcworkspace -scheme SourceKittenFramework -configuration Debug -derivedDataPath $(SOURCEKITTEN_BUILD_PATH) clean build

	cp -Rf $(SOURCEKITTEN_FRAMEWORK) $(SOURCEKITTEN_DSYM) $(SWXMLHASH_FRAMEWORK) $(YAMS_FRAMEWORK) $(DEST_PATH)

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
	cd $(USECASES_SRC_PATH)/UseCases; \
	kotlinc -nomain -p framework -o $(DEST_PATH)/UseCases src;

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
