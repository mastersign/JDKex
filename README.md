# JDKex

_JDKex_ converts a windows installer of the _Oracle JDK_ into a portable standalone folder and ZIP file.

## Prerequisites

An installed version of _7zip_ available as `7z` on the commandline.

## Usage

Call `convert.cmd` with the JDK installer exe file as the only argument.

Alternatively, just drag-and-drop the installer file on `convert.cmd`, which will do exactly the same.

The portable JDK will be stored in the folder `result` as an open folder as a compressed ZIP file.

**Hint:** By default the converted JDK is stripped by the _Apache Derby DB_, the _Java-FX_ source files and the _Mission Control_ tool.