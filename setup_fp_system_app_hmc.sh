#!/usr/bin/env bash
set -euo pipefail

#-----------------------------------------------------------------------------------------
# Script information
script_name='FP ENVIRONMENT - SYSTEM APPS - HMC'
script_version="3.4.2"
script_date='2026/04/09'

# Define file reference path according with https link(s)
fileref_model_archive_remote='https://github.com/c-hydro/hmc-dev/archive/refs/tags/v3.4.2.tar.gz'		
fileref_model_archive_local='hmc.tar.gz'

# Argument(s) default definition(s)
fileref_env_default='fp_system_libs_hmc'
fp_folder_libs_default="${HOME}/fp_system_libs_hmc/"
fp_folder_hmc_default="${HOME}/fp_system_apps/"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Info script start
echo " ==================================================================================="
echo " ==> ${script_name} (Version: ${script_version} Release_Date: ${script_date})"
echo " ==> START ..."

# Get arguments number and values
script_args_n=$#
script_args_values="$*"

echo ""
echo " ==> Script arguments number: ${script_args_n}"
echo " ==> Script arguments values: ${script_args_values}"
echo ""
echo " ==> Script arguments 1 - Directory of dependecies [string: path]-> ${1:-}"
echo " ==> Script arguments 2 - Filename of system environment [string: filename] -> ${2:-}"
echo " ==> Script arguments 3 - Directory of hmc [string: path] -> ${3:-}"
echo ""

# Set argument(s)
if [ "$#" -gt 3 ]; then
	echo "ERROR: too many arguments. Expected 0 to 3, got $#." >&2
	exit 1
fi

if [ $# -eq 0 ]; then
	fp_folder_libs="$fp_folder_libs_default"
	fileref_env="$fileref_env_default"
	fp_folder_hmc="$fp_folder_hmc_default"
elif [ $# -eq 1 ]; then
	fp_folder_libs="$1"
	fileref_env="$fileref_env_default"
	fp_folder_hmc="$fp_folder_hmc_default"
elif [ $# -eq 2 ]; then
	fp_folder_libs="$1"
	fileref_env="$2"
	fp_folder_hmc="$fp_folder_hmc_default"
elif [ $# -eq 3 ]; then
	fp_folder_libs="$1"
	fileref_env="$2"
	fp_folder_hmc="$3"
fi

# Create library folder
if [ ! -d "$fp_folder_libs" ]; then
	mkdir -p "$fp_folder_libs"
fi

# Define folder(s)
fp_folder_source="${fp_folder_hmc}/source"
fp_folder_exec="${fp_folder_hmc}/hmc"
# Define environment filename
fp_file_env="${fp_folder_libs}/${fileref_env}"

# multilines comment: if [ 1 -eq 0 ]; then ... fi
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Create folder(s)
if [ ! -d "$fp_folder_libs" ]; then
	mkdir -p "$fp_folder_libs"
fi
if [ ! -d "$fp_folder_source" ]; then
	mkdir -p "$fp_folder_source"
fi
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Download library source codes
echo " ====> GET LIBRARY FILES ... "
echo " ::: wget --content-disposition "$fileref_model_archive_remote" -O "$fileref_model_archive_local" "
cd "$fp_folder_source"
wget --content-disposition "$fileref_model_archive_remote" -O "$fileref_model_archive_local"
echo " ====> GET LIBRARY FILES ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Install ZLIB library
echo " ====> COMPILE HMC MODEL ... "

cd "$fp_folder_source"

fp_folder_source_hmc="${fp_folder_source}/hmc"
if [ ! -d "$fp_folder_source_hmc" ]; then
	mkdir -p "$fp_folder_source_hmc"
fi

tar xvfz "$fileref_model_archive_local" -C "$fp_folder_source_hmc" --strip-components=1
cd "$fp_folder_source_hmc"

echo " ::: HMC FILE LOCATION: $fileref_model_archive_local"
echo " ::: HMC LIBS LOCATION: $fp_folder_libs"
echo " ::: HMC EXEC LOCATION: $fp_folder_exec"

if [ ! -f "$fp_file_env" ]; then
	echo "ERROR: environment file not found: $fp_file_env" >&2
	exit 1
fi

# shellcheck disable=SC1090
source "$fp_file_env"

chmod +x configure.sh
./configure.sh "$fp_folder_source_hmc" "$fp_folder_libs" "$fp_folder_exec" true

echo " ====> COMPILE HMC MODEL ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Info script end
echo " ==> ${script_name} (Version: ${script_version} Release_Date: ${script_date})"
echo " ==> ... END"
echo " ==> Bye, Bye"
echo " ==================================================================================="
# ----------------------------------------------------------------------------------------
