
The raw histology image file from the slide scanner (JHU imaging core) is a multiplane tif file. The sample 'Lieber_Institute_OTS-20-7690_rush_anterior.tif' (DLPFC data) is used here to run through the pipeline. 

The tif file is loaded and saved as matlab structure as shown below. 

```matlab
fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Lieber_Institute_OTS-20-7690_rush_anterior.tif';
numimgs = size(imfinfo(fname),1); %numimgs is the number of images in the tif file

parfor i = 1:numimgs
    tic
    I{i}.image = imread(fname,i);
    toc
disp(num2str(i))
end

%save tif image in mat format
save('/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Lieber_Institute_OTS-20-7690_rush_anterior.mat','I', '-v7.3');

```

This sample tif file has 7 images (numimgs = 7) shown below.

```matlab
>>size(I{1}.image)

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

        777   765     3

>> size(I{7}.image)  

ans =

         612        1600           3

```
