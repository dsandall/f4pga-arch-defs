# F4PGA Environment Setup with v2x Support

This repository includes a reproducible conda environment setup that ensures v2x is properly installed and available.

## Quick Start

### 1. Build the Environment
```bash
make env
```

### 2. Activate the Environment
```bash
source activate_f4pga.sh
```

### 3. Verify v2x Installation
```bash
v2x --help
```

## What Was Fixed

The original conda environment setup had these issues:
- Editable dependencies (`-e third_party/f4pga-v2x`, etc.) were specified in `conda_lock.yml` but not properly installed
- The conda environment creation would fail or complete without v2x available
- Manual pip installation was required as a workaround

## Solution

### 1. Separated Base Environment from Editable Dependencies
- `conda_base.yml`: Contains only the stable conda packages and remote pip dependencies
- Editable dependencies are installed separately via `install_editable_deps.sh`

### 2. Automated Editable Dependencies Installation
- `install_editable_deps.sh`: Script that installs all local editable dependencies in the correct order
- Integrated into the `make env` target for reproducible builds

### 3. Improved Activation Script
- `activate_f4pga.sh`: Easy activation with verification that v2x is available

## Environment Structure

```
env/conda/envs/f4pga_arch_def_base/
├── bin/
│   ├── python
│   ├── v2x          ← Now properly installed
│   └── ...
└── lib/python3.7/site-packages/
    ├── v2x/         ← Editable install from third_party/f4pga-v2x
    └── ...
```

## Key Files Modified

- `Makefile`: Updated to use `conda_base.yml` and run editable dependencies installation
- `conda_base.yml`: New file with base environment (excludes problematic `-e` dependencies)
- `install_editable_deps.sh`: New script for installing editable dependencies
- `activate_f4pga.sh`: New activation script with verification

## Reproducibility

This solution ensures that:
1. Anyone running `make env` gets a working environment with v2x
2. The installation process is automated and consistent
3. Editable dependencies are installed in the correct order (vtr-xml-utils before v2x)
4. The environment can be recreated cleanly with `make clean && make env`

## Usage

After activating the environment, v2x is available as both a Python module and command-line tool:

```python
import v2x
# Use v2x programmatically
```

```bash
v2x input.v --top my_module --outfile output.xml
```