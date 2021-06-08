function refineVNS(fname,M)
load(fname)
mask_name = [fname(1:end-4),'_mask.mat'];
load(mask_name)
he = Img1;
lab_he = rgb2lab(he);
L = lab_he(:,:,1);
L_blue = L .* double(mask{M});
L_blue = rescale(L_blue);
idx_light_blue = imbinarize(nonzeros(L_blue));

blue_idx = find(mask{M});
mask_dark_blue = mask{M};
mask_dark_blue(blue_idx(idx_light_blue)) = 0;

blue_nuclei = he .* uint8(mask_dark_blue);

imwrite(blue_nuclei,[fname(1:end-4),'_nuclei.tif'])
save([fname(1:end-4),'_nuclei.mat'],'mask_dark_blue','-v7.3')
end


