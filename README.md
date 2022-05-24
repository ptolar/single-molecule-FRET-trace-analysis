# single-molecule-FRET-trace-analysis
Matlab scripts to analyze single molecule FRET image streams

Requires an optional set up of Mij for communication of Matlab with ImageJ to display images, e.g. using Fiji.
Images should be multi-frame tiff files coming from an image splitter.
Images should be named with a base name followed by a number e.g. imagestream1.tif, imagestream2.tif etc

1. Set up image splitting and alignment
Use an image containing multispectral beads to set up alignment between donor and acceptor channels coming from an image splitter
run find_alignment.m
click on corresponding beads then close the window. Keep the tform variable in the workspase

2. Calculate background
Edit set up information in generateSMbackgroundStreamsSplitView.m
run generateSMbackgroundStreamsSplitView.m
keep background images dbckg, fbckg, abckg in the workspace

3. Analyse image streams
edit set up information in processSMstreamsSplitView.m
run processSMstreamsSplitView.m