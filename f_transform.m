function [last_image,new_image] = f_transform(image) 
	[x,y,z] = size(image);

	image = im2double(image);
	image = rgb2gray(image);	
	fourier =  zeros(x,x);
	
	factor = exp(-2.0 * pi * sqrt(-1) / x)  ;

	
	for i = 1:x
		for j = 1:x
			fourier(i,j) = (factor ^ ((i-1)*(j-1))) / sqrt(x);
		end
	end
	
	f_image = fourier * image * conj(fourier);
	
	
	new_image = f_image;
	%for i = 1:x
		%for j = 1:x
			%%if i < x/2
				%%if j < x/2
					%%%a = x/2 - i
					%%%b = x/2 - j
					%%new_image(i,j) = f_image(x/2 - i , x/2 - j);
				%%elseif j > x/2
					%%%a = x/2 - i 
					%%%b = j - x/2
					%%new_image(i,j) = f_image(x/2 - i , j - x/2);
				%%else
					%%new_image(i,j) = 0; 
				%%end
				
				
			%%elseif i > x/2 
				%%if j < x/2
					%%%a = i - x/2 
					%%%b = x/2 - j
					%%new_image(i,j) = f_image(i - x/2 , x/2 - j);
				%%elseif j > x/2
					%%%a = i - x/2 
					%%%b = j - x/2
					%%new_image(i,j) = f_image(i - x/2 , j - x/2);
				%%else
					%%new_image(i,j) = 0; 
				%%end
			%%else
				%%new_image(i,j) = 0;	
			%%end				
			
				
		%end
	%end	
	
	I1 = f_image(1:x/2,1:y/2);
	I1 = flipdim(I1 ,2);           %# horizontal flip
	I1 = flipdim(I1 ,1);           %# vertical flip

		

	I2 = f_image(x/2:x,1:y/2);
	I2 = flipdim(I2 ,2);           %# horizontal flip
	I2 = flipdim(I2 ,1);           %# vertical flip
	
			

	
	I3 = f_image(1:x/2,y/2:y);
	I3 = flipdim(I3 ,2);           %# horizontal flip
	I3 = flipdim(I3 ,1);           %# vertical flip
	
			

	
	I4 = f_image(x/2:x,y/2:y);
	I4 = flipdim(I4 ,2);           %# horizontal flip
	I4 = flipdim(I4 ,1);           %# vertical flip	
		
		

	
	new_image(1:x/2,1:y/2) = I1;
	new_image(x/2:x,1:y/2) = I2;
	new_image(1:x/2,y/2:y) = I3;
	new_image(x/2:x,y/2:y) = I4;
	
		

	
	
	new_image = new_image(1.5 * x/10:8.5*x/10,1.5*y/10:8.5*y/10);


	%decompress
	
	newF = zeros(x,x);
	
	I11 = new_image(1:3.5 * x/10,1:3.5 * y/10);
	I11 = flipdim(I11 ,2);           %# horizontal flip
	I11 = flipdim(I11 ,1);           %# vertical flip

		

	I22 = new_image(0.35 * x:0.7 * x,1:0.35 * y);
	I22 = flipdim(I22 ,2);           %# horizontal flip
	I22 = flipdim(I22 ,1);           %# vertical flip
	
			

	
	I33 = new_image(1:x * 0.35,y * 0.35:y * 0.7);
	I33 = flipdim(I33 ,2);           %# horizontal flip
	I33 = flipdim(I33 ,1);           %# vertical flip
	
			

	
	I44 = new_image(x * 0.35:x * 0.7,y * 0.35:y * 0.7);
	I44 = flipdim(I44 ,2);           %# horizontal flip
	I44 = flipdim(I44 ,1);           %# vertical flip	 
	
	newF(1:3.5 * x/10,1:3.5 * y/ 10) = I11;
	newF(6.5 *x/10:x,1:3.5 * y/10) = I22;
	newF(1:3.5 * x/10,6.5 * y/10:y) = I33;
	newF(6.5*x/10:x,6.5*y/10:y) = I44;
	
	size(newF)
	


	last_image = conj(fourier) * f_image * fourier;
	
	
	last_image = im2uint8(last_image);


	

	
	

