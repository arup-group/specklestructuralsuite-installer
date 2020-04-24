# SpeckleStructuralSuite Installer
SpeckleStructuralSuite installer packages Speckle clients for structural software into an installer file.

Included packages:
- [SpeckleGSA](https://github.com/arup-group/SpeckleGSA)

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Bugs and feature requests](#bugs-and-feature-requests)
- [Building SpeckleGSA](#building-specklegsa)
- [About Speckle](#about-speckle)
- [Notes](#notes)

## Requirements

- [Speckle](https://github.com/speckleworks/SpeckleInstaller/releases/latest)
- GSA 10.0 for SpeckleGSA

## Installation

Latest build can be downloaded [here](https://github.com/arup-group/specklestructuralsuite-installer/releases/latest).

Sometimes the downloaded installer mysteriously dissappears when you try to run 
it, this is due to the antivirus software the Arup computers run. You can get around
this by copying the installer to `C:\TEMP` and running it from there.

## About Speckle

Speckle reimagines the design process from the Internet up: an open source (MIT) initiative for developing an extensible Design & AEC data communication protocol and platform. Contributions are welcome - we can't build this alone!

## Release process

- Update version in the [Github Actions Yaml](https://github.com/arup-group/specklestructuralsuite-installer/blob/master/.github/workflows/build.yml) to the next version and commit locally to master
- Push to master branch on origin

To view the actions, go to the CI/CD settings at https://github.com/arup-group/specklestructuralsuite-installer/actions

## Notes

SpeckleStructuralSuite installer is maintained by [Nic Burgers](https://gitlab.arup.com/Nic.Burgers).
