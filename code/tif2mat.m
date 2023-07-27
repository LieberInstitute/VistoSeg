function tif2mat(fname) %function to convert segmented tif file to mat format
%fname is the path and name of the segmented tif file
imgInfo = imfinfo(fname);
N = size(imgInfo,1);

for i=1:N, eval(sprintf('channel%d = imread(fname,i);', i)); end
save([fname(1:end-4), '.mat'],'channel1','-v7.3')

if N>2
for i=2:N, save([fname(1:end-4), '.mat'],sprintf('channel%d',i),"-append"); end
%output mat file is saved at the same location as the input tif file
end