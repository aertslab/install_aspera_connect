#!/bin/bash

# Copyright (c) 2018 - Gert Hulselmans
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
#
# Purpose: Install latest version of Aspera Connect (linux 64-bit).
#          https://downloads.asperasoft.com/connect2/


printf 'Get Aspera Connect download URL for the last version...\n\n'

aspera_connect_url=$(
    curl 'https://downloads.asperasoft.com/en/downloads/8?list' \
      | grep -oE 'https://download.asperasoft.com/download/sw/connect/[0-9.]+/ibm-aspera-connect-[0-9.]+-linux-.+\.tar.gz'
)

printf "\n  ${aspera_connect_url}\n\n";


# Extract Aspera Connect tarball basename from download URL.
aspera_connect_tarball="${aspera_connect_url##*/}";

# Aspera Connect install script filename.
aspera_connect_install_script="${aspera_connect_tarball%.tar.gz}.sh";


# Create a temporary directory for downloading and extracting the tarball.
aspera_tmp_dir=$(mktemp -d);

if [ -d "${aspera_tmp_dir}" ] ; then
    cd "${aspera_tmp_dir}";

    printf "Downloading Aspera Connect tarball...\n\n";
    curl -o "${aspera_connect_tarball}" "${aspera_connect_url}";

    printf "\nExtracting Aspera Connect tarball.\n";
    tar xzf ${aspera_connect_tarball};

    # Run Aspera install script.
    "./${aspera_connect_install_script}";

    # Go back to previous directory, so we can delete the temporary directory.
    cd -;

    # Remove temporary files and directory.
    rm -r "${aspera_tmp_dir}";
else
    printf 'Error: Could not create a temporary directory.\n'
    exit 1;
fi
