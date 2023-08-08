function [CTb_binarized] = binarizeCTb_hist()
%Use this binarization algorithm on histological single channel images
%Would need to modify code to add path if you want to go that route, this
%code expects your tiff to be in the current folder

[CTb] = load_for_binarization('CTb');

if max(max(CTb))>255
    CTb_norm = (CTb - min(min(CTb)))/(max(max(CTb)) - min(min(CTb))) * 255.0;
else
    CTb_norm= CTb; % no normalization needed
end

%1. background subtraction using morphological top-hat filter imtophat (structural element: ‘‘disk,’’ size: 4)
se = strel('disk', 2);
CTb_sub=imtophat(CTb_norm, se);
figure(1)
subplot(1,2,1)
imagesc(CTb_norm); colormap(gray)
subplot(1,2,2)
imshow(CTb_sub);
title('1. top-hat filter, SE=2')

%2. binarization by imbinarize using a percentile threshold (typically 99.5 to 99.8 percentile of the fluorescence intensity distribution)
[~, threshold] = edge(CTb_sub, 'log');
fudgeFactor = 1;
%sigma = 2; %use sigma=2.5 for CTb detection
sigma=2.125; %try for Jaws/fluor histology, seems to work better for 2P analysis also. 
CTb_bin = edge(CTb_sub,'log', threshold * fudgeFactor, sigma);

figure(2)
imshowpair(CTb, CTb_bin);
title(sprintf(['2. binarize-Laplacian, sig = ', num2str(sigma)]))

%3. selecting objects larger than 6 pixels in the binary image using bwareaopen;
pixels = 12;
CTb_bin_2= bwareaopen(CTb_bin, pixels);
figure(3)
imshowpair(CTb, CTb_bin_2);
title(sprintf(['3. objects > ', num2str(pixels), 'pixels']))

%4. dilate edges of objects using imerode/imdilate (structural element: ‘‘disk’’; size: 1)
%Dilate the image: 
se90 = strel('line', 1, 90);
se0 = strel('line', 1, 0);
BWsdil = imdilate(CTb_bin_2, [se90 se0], 'full');
figure(4), 
imshowpair(CTb, BWsdil), 
title('4. dilated gradient mask');


%5. Fill gaps: 
BWdfill = imfill(BWsdil, 'holes');
figure(5), imshow(BWdfill);
title('5. binary image with filled holes');

SE = strel("disk",1);
CTb_BW = imerode(BWdfill, SE); 
figure(6)
imshowpair(CTb, CTb_BW);
title('6. im_erode, disk, size=1')


CTb_binarized=double(CTb).*CTb_BW;

%overlay: 
figure(7); 
imagesc(CTb_binarized);
colormap(hot); 

figure(8);
subplot(1,2,1)
imagesc(CTb);
title('raw image')
colormap(gray); 
subplot(1,2,2)
imagesc(CTb_binarized); 
colormap(hot); 
set(gcf, 'Position', [110 560 1485 420]);
title('binarized CTb')
subtitle(['sigma=', num2str(sigma)]) 
exportgraphics(gcf, 'CTb_binarized.pdf', 'ContentType','vector')
save('CTb_binarized','CTb_binarized');

end

