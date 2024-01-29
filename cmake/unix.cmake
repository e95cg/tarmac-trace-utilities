# Copyright 2016-2021 Arm Limited. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This file is part of Tarmac Trace Utilities

# ----------------------------------------------------------------------
# Unix-specific CMake setup. Here we can reasonably expect our library
# dependencies to be installed centrally by a package manager, so we
# can just run find_package in the obvious way.

find_package(Curses ${REQUIRED_PACKAGE})
find_package(PkgConfig ${REQUIRED_PACKAGE})

include(GNUInstallDirs)
include(CheckSymbolExists)

check_symbol_exists(wcswidth "wchar.h" HAVE_WCSWIDTH)

set(LOCALEDIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LOCALEDIR}
  CACHE STRING "Directory to find gettext locale files in.")

# USE_LIBINTL: user-facing option to not even _try_ to link with libintl
set(USE_LIBINTL ON
  CACHE BOOL "Use libintl for message internationalisation if possible")

# HAVE_LIBINTL: whether we turn out to be _actually_ linking with
# libintl (requiring it to be enabled, _and_ found at configure time)
set(HAVE_LIBINTL 0)
if(USE_LIBINTL)
  find_package(Gettext)
  find_package(Intl)
  if(Intl_FOUND)
    set(HAVE_LIBINTL 1)
  endif()
endif()
