# SPLIT HISTOLOGY IMAGE INTO SUBSECTIONS 
The raw histology image file from the slide scanner (JHU imaging core) is a multiplane tif file. The sample 'Lieber_Institute_OTS-20-7748_rush_posterior.tif' (DLPFC data) is used here to run through the pipeline. 

The tif file is loaded and saved as matlab structure as shown below. 

```matlab
fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior.tif';
numimgs = size(imfinfo(fname),1); %numimgs is the number of images in the tif file

parfor i = 1:numimgs
    tic
    I{i}.image = imread(fname,i);
    toc
disp(num2str(i))
end

%save tif image in mat format
save('/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Lieber_Institute_OTS-20-7748_rush_posterior.mat','I', '-v7.3');

```

This sample tif file has 7 images (numimgs = 7) shown below.

<img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img1.png" title="Image 1" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img2.png" title="Image 2" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img3.png" title="Image 3" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img4.png" title="Image 4" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img5.png" title="Image 5" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img6.png" title="Image 6" /> <img src="https://github.com/LieberInstitute/Spatial_ImgProcessing/blob/main/img7.png" title="Image 7" /><br/>

Though most of the images look same, the first image in the tif stack/file is the high resolution image of the slide, which was based on the image size (y,x,z dimensions) in pixels shown below in matlab. 

```matlab
>> size(I{1}.image)

ans =

       53384      160858           3

>> size(I{2}.image)

ans =

         339        1024           3

>> size(I{3}.image)

ans =

       13346       40214           3
       
>> size(I{4}.image)

ans =

        3336       10053           3

>> size(I{5}.image)  

ans =

         834        2513           3

>> size(I{6}.image)

ans =

         777         765           3

>> size(I{7}.image)  

ans =

         612        1600           3

```

The image (Img) is split into 4 sub images (Img1,Img2,Img3,Img4) by dividing the x(160858) dimesion into 4 equal parts. Sometimes the center of the image is not the center of the slide, in such case the offset is adjusted manually. Each sub image is resized to 70% of the original size (eg 100 X 100 Pixel region is resized to 70 X 70 pixel region) and saved as individual tif and mat files in the same location as the raw tif file. Images are resized as matlab cannot store images that occupies more than 2^32 - 1 bytes of data.

```matlab
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

