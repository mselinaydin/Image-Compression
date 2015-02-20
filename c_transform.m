function [newImage,f]  = c_transform(oldImage)
	[x, y, z] = size(oldImage);
	oldImage = im2double(oldImage);
	oldImage = rgb2gray(oldImage);
	f = dct2(oldImage);
	f = f(1:x/2, 1:y/2);
	newImage = idct2(f);
%	newImage = f;
	newImage = im2uint8(newImage);
	
