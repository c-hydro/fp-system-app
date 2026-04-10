# fp-system-app

Shell installers and environment helpers for the **FloodPROOFS** modelling system applications.

This repository packages setup scripts used to install and configure selected system applications and model components used in the FloodPROOFS ecosystem, including **CDO**, **NCO**, and **HMC**. The project is part of the wider **c-hydro / CIMA** hydrological forecasting toolchain for flood forecasting and hydrogeological risk reduction.

## Overview

`fp-system-app` is a lightweight repository focused on **system-level application setup** rather than application source development. It currently provides:

- a setup script for **CDO** (`setup_fp_system_app_cdo.sh`)
- a setup script for **NCO** (`setup_fp_system_app_nco.sh`)
- a setup script for **HMC** (`setup_fp_system_app_hmc.sh`)
- bundled source archives for selected dependencies/tools
- the original project documentation in `README.rst`

The repository description on GitHub identifies it as **“FloodProofs - Shell Environments - Scripts to set applications and tools”**. ([github.com](https://github.com/c-hydro/fp-system-app))

## Repository contents

```text
fp-system-app/
├── AUTHORS.rst
├── CHANGELOG.rst
├── LICENSE.rst
├── README.rst
├── cdo-2.0.0.tar.gz
├── nco-4.8.0.tar.gz
├── nco-5.1.7.tar.gz
├── setup_fp_system_app_cdo.sh
├── setup_fp_system_app_hmc.sh
└── setup_fp_system_app_nco.sh
```

The top-level file listing shows these installer scripts plus bundled `cdo` and `nco` archives. ([github.com](https://github.com/c-hydro/fp-system-app))

## What this repository is for

Within the broader FloodPROOFS modelling system, this repository covers the **system apps** layer: tooling needed to support processing, simulation, and analysis workflows. The upstream `README.rst` describes FloodPROOFS as an operational flood forecasting and monitoring system used for hydro-meteorological warning activities and notes that the wider chain includes processing tools, simulation tools, publishing/visualization tools, labs, and utilities. ([github.com](https://github.com/c-hydro/fp-system-app))

## Included installers

### 1. CDO installer

`setup_fp_system_app_cdo.sh` installs **CDO** and is labeled in-script as `FP ENVIRONMENT - SYSTEM APPS - CDO`. The script targets **CDO 2.0.0**, uses `$HOME/fp_system_apps` as the default installation root, and expects generic libraries under `$HOME/fp_system_libs_generic/`, including references to `jasper`, `netcdf-c`, `hdf5`, `udunits`, `eccodes`, and `proj`. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_cdo.sh))

### 2. HMC installer

`setup_fp_system_app_hmc.sh` installs or compiles **HMC** from the `c-hydro/hmc-dev` release archive. The script is labeled `FP ENVIRONMENT - SYSTEM APPS - HMC`, currently references **v3.4.2**, downloads the source archive from GitHub, and defines defaults for:

- environment file: `fp_system_libs_hmc`
- libraries folder: `$HOME/fp_system_libs_hmc/`
- HMC/app folder: `$HOME/fp_system_apps/`

The script accepts three optional positional arguments:

1. directory of dependencies
2. environment filename
3. HMC installation directory

It also requires the environment file to exist before compilation proceeds. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_hmc.sh))

### 3. NCO installer

`setup_fp_system_app_nco.sh` installs **NCO** and is labeled `FP ENVIRONMENT - SYSTEM APPS - NCO`. The script targets **NCO 5.1.7**, installs into `$HOME/fp_system_apps`, and expects dependencies under `$HOME/fp_system_libs_generic/`, including `netcdf-c`, `udunits`, and `antlr`. Its header also lists package prerequisites such as `bison`, `flex`, `gcc`, `g++`, and optional packages for specific NCO utilities. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_nco.sh))

## Platform assumptions

The original repository documentation states that FloodPROOFS environments are typically installed on **Linux Debian/Ubuntu 64-bit systems** and rely on a mix of **Python 3+**, **Fortran 2003+**, **QGIS**, **R**, and additional scientific tools. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/README.rst))

In practice, you should expect this repository to be used on Linux systems where build tools and scientific libraries are available.

## Quick start

Clone the repository:

```bash
git clone https://github.com/c-hydro/fp-system-app.git
cd fp-system-app
```

Make the scripts executable if needed:

```bash
chmod +x setup_fp_system_app_cdo.sh
chmod +x setup_fp_system_app_hmc.sh
chmod +x setup_fp_system_app_nco.sh
```

Run one of the installers:

```bash
./setup_fp_system_app_cdo.sh
./setup_fp_system_app_nco.sh
./setup_fp_system_app_hmc.sh
```

For HMC, you can also pass custom paths:

```bash
./setup_fp_system_app_hmc.sh <deps_dir> <env_filename> <hmc_dir>
```

The HMC script explicitly documents these three positional arguments in its startup messages. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_hmc.sh))

## Expected directory layout

Based on the installer defaults, a typical setup may create or use paths such as:

```text
$HOME/
├── fp_system_apps/
│   ├── source/
│   └── hmc/
├── fp_system_libs_generic/
└── fp_system_libs_hmc/
```

These locations are derived from variables defined directly in the installer scripts. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_cdo.sh))

## Notes and caveats

- This repository is primarily a **setup/installation repository**, not the main source code location for all FloodPROOFS components.
- The included scripts assume that prerequisite compilers, libraries, and system packages are already available or have been prepared elsewhere.
- Some source archives are committed directly to the repository, which can be useful for reproducibility but may not reflect the newest upstream releases.
- The existing `README.md` contains broader project background, while the installer scripts provide the most accurate technical details for this repository’s actual purpose. ([github.com](https://github.com/c-hydro/fp-system-app))

## License

This repository is distributed under the **MIT License**. ([github.com](https://github.com/c-hydro/fp-system-app))

## Related projects

- `c-hydro/hmc-dev` for the HMC model source referenced by the HMC installer. ([github.com](https://github.com/c-hydro/fp-system-app/blob/main/setup_fp_system_app_hmc.sh))
- The wider `c-hydro` GitHub organization for other FloodPROOFS / hydrological modelling components. ([github.com](https://github.com/c-hydro/fp-system-app))

