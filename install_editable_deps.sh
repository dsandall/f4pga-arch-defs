#!/usr/bin/env bash
set -e

# Script to install editable dependencies after conda environment is created
# This ensures v2x and other local packages are properly installed

echo "Installing editable dependencies..."

# Activate the conda environment
source env/conda/bin/activate f4pga_arch_def_base

# Install vtr-xml-utils first (v2x dependency)
echo "Installing vtr-xml-utils..."
pip install -e third_party/vtr-xml-utils

# Install v2x
echo "Installing v2x..."
pip install -e third_party/f4pga-v2x

# Install other critical editable dependencies
echo "Installing other editable dependencies..."
pip install -e third_party/prjxray
pip install -e third_party/xc-fasm
pip install -e third_party/qlf-fasm
pip install -e third_party/python-sdf-timing
pip install -e third_party/f4pga-xc-fasm2bels

echo "Verifying v2x installation..."
python -c "import v2x; print('v2x found successfully')"
which v2x

echo "Editable dependencies installed successfully!"