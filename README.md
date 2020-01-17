# SpeckleStructuralSuite Installer
SpeckleStructuralSuite installer packages Speckle clients for structural software into an installer file.

Included packages:
- [SpeckleGSA](https://gitlab.arup.com/speckle/SpeckleGSA)

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

Latest build can be downloaded [here](https://gitlab.arup.com/speckle/specklestructuralsuite-installer/releases).

Sometimes the downloaded installer mysteriously dissappears when you try to run 
it, this is due to the antivirus software the Arup computers run. You can get around
this by copying the installer to `C:\TEMP` and running it from there.

## About Speckle

Speckle reimagines the design process from the Internet up: an open source (MIT) initiative for developing an extensible Design & AEC data communication protocol and platform. Contributions are welcome - we can't build this alone!

## Release process

- Update version in the .gitlab-ci.yml to the next version and commit locally to master
- Push to master branch on origin
- Trigger build (using one of the configured runners) at https://gitlab.arup.com/speckle/specklestructuralsuite-installer/pipelines
- Check that the artefacts are available at https://gitlab.arup.com/speckle/specklestructuralsuite-installer/-/releases

To view the runners, go to the CI/CD settings at https://gitlab.arup.com/speckle/specklestructuralsuite-installer/-/settings/ci_cd

## Notes

SpeckleStructuralSuite installer is maintained by [Nic Burgers](https://gitlab.arup.com/Nic.Burgers).
