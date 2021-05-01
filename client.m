
close all;
clear ;
clc;
tic;   % tic function records the current time.

fprintf('\n==============================================> Simulation Started <==============================================\n');
fprintf('Start Time: %s\n', datestr(now,'HH:MM:SS.FFF\n\n'))

while 1 
disp("1.Train Network");
disp("2.Live Face Mask Detection Using Trained Network");
disp("3.Input Image Detection Using Trained Network");
disp("4.Input Image Detection Using Viola-Jones Algorithm");
disp("0.Exit");

n = input("Enter your Choice...\n");

switch n
    case 0
        break;
    case 1
        %Training
    case 2
        LiveMask_TrainedSet
    case 3
        InputImage_TrainedSet
    case 4
        InputImage_ViolaJones
    otherwise
        disp("Enter Correct Choice");
end

end


toc;    %toc function uses the recorded value to calculate the elapsed time.
fprintf('End Time: %s\n', datestr(now,'HH:MM:SS.FFF'))
fprintf('\n==============================================> Simulation Ended <==============================================\n');

