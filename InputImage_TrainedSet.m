close all;
clear;
clc;
tic;

fprintf('\n==============================================> Simulation Started <==============================================\n');
fprintf('Start Time: %s\n', datestr(now,'HH:MM:SS.FFF\n\n'))

load('trained_network.mat');
img_size = [227 227];
folders = fullfile('Dataset');

cr_label = 'Input Image Face Mask Detection';

FDetect = vision.CascadeObjectDetector;
imds = imageDatastore(folders,'IncludeSubfolders',true,'LabelSource','foldernames');
tbl = countEachLabel(imds);
[trainImgs,testImgs] = splitEachLabel(imds,0.9);

[fileName,pathName] = uigetfile('.jpg');


picture = imread(fullfile(pathName,fileName));
orig_picture = picture;
I = imresize(picture,img_size);
imshow(I)
hold on
title('Input Image');
hold off;

BB = step(FDetect,I);
if size(BB,1) >= 1 % if a face is found
        for faces_iter = 1:size(BB,1) % for total number of faces fund in the camera
            picture_cropped = imcrop(orig_picture,BB(faces_iter,:));
            picture_resized = imresize(picture_cropped,img_size);
            label = classify(net, picture_resized); % find out/classify if it has mask or not using the neural network on the processed image
            label_text = char(label);
            
            text_color = 'green';
            line_color = 'g';
            if strcmp(label_text, 'Without_Mask')
                text_color = 'red';
                line_color = 'r';
            end
            picture = insertText(picture,BB(faces_iter,1:2),label_text,'FontSize',16,'BoxColor',...
                'white','BoxOpacity',0,'TextColor',text_color); % text label around each face
            image(picture); % show the picture
            axis off;
        end
        for faces_iter = 1:size(BB,1)  % bounding boxes around each face
            rectangle('Position', BB(faces_iter,:), 'Linewidth',2,'LineStyle','-','EdgeColor',line_color);
        end
        
    else % if no face found
        image(picture); % show the picture
        picture = imresize(picture,img_size);  
        axis off
        msgbox("No Faces Detected",'Conclusion');
end

toc;
fprintf('End Time: %s\n', datestr(now,'HH:MM:SS.FFF'))
fprintf('\n==============================================> Simulation Ended <==============================================\n');

    
