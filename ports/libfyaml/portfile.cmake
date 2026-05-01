vcpkg_download_distfile(32BIT_PATCH
    URLS "https://github.com/pantoniou/libfyaml/commit/0982fcefc6a16d4c8cb5b06747d3fc8e630de3ae.patch?full_index=1"
    FILENAME "fy_skip_size32.patch"
    SHA512 78071e1e555c531874fec6bd096b9bf8427e6b73436f679a7ef100970ccfdb0fbb0b683242a370b058d1a87f73a008861668b2d81b14a1f9fc77a19b3dbd49ec
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pantoniou/libfyaml
    REF v${VERSION}
    SHA512 e38f42b5d3e5e88300fd1c7b59868592afa5f2f88d30f61e778700c35435ebd14ecef7d82ac0213345dabdb3c562dc234ed1b2bfd84e40b47fdc4f84144c79f5
    PATCHES
        "pthread.diff" #https://github.com/pantoniou/libfyaml/pull/287
        "yield.diff" #https://github.com/pantoniou/libfyaml/pull/288
        "${32BIT_PATCH}"
        "math.diff"
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

vcpkg_copy_tools(TOOL_NAMES fy-tool AUTO_CLEAN)

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/${PORT}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")