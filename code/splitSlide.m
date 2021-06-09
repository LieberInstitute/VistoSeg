function splitSlide(fname)
%fname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior.tif';
numimgs = size(imfinfo(fname),1); %numimgs is the number of images in the multiplane tif file
N = 4; %number of capture areas
disp(['The multiplane tif has ',num2str(numimgs),' images'])

parfor i = 1:numimgs
    tic
    I{i}.image = imread(fname,i);
    toc
disp(['Imported image ',num2str(i)])
end

%save tif image in mat format
disp('Saving the multiplane tif to mat file')
save([fname(1:end-4),'.mat'],'I', '-v7.3');

Img = I{1}.image; %whole slide image

[~,x,~] = size(Img);

disp('Splitting image')

Img1 = Img(:,1:round(x/N),:);
Img2 = Img(:,round(x/N):round(x/N)*2,:);
Img3 = Img(:,round(x/N)*2:round(x/N)*3,:);
Img4 = Img(:,round(x/N)*3:end,:);

%resize capture areas to 70% of orignal size
IMG1 = imresize(Img1,0.7);
IMG2 = imresize(Img2,0.7);
IMG3 = imresize(Img3,0.7);
IMG4 = imresize(Img4,0.7);

[path1,name1,ext1] = fileparts(fname);
CapArea = {'A1','B1','C1','D1'};

disp('Saving capture areas')
for i = 1:N
save([fullfile(path1,name1),'_',CapArea{i},'.mat'],['Img',num2str(i)],'-v7.3');
eval(['imwrite(IMG',num2str(i),',''',fullfile(path1,name1),'_',CapArea{i},ext1,''')']);
end