#!/bin/sh
count=0
ENTITLEMENTS="${PROJECT_DIR}/${CODE_SIGN_ENTITLEMENTS}"
while [ $count -lt ${SCRIPT_INPUT_FILE_COUNT} ]; do
  input="SCRIPT_INPUT_FILE_$count"
  /usr/bin/codesign --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --timestamp=none "${!input}"
  let count=count+1
done
