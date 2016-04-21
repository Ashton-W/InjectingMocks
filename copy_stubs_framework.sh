#!/usr/bin/env bash
# Build Phase Script for copying and signing a framework based on Configuration
set -o errexit
set -o nounset

STUB_FRAMEWORK_PATH="${BUILT_PRODUCTS_DIR}/TubbleStubs.framework"

# List all Xcode Build Configurations you want the stub framework in eg: ("Debug", "Test")
STUB_CONFIGURATIONS=("Debug")

copy_library() {
    rm -vRf  "${CODESIGNING_FOLDER_PATH}/PlugIns/TubbleStubs.framework"
    mkdir -p "${CODESIGNING_FOLDER_PATH}/PlugIns/"
    cp -vRf "$STUB_FRAMEWORK_PATH" "${CODESIGNING_FOLDER_PATH}/PlugIns/TubbleStubs.framework"
}

codesign_library() {
    if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" ]; then
        codesign -fs "${EXPANDED_CODE_SIGN_IDENTITY}" "${CODESIGNING_FOLDER_PATH}/TubbleStubs.framework"
    fi
}

main() {
    echo "Copy stubs framework when using build configurations: $STUB_CONFIGURATIONS"

    local is_stub_configuration=0
    for stub_configuration in $STUB_CONFIGURATIONS; do
        if [ "${CONFIGURATION}" = "$stub_configuration" ]; then
            is_stub_configuration=1
            echo "Will copy stub framework if found"
            if [ -e $STUB_FRAMEWORK_PATH ]; then
                copy_library && codesign_library
                echo "Stub framework copied"
            else
                echo "Stub framework not found"
            fi
            break
        fi
    done

    if [ $is_stub_configuration = 0 ]; then
        echo "Did not copy Stub framework for configuration ${CONFIGURATION}"
    fi
}

main
