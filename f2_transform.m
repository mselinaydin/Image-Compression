function newImage = f2_transform(oldImage) 
	[x,y,z] = size(oldImage);

	oldImage = im2double(oldImage);
	oldImage = rgb2gray(oldImage);	
	
	f_image = fft2(oldImage);
	figure;
	imshow(f_image);
	
	
	I1 = f_image(1:x/2,1:y/2);
	I1 = flipdim(I1 ,2);           %# horizontal flip
	I1 = flipdim(I1 ,1);           %# vertical flip

	%~ figure;
	%~ imshow(I1);
	
	I2 = f_image(x/2:x,1:y/2);
	I2 = flipdim(I2 ,2);           %# horizontal flip
	I2 = flipdim(I2 ,1);           %# vertical flip
				
	%~ figure;
	%~ imshow(I2);
		
	I3 = f_image(1:x/2,y/2:y);
	I3 = flipdim(I3 ,2);           %# horizontal flip
	I3 = flipdim(I3 ,1);           %# vertical flip
				
	%~ figure;
	%~ imshow(I3);
		
	I4 = f_image(x/2:x,y/2:y);
	I4 = flipdim(I4 ,2);           %# horizontal flip
	I4 = flipdim(I4 ,1);           %# vertical flip	
			
	%~ figure;
	%~ imshow(I4);
		
	last_image(1:x/2,1:y/2) = I1;
	last_image(x/2:x,1:y/2) = I2;
	last_image(1:x/2,y/2:y) = I3;
	last_image(x/2:x,y/2:y) = I4;
	
	%~ figure;
	%~ imshow(last_image);
	
	newImage = last_image(x/4:3*x/4,y/4:3*y/4);
%~ 
	%~ figure;
	%~ imshow(newImage);

	%last_image = conj(fourier) * new_image * fourier;
	
	newImage = ifft2(newImage);
	
	
	%~ figure;
	%~ imshow(newImage);
