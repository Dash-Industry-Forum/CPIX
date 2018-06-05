# Build process - quick start

Most of the build tooling is packaged directly in the repository. You need to have [Git LFS](https://git-lfs.github.com/) installed in order to download them, as they are stored in Large File Storage due to their size.

On first run, execute */Tooling/Install-Tooling.ps1* in PowerShell. You only need to do this once (or when the tooling is updated, which is rare).

Then execute */Tooling/Build-All.ps1* in PowerShell to build the document. This script performs all the steps of the build workflow.

You can find the publishable output in the */Output/* directory.

# Building on Windows
Prerequisites:
* Java
* Git LFS

If you use Visual Studio Code as your text editor, the build script is already wired up to the editor's build shortcut (Control+Shift+B).

NOTE: If you get the error "The specified executable is not a valid application for this OS platform", it may be because you cloned the repository without having Git LFS installed. Install it and clone the repository once more into a new directory.

# Building on Linux & Mac
Prerequisites:
* Java
* curl
* [Graphviz](https://www.graphviz.org/)
* [wkthmltopdf](https://wkhtmltopdf.org/)

The prerequisites are either already installed, or can be easily installed using the Debian Package Manager for Linux (apt get install ...)  or Homebrew for Mac (brew install ...).

Once installed, just execute Tooling/build-all.sh from the command line.
