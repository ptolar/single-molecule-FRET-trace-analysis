function [tform, alignedImageNorm] = find_alignment(refimage, automatic)
% analyzes alignment using reference image of beads, consiting of an unsplit two
% channel view from optosplit or two sequential images
% generates tform that can be used to transform coodinates of molecules in
% one channel to the other using tformfwd

if ~exist('automatic', 'var')
    automatic = 0;
end

if size(refimage,3) ==1
% split reference image
w1 = refimage(:,1:size(refimage,2)/2);
w2 = refimage(:,size(refimage,2)/2+1:end);
else
    w1 = refimage(:,:,1);
    w2 = refimage(:,:,2);
end

% adjust intensities so that cpselect shows the images better
w1 = w1-min(min(w1));
w1 = w1./max(max(w1));
w2 = w2-min(min(w2));
w2 = w2/max(max(w2));

if automatic ==0
    
    %let user select equivalent points (beads)
    [w1_points, w2_points] = cpselect(w1, w2, 'Wait', true);
    
    % adjust the fine position of teh beads by correlation of the two images
    w1_points_adjusted = cpcorr(w1_points, w2_points, w1, w2);
    %calculate the transform
    tform = fitgeotrans(w1_points_adjusted, w2_points, 'affine');
    
else
    
    % or automatic
    tform = imregcorr(w1, w2, 'similarity');
    % [optimizer, metric] = imregconfig('monomodal');
    % metric = registration.metric.MattesMutualInformation();
    % tform = imregtform(w1, w2, 'similarity', optimizer, metric);
    
end

% move image1
w1c = imwarp(w1, tform, 'OutputView', imref2d(size(w2)));

alignedImageNorm = cat(3, w1c, w2);



