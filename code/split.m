fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior.tif';
numimgs = size(imfinfo(fname),1); %numimgs is the number of images in the tif file

parfor i = 1:numimgs
    tic
    I{i}.image = imread(fname,i);
    toc
disp(num2str(i))
end

%save tif image in mat format
save([fname(1:end-4),'.mat'],'I', '-v7.3');

Img = I{1}.image;

[y,x,z] = size(Img);

Img1 = Img(:,1:round(x/4),:);

Img2 = Img(:,round(x/4):round(x/4)*2,:);
Img3 = Img(:,round(x/4)*2:round(x/4)*3,:);
Img4 = Img(:,round(x/4)*3:end,:);

IMG1 = imresize(Img1,0.7);
IMG2 = imresize(Img2,0.7);
IMG3 = imresize(Img3,0.7);
IMG4 = imresize(Img4,0.7);

for i = 1:4
save(['/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Lieber_Institute_OTS-20-7748_rush_posterior_',num2str(i),'.mat'],['Img',num2str(i)],'-v7.3');
eval(['imwrite(IMG',num2str(i),',''/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Lieber_Institute_OTS-20-7748_rush_posterior_',num2str(i),'.tif'')']);
end