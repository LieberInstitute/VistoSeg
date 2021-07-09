%mask = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/Images/Liebert_Institute_OTS-20-7748_rush_posterior_2_nuclei.mat';
%jsonname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/outputs/NextSeq/DLPFC_Br3942_post_manual_alignment/outs/spatial/scalefactors_json.json';
%posname = '/dcl02/lieber/ajaffe/SpatialTranscriptomics/LIBD/spatialDLPFC/outputs/NextSeq/DLPFC_Br3942_post_manual_alignment/outs/spatial/tissue_positions_list.csv';

function count = countSpots(BW, R, tbl, posPath)
%load(mask);
%BW = mask_dark_blue;

%w = jsondecode(fileread(jsonname));
%R = ceil(w.spot_diameter_fullres/2);
%tbl = readtable(posname) ;
    
count = [];


    nSpots = size(tbl, 1);
    %disp('counting nuclei')
    disp([num2str(nSpots),' spots detected'])
    crow = round(table2array(tbl(:, 5)));
    ccol = round(table2array(tbl(:, 6)));
    mask = zeros(size(BW));
    count = zeros(nSpots, 1);
    for i = 1:nSpots
        mask(crow(i), ccol(i)) = 1;
    end
    mask = bwdist(mask) <= R;
    mask = bwlabel(mask);
    BW = bwlabel(BW);
    for i = 1:nSpots
        idx = mask(crow(i), ccol(i));
        %tmpBW = BW;
        %tmpBW(mask~=idx) = 0;
        %[~, c] = bwlabel(tmpBW);
        spot = BW(mask==idx & BW>0);
        c = length(unique(spot));
        count(i) = c;
        if mod(i,100) == 0
        disp([num2str(i),' spots finished in time ', num2str(toc),'s'])
        end
        
    end
    tbl = [tbl array2table(count)];
    tbl.Properties.VariableNames = {'barcode','tissue','row','col','imagerow','imagecol','count'};
    if ~exist(posPath, 'dir')
        mkdir(posPath);
    end
    
    disp('writing table')
    writetable(tbl, fullfile(posPath, 'tissue_spot_counts.csv'), 'Delimiter', ',');

end
