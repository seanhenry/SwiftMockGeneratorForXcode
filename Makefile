JAVA_HOME?=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home
JAVAC=$(JAVA_HOME)/bin/javac
ROOT=$(shell pwd)

SRC_PATH=$(shell pwd)/lib-src
AVIAN_SRC_PATH=$(SRC_PATH)/avian
USECASES_SRC_PATH=$(SRC_PATH)/usecases
SOURCEKITTEN_SRC_PATH=$(SRC_PATH)/sourcekitten

BUILD_PATH=$(ROOT)/lib-build
AVIAN_BUILD_PATH=$(AVIAN_SRC_PATH)/build/macosx-x86_64
JAVA_BUILD_PATH=$(BUILD_PATH)/classes
SOURCEKITTEN_BUILD_PATH=$(BUILD_PATH)/sourcekitten

SOURCEKITTEN_PRODUCTS=$(SOURCEKITTEN_BUILD_PATH)/Build/Products/Debug
SOURCEKITTEN_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework
SOURCEKITTEN_DSYM=$(SOURCEKITTEN_PRODUCTS)/SourceKittenFramework.framework.dSYM
SWXMLHASH_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/SWXMLHash.framework
YAMS_FRAMEWORK=$(SOURCEKITTEN_PRODUCTS)/Yams.framework

DEST_PATH=$(ROOT)/lib
AVIAN_DEST_PATH=$(DEST_PATH)/avian

.PHONY: test bootstrap clean cleanbuild sourcekitten usecases avian kotlin mklib mkavian

bootstrap: cleanbuild sourcekitten usecases

cleanbuild:
	rm -rf $(BUILD_PATH) || true
	rm -rf $(DEST_PATH) || true

clean: cleanbuild
	rm -rf $(SRC_PATH) || true

sourcekitten: mkclasses mklib

	if [ -d "$(SOURCEKITTEN_SRC_PATH)/.git" ]; \
	then \
	cd $(SOURCEKITTEN_SRC_PATH); \
	git fetch; \
	git pull; \
	else \
	git clone https://github.com/jpsim/SourceKitten.git $(SOURCEKITTEN_SRC_PATH); \
	fi;

	cd $(SOURCEKITTEN_SRC_PATH); \
	make bootstrap; \
	xcrun xcodebuild -workspace SourceKitten.xcworkspace -scheme SourceKittenFramework -configuration Debug -derivedDataPath $(SOURCEKITTEN_BUILD_PATH) clean build

	cp -Rf $(SOURCEKITTEN_FRAMEWORK) $(SOURCEKITTEN_DSYM) $(SWXMLHASH_FRAMEWORK) $(YAMS_FRAMEWORK) $(DEST_PATH)

usecases: mkavian mklib mkclasses avian kotlin
	if [ -d "$(USECASES_SRC_PATH)/.git" ]; \
	then \
	cd $(USECASES_SRC_PATH); \
	git fetch; \
	git pull; \
	else git \
	clone https://github.com/seanhenry/MockGenerator.git $(USECASES_SRC_PATH); \
	cd $(USECASES_SRC_PATH); \
	git checkout -b refactor origin/refactor; \
	fi

	cd $(USECASES_SRC_PATH)/UseCases; \
	kotlinc src -include-runtime -jdk-home $(JAVA_HOME) -d $(BUILD_PATH)/usecases_kotlin.jar; \
	find src -name "*.java" -print | xargs $(JAVAC) -d $(JAVA_BUILD_PATH)

	cd $(JAVA_BUILD_PATH); \
	unzip -n $(AVIAN_BUILD_PATH)/classpath.jar; \
	unzip -o $(BUILD_PATH)/usecases_kotlin.jar; \
	cd ..; \
	rm $(BUILD_PATH)/usecases_kotlin.jar; \
	jar -c0vf boot.jar -C $(JAVA_BUILD_PATH) .; \
	$(AVIAN_BUILD_PATH)/binaryToObject/binaryToObject boot.jar boot-jar.o _binary_boot_jar_start _binary_boot_jar_end macosx x86_64; \
	rm libs.list || true; \
	touch libs.list; \
	for filename in *.o; do \
	echo $(AVIAN_DEST_PATH)/$$filename >> libs.list; \
	done; \
	mv -f libs.list *.o $(AVIAN_DEST_PATH)


avian:
	if [ -d "$(AVIAN_SRC_PATH)/.git" ]; \
	then \
	cd $(AVIAN_SRC_PATH); \
	git fetch; \
	git pull; \
	else \
	git clone https://github.com/ReadyTalk/avian.git $(AVIAN_SRC_PATH); \
	fi;

	cd $(AVIAN_SRC_PATH); \
	export JAVA_HOME=$(JAVA_HOME); \
	make

	cd $(BUILD_PATH); \
	ar x $(AVIAN_BUILD_PATH)/libavian.a

kotlin:
	brew update
	if hash kotlinc 2>/dev/null; then \
        brew upgrade kotlin || true; \
    else \
        brew install kotlin; \
    fi

mklib:
	mkdir -p $(DEST_PATH)

mkavian:
	mkdir -p $(AVIAN_DEST_PATH)

mkclasses:
	rm -rf $(JAVA_BUILD_PATH) || true
	mkdir -p $(JAVA_BUILD_PATH)
