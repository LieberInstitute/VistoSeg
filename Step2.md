
# NUCLEI SEGMENTATION

We have been using two methods for nuclei segmentation in histology images.
1) Intensity thesholding: works fine with high resolution images 
2) Kmeans color based segmentation: works well with low contrast, noisy background, low resolution images. (ex: 10x images)

The following shows both the segmentations for the 1st sub image of 'Lieber_Institute_OTS-20-7748_rush_posterior.tif' used is Step1.

# Intensity thresholding
```matlab
fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior_1.tif';
Img = imread(fname,1);
thresh = greythresh(rgb2grey(Img));
BW = imbinarize(rgb2grey(Img),thresh);

save('/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior_1_nucleisegmentation.mat','BW')
imwrite(BW,'/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior_1_nucleisegmentation.tif')
```
# Kmeans segmentation

```matlab
fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior_1.tif';
Img = imread(fname,1);
Img_smooth = imgaussfilt(Img,4);
Img_smooth_adj = imadjust(Img_smooth, [.2 .3 0; .6 .7 1],[]);

he = Img_smooth_adj;
lab_he = rgb2lab(he);
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 5;
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);

parfor i = 1:nColors
mask{i} = pixel_labels==i;
cluster{i} = he .* uint8(mask{i});
end

nuclei_mask = mask{4};
imwrite(cluster{4},'/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/MiSeq_Pilot/Images/Raw/Lieber-Institute_OTS-20-7748_rush_posterior_1_cluster4Nuclei.tif') 
save('/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/MiSeq_Pilot/Images/Raw/Lieber-Institute_OTS-20-7748_rush_posterior_1_nucleisegmentation.mat','nuclei_mask')
```
