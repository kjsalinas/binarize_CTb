function [img_to_import] = load_for_binarization(filename)
%file name is a string containing keyword to load image (saved as a tiff is preferred)
% examples filename = 'CTb' or 'GFP'

currentFolder=pwd;
files=dir;

image_name = strcat({'*'},{filename},{'*'});
image_name = char(image_name);
img_name_full= dir(image_name);

img_to_import = imread(img_name_full.name);

figure()
imagesc(img_to_import)
title([strcat('raw ', filename)]);

end

