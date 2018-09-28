#!/bin/sh

if [ $CONFIGURATION == "Debug" ] || [ $CONFIGURATION == "Profile" ]; then
  exit 0
fi

DEST_DIR="$CONFIGURATION_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH"

mkdir -p "$DEST_DIR"
rm -rf "$DEST_DIR/Bocho.framework" \
"$DEST_DIR/Diagnostic.framework" \
"$DEST_DIR/Lexer.framework" \
"$DEST_DIR/Source.framework" \
"$DEST_DIR/SourceKittenFramework.framework" \
"$DEST_DIR/SWXMLHash.framework" \
"$DEST_DIR/Yams.framework" \
"$DEST_DIR/UseCases.framework" || true

FRAMEWORK_DIR="$SRCROOT/SwiftToolkit/Frameworks/$CONFIGURATION"
echo "Copying frameworks in $FRAMEWORK_DIR to $DEST_DIR"

cp -R \
"$FRAMEWORK_DIR/Bocho.framework" \
"$FRAMEWORK_DIR/Diagnostic.framework" \
"$FRAMEWORK_DIR/Lexer.framework" \
"$FRAMEWORK_DIR/Source.framework" \
"$FRAMEWORK_DIR/SourceKittenFramework.framework" \
"$FRAMEWORK_DIR/SWXMLHash.framework" \
"$FRAMEWORK_DIR/Yams.framework" \
"$DEST_DIR"

FRAMEWORK_DIR="$SRCROOT/lib/$CONFIGURATION"
echo "Copying $FRAMEWORK_DIR/UseCases.framework to $DEST_DIR"
cp -R "$FRAMEWORK_DIR/UseCases.framework" "$DEST_DIR"

ENTITLEMENTS="${PROJECT_DIR}/MockGeneratorApp/MockGeneratorApp.entitlements"

cd "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Contents/Frameworks"

for framework in *.framework; do
  /usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --entitlements "$ENTITLEMENTS" --timestamp=none $framework
done

for lib in *.dylib; do
  /usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --entitlements "$ENTITLEMENTS" --timestamp=none $lib
done
