# Contributing guidelines

The main text of the document is in the *Index.bs* file.
It is written in the [Bikeshed](https://github.com/tabatkins/bikeshed) format,
which is a mixture of [Markdown](http://commonmark.org/help/) and HTML.

XML Schema files are in the repository root directory.

Diagrams are created as [PlantUML](http://plantuml.com/) text documents
that are compiled into PNG images for publishing. You can find the diagram definitions
in the */Diagrams/* directory.

Some externally-sourced images are merged into the document from the */StaticFiles/* directory.

All these different components must be processed by the [build scripts](Building.md)
in order to arrive at the publishable output.

You are expected to conform to the following rules in your contributions:

* Follow existing style and conventions used in the document.
* Ensure that the document builds successfully after your modifications (*Build-All.ps1*).
* Manually wrap your lines at 100 characters to make it easy to use text editors
and related tools that do not support automatic word wrapping.