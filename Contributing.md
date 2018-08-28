# Contributing guidelines

To propose an addition or edit to the document, [open a pull request](https://help.github.com/articles/creating-a-pull-request/) from a branch in your [personal fork](https://help.github.com/articles/about-forks/) that contains the changes you wish to contribute.

# What is where?

The main text of the document is in the *Index.bs* file. It is written in the [Bikeshed](https://github.com/tabatkins/bikeshed) format, which is a mixture of [Markdown](http://commonmark.org/help/) and HTML.

XML Schema files are in the repository root directory.

Diagrams are created as [PlantUML](http://plantuml.com/) text documents that are compiled into PNG images for publishing. You can find the diagram definitions in the */Diagrams/* directory.

Some externally-sourced images are merged into the document from the */StaticFiles/* directory.

All these different components must be processed by the [build scripts](Building.md) in order to arrive at the publishable output.

# Contribution rules

You are expected to conform to the following rules in your contributions:

* Follow existing style and conventions used in the document.
* Ensure that the document builds successfully after your modifications (*Build-All.ps1*).