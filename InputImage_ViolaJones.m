close all;
clear;
clc;
tic;

fprintf('\n==============================================> Simulation Started <==============================================\n');
fprintf('Start Time: %s\n', datestr(now,'HH:MM:SS.FFF\n\n'))

flag = 0;
img_size = [227 227];
folders = fullfile('Dataset');

FDetect = vision.CascadeObjectDetector;
[fileName,pathName] = uigetfile('.jpg');
Img = imread(fullfile(pathName,fileName));

I = imresize(Img,img_size);
imshow(I)
hold on
title('Input Image');
hold off;

BB = step(FDetect,I);
if(isempty(BB))
    msgbox("No Face Detected",'Conclusion');
else
    figure,
    imshow(I);
    hold on
    for i=1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    title('Face Detection');
    hold off
    
    NDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
    BB = step(NDetect,I);
    flag = isempty(BB);
    
    figure,
    imshow(I);
    hold on
    for i=1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
    end
    title('Nose Detection');
    hold off;
    
    
    MDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
    BB = step(MDetect,I);
    flag = flag | isempty(BB);
    
    figure,
    imshow(I);
    hold on
    for i=1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','g');
    end
    title('Mouth Detection');
    hold off;
    
    if(flag==1)
        msgbox("With_Mask",'Conclusion');
    else
        msgbox("Without_Mask / Not_Wearing_Mask_Properly",'Conclusion');
    end
    
end

toc;
fprintf('End Time: %s\n', datestr(now,'HH:MM:SS.FFF'))
fprintf('\n==============================================> Simulation Ended <==============================================\n');