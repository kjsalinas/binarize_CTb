# binarize_CTb
detection algorithm to binarize histology label, written for CTb-AF594 detection 

load_for_binarization.m searched for a file, named filename, in string format, in the current directory to read. The file should be a single channel with signal from label that is to be binarized. 
ex. load_for_binarization('CTb') will load a tiff or png file that includes "CTb" in the hame. 

Binarize CTb based on a detection algorithm with some modifications for Callaway lab 2P or flour microscopy imaging
Reference : https://www.sciencedirect.com/science/article/pii/S2589004221004181#fig2
