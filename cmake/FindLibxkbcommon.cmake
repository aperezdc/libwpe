# - Try to find libxkbcommon.
# Once done, this will define
#
#  LIBXKBCOMMON_FOUND - System has libxkbcommon.
#  LIBXKBCOMMON_INCLUDE_DIR - Include directory for xkbcommon/xkbcommon.h
#  LIBXKBCOMMON_LIBRARY - Full path to libxkbcommon.
#  LibXkbcommon::LibXkbcommon - Imported library target.
#
# Copyright (C) 2014, 2019 Igalia S.L.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1.  Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
# 2.  Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND ITS CONTRIBUTORS ``AS
# IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR ITS
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

find_package(PkgConfig)
pkg_check_modules(LIBXKBCOMMON xkbcommon)

find_path(LIBXKBCOMMON_INCLUDE_DIR
    NAMES xkbcommon/xkbcommon.h
    HINTS ${LIBXKBCOMMON_INCLUDEDIR} ${LIBXKBCOMMON_INCLUDE_DIRS}
)
find_library(LIBXKBCOMMON_LIBRARY
    NAMES xkbcommon
    HINTS ${LIBXKBCOMMON_LIBDIR} ${LIBXKBCOMMON_LIBRARY_DIRS}
)
mark_as_advanced(LIBXKBCOMMON_INCLUDE_DIR LIBXKBCOMMON_LIBRARY)

# If pkg-config has not found the module but find_path+find_library have
# figured out where the header and library are, create the
# LibXkbcommon::LibXkbcommon imported target anyway with the found paths.
#
if (LIBXKBCOMMON_LIBRARY AND NOT TARGET LibXkbcommon::LibXkbcommon)
    add_library(LibXkbcommon::LibXkbcommon INTERFACE IMPORTED)
    if (TARGET PkgConfig::LIBXKBCOMMON)
        target_link_libraries(LibXkbcommon::LibXkbcommon INTERFACE PkgConfig::LIBXKBCOMMON)
    else ()
        set_property(TARGET LibXkbcommon::LibXkbcommon PROPERTY
            INTERFACE_LINK_LIBRARIES "${LIBXKBCOMMON_LIBRARY}")
        set_property(TARGET LibXkbcommon::LibXkbcommon PROPERTY
            INTERFACE_INCLUDE_DIRECTORIES "${LIBXKBCOMMON_INCLUDE_DIR}")
    endif ()
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBXKBCOMMON REQUIRED_VARS
    LIBXKBCOMMON_LIBRARY LIBXKBCOMMON_INCLUDE_DIR)
