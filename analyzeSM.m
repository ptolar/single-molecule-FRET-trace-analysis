function spots = analyzeSM(image1, image2, th1, th2, maxdist, sz, crop1, crop2)
% find spots and get their intensities; find colocalized spots in
%  two color images, background corrected
% spots is tabel with columns: x y intensity

if ~exist('sz', 'var')    
    sz = 2;
end

if ~exist('maxdist', 'var')    
    maxdist = 2;
end

% crop images
if exist('crop1', 'var')
    image1 = image1(crop1.y, crop1.x);
    image2 = image2(crop2.y, crop2.x);
end

% find spots in first channel
im1f = bpass(image1, 1, 5);
spots1 = pkfnd (im1f, th1, 2);

% finds spots in second channel
im2f = bpass(image2, 1, 5);
spots2 = pkfnd (im2f, th2, 2);

% calculate intensity of the spots
for m = 1:size(spots1,1)
    x = spots1(m, 1);
    y = spots1(m, 2);
    spots1(m,3) = mean2(image1(y-sz:y+sz, x-sz:x+sz));
end

for m = 1:size(spots2,1)
    x = spots2(m, 1);
    y = spots2(m, 2);
    spots2(m,3) = mean2(image2(y-2:y+2, x-2:x+2));
end

% find spots that colocalize in the two images
spots = colocalize_spots(spots1, spots2 , maxdist);

