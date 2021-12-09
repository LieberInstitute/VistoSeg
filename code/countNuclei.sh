#!/bin/bash
#$ -cwd
#$ -l mem_free=20G,h_vmem=20G,h_fsize=100G
#$ -pe local 8
#$ -o /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/V10B01-086_B1_countNuclei.txt
#$ -e /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/V10B01-086_B1_countNuclei.txt
#$ -m e
#$ -M heenadivecha@gmail.com


echo "**** Job starts ****"
date


echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${SGE_TASK_ID}"
echo "****"
echo "Sample id: V10B01-086_B1"
echo "****"

module load matlab/R2019a

toolbox='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code'
mask='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/processed-data/Images/VistoSeg/Capture_areas/V10B01-086_B1_nuclei.mat'
jsonname='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/processed-data/spaceranger_miseq/V10B01-086_B1/outs/spatial/scalefactors_json.json'
posname='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/processed-data/spaceranger_miseq/V10B01-086_B1/outs/spatial/tissue_positions_list.csv'


matlab -nodesktop -nosplash -nojvm -r "addpath(genpath('$toolbox')), countNuclei('$mask','$jsonname','$posname')"

echo "**** Job ends ****"
date
