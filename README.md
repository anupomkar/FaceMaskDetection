# FaceMaskDetection using MATLAB

To help combat the Covid19, this repo can be used for real time face mask detection using webcam or the image input can also be given.
It's implemented using DeepLearning and Viola Jones algorithms

The Repository contains 
a)5 script files Training.m, LiveMask_TrainedSet.m, InputImage_TrainedSet, InputImage_ViolaJones,client.m.
b)1 trained_network.mat file
c)1 GUI APP

Clone the repository or download the source code files(mentioned above).
1)Execute 'Training.m' to train the DataSet (DataSet Link : "https://github.com/TheSSJ2612/Real-Time-Medical-Mask-Detection/releases/download/v0.1/Dataset.zip") Or u can use pre trained network (trained_network.mat) provided in the Repo.
2) Now Execute client.m file for non GUI fashion
3) U can also try the GUI APP 'Face_Mask_Detection_GUI_APP.mlapp' provided in the Repo.

Note that all files including the Dataset should be in same Directory.




Toolboxes required for simulations:
1) Statistics and Machine Learning Toolbox for MATLAB
2) Computer Vision Toolbox for MATLAB
3) Image Processing Toolbox for MATLAB
4) Deep Learning Toolbox for MATLAB
5) MATLAB Support Package for USB Webcams
