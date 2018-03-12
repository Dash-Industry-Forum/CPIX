# Build process - quick start

Prerequisites:

* Windows
* Java
* Git LFS

Most of the build tooling is packaged directly in the repository. You need to have [Git LFS](https://git-lfs.github.com/) installed in order to download them, as they are stored in Large File Storage due to their size.

On first run, execute */Tooling/Install-Tooling.ps1* in PowerShell. You only need to do this once (or when the tooling is updated, which is rare).

Then execute */Tooling/Build-All.ps1* in PowerShell to build the document. This script performs all the steps of the build workflow.

You can find the publishable output in the */Output/* directory.

# Building on Linux

It should be relatively easy to enable the build process to also support building on Linux. This has not been done simply because it has not proven sufficiently necessary yet. If you wish to extend the build process to support Linux, that would be a valuable contribution.

# "The specified executable is not a valid application for this OS platform."

This error happens if you clone the repository without having Git LFS installed. Install it and clone the repository once more into a new directory.