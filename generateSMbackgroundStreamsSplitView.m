% calculate background images

%% Setup

% folder with image streams
% files should be a name followed by a number e.g. image1, image2 etc
path = '/Users/ptolar/Documents/Large Data/Raj/IgM 526 on IgM/';

% basename for image files
basename = 'IgM 526 stream';

% range of the files numbers to analyze
fileNum = 1:10; 

% specify acceptor and donor excitation frames within strea
dframes = 2:26;
aframes = 1;

% pixel size of split-image field of view (half of the chip)
imsize = [256, 512];

% specify columns and rows to keep (crop out the rest)
cropx = 1:256;
cropy = 1:512;


%% calculate background
dbckg = zeros(imsize(2),imsize(1),numel(dframes), numel(fileNum));
fbckg = zeros(imsize(2),imsize(1),numel(dframes), numel(fileNum));
abckg = zeros(imsize(2),imsize(1),numel(aframes), numel(fileNum));


h = waitbar(0, 'reading streams');

for m = 1:numel(fileNum)
    
    %read images
    stream = squeeze(read_image_sequence([path, basename, num2str(fileNum(m)),'.tif']));
    dbckg(:,:,:,m) = stream(:,1:imsize(1),dframes);
    fbckg(:,:,:,m) = stream(:,imsize(1)+1:end,dframes);
    abckg(:,:,:,m) = stream(:,imsize(1)+1:end,aframes);
    
    waitbar(m/numel(fileNum), h);
end

close(h)


% median filter across images
dbckg = median(dbckg, 4);
fbckg = median(fbckg, 4);
abckg = median(abckg, 4);

% smooth out the background
dbckg = imfilter(dbckg, fspecial('disk', 25),'replicate');
abckg = imfilter(abckg, fspecial('disk', 25),'replicate');
fbckg = imfilter(fbckg, fspecial('disk', 25),'replicate');

% crop
dbckg = dbckg(cropy, cropx, :,:);
fbckg = fbckg(cropy, cropx, :,:);
abckg = abckg(cropy, cropx, :,:);

% display median (backround) values per file
dint = squeeze(median(median(median(dbckg))));
fint = squeeze(median(median(median(fbckg))));
plot(dint, 'g'); hold on
plot(fint, 'r')
