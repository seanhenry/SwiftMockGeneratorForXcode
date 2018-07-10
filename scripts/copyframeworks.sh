#!/bin/sh
if [ $CONFIGURATION = "Debug" ]; then
    CONFIG="Debug"
else
    CONFIG="Release"
fi

DEST_DIR="$CONFIGURATION_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH"

rm -rf "$DEST_DIR"/*.framework || true

FRAMEWORK_DIR="$SRCROOT/SwiftToolkit/Frameworks/$CONFIG"
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

FRAMEWORK_DIR="$SRCROOT/lib/$CONFIG"
echo "Copying frameworks in $FRAMEWORK_DIR to $DEST_DIR"

cp -R "$FRAMEWORK_DIR/UseCases.framework" "$DEST_DIR"
