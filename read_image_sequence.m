function image = read_image_sequence (file_name)   %image = read_image_sequence (file_name)

if file_name(end-2:end) == 'tif' | file_name(end-2:end) == 'TIF'
    info = imfinfo(file_name);
    m = length(info);
    x = info(1).Width;
    y = info(1).Height;
    image = zeros (y,x,1,m);

    for frame = 1:m
        image(:,:,1,frame) = imread (file_name, frame);
    end
else
    
%==========================================================================
%
% the following import works with MetaMorph stk-files, with ImageJ tif-stacks
% and also with Zeiss LSM images. 
% Only Image Pro completely screws up the tif format
%
% full support for Zeiss LSM and SPE fiels (native Roper file format) will
% follow soon
%
% changed 070830 00.70  Tobias Meckel
%
%==========================================================================

    [stack, img_read] = tiffread2(file_name);

    m = img_read;
    x = stack(1).width;
    y = stack(1).height;
    
    image = zeros (y,x,1,m);

    for frame = 1:m
        image(:,:,1,frame) = stack(frame).data;
    end
end