#!/bin/bash
#$ -cwd
#$ -l bluejay,mem_free=20G,h_vmem=20G,h_fsize=100G
#$ -pe local 7
#$ -o /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/V10B01-086_B1_refVNS_Run2.txt
#$ -e /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/V10B01-086_B1_refVNS_Run2.txt
#$ -m e
#$ -M heenadivecha@gmail.com
#$ -t 1
#$ -tc 2


echo "**** Job starts ****"
date


echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${SGE_TASK_ID}"
echo "****"
echo "Sample id: V10B01-086_B1_Run2"
echo "****"

module load matlab/R2019a

toolbox='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code'
fname='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/processed-data/Images/VistoSeg/Capture_areas/V10B01-086_B1.tif'

matlab -nodesktop -nosplash -nojvm -r "addpath(genpath('$toolbox')), refineVNS('$fname',2)"

echo "**** Job ends ****"
date
