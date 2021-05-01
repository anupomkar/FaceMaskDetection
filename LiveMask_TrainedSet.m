

close all;
clear;
clc;
tic;

fprintf('\n==============================================> Simulation Started <==============================================\n');
fprintf('Start Time: %s\n', datestr(now,'HH:MM:SS.FFF\n\n'))

% Loading the trained network
load('trained_network.mat');

% Some preliminaries
if ~exist('camera')
    camera = webcam; % Connect to the camera
end
cr_label = 'Real-time Face Mask Detection ';
img_size = [227,227];

% Loading the face detector
FDetect = vision.CascadeObjectDetector;     %Uses viola jones algorithm to detect faces / Objects.

while true
    picture = camera.snapshot;
    orig_picture = picture;
    BB = step(FDetect, picture);    %apply the Face Detection to the live picture
    if size(BB,1) >= 1 % if a face is found
        for faces_iter = 1:size(BB,1) % for total number of faces found in the camera
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
        label = strcat(cr_label,' Detected face(s) = ',num2str(size(BB,1)));
    else % if no face found
        image(picture); % show the picture
        picture = imresize(picture,img_size);  
        axis off
        label = strcat(cr_label,' Detected face(s) = 0');
    end
    label_cell{1} = label;
    label_cell{2} = strcat('Date: ', date, ', Time: ', datestr(now,'HH:MM:SS.FFF')); % current date and time
    title(label_cell, 'FontSize', 24); % show the label    
    drawnow;

    fprintf('Detected face(s) = %d. Press ''Ctrl+c'' to end...\n', size(BB,1))
end
clear camera;
toc;
fprintf('End Time: %s\n', datestr(now,'HH:MM:SS.FFF'))
fprintf('\n==============================================> Simulation Ended <==============================================\n');



