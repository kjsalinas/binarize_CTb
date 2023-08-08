# binarize_CTb
detection algorithm to binarize histology label, written for CTb-AF594 detection 

load_for_binarization.m searches for a file, named filename (input in string format) in the current directory to read into matlab. The file should be a single channel with signal from label that is to be binarized. 
ex. [CTb_img]=load_for_binarization('CTb') will load a tiff or png file that includes "CTb" in the name. 

binarizeCTb_hist.m binarizes signal of CTb_img following a detection algorithm (Morimoto et al., 2021, linked below) with some modifications for Callaway lab flour microscopy imaging. 
Output is a binarized image of labeled cells. 

Reference : https://www.sciencedirect.com/science/article/pii/S2589004221004181#fig2
