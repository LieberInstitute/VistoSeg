#!/bin/bash
#$ -cwd
#$ -l mem_free=20G,h_vmem=20G,h_fsize=100G
#$ -pe local 7
#$ -o /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/10-11-2021_Visium_V10B01-086_HPC_Round2.txt
#$ -e /dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code/logs/10-11-2021_Visium_V10B01-086_HPC_Round2.txt
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
echo "Sample id: 10-11-2021_Visium_V10B01-086_HPC_Round2"
echo "****"

module load matlab/R2019a

toolbox='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/code/VistoSeg/code'
fname='/dcs04/lieber/lcolladotor/spatialHPC_LIBD4035/spatial_hpc/raw-data/Images/CS2/round2/10-11-2021_Visium_V10B01-086_HPC_Round2.tif'

matlab -nodesktop -nosplash -nojvm -r "addpath(genpath('$toolbox')), splitSlide('$fname')"

echo "**** Job ends ****"
date
