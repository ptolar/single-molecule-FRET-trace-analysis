# single-molecule-FRET-trace-analysis
Matlab scripts to analyze single molecule FRET image streams

Setup:
Requires Matlab with Image Processing Toolbox
Requires an optional set up of Mij (http://bigwww.epfl.ch/sage/soft/mij/) for communication of Matlab with ImageJ to display images, this can be achieved e.g. using Fiji.
Images should be multi-frame tiff files coming from an image splitter (e.g. with the left half of the chip the donor and the left half the acceptor wavelenght)
Images should be named with a base name followed by a number e.g. imagestream1.tif, imagestream2.tif etc

Usage:
1. Set up image splitting and alignment
Use an image containing multispectral beads to set up alignment between donor and acceptor channels coming from an image splitter.
Run find_alignment.m
Click on corresponding beads then close the window. Keep the tform variable in the workspase.

2. Calculate background
Edit set up information in generateSMbackgroundStreamsSplitView.m
Run generateSMbackgroundStreamsSplitView.m
Keep background images dbckg, fbckg, abckg in the workspace

3. Analyse image streams
Edit set up information in processSMstreamsSplitView.m
Run processSMstreamsSplitView.m


Short sample image streams are provided along with the corresponding alignment image.
The alignment tform is also included so the alignment step can be skipped for the sample images.
