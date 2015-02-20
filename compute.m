function [newImage,newF,compressratio] = compute(oldImage, compressStr, filename)

	if compressStr == 1
		[newImage,newF] = f_transform(oldImage);
	elseif compressStr == 2
		[newImage,newF] = c_transform(oldImage);
	else
		[newImage,newF] = h_transform(oldImage);
	end

	type = ''
	if compressStr == 0
		type = '.msf'
	elseif compressStr == 1
		type = '.msc'
	else
		type = '.msh'
	end
	
	filename
	
	fid = fopen(strcat(filename,type),'w');
	fwrite(fid,newF);
	
	bigfileInfo = dir(filename);


	compressedInfo = dir(strcat(filename,type));


	
	compressratio = (compressedInfo.bytes) / bigfileInfo.bytes;
