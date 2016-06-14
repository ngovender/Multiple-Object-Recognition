function [robotData] = DoSIFTFeatureEx()
%DOSIFTFEATUREEX [robotData] = DoSIFTFeatureEx(robotData, imageDir)
%   This function takes robotData structure, loads each of the images in
%   the dataset, performs SIFT feature extraction and stores the results in
%   the structure. imageDir is the directory in which the images can be
%   found
%   This function assumes the presence of the VLFEAT library

robotData = struct('fileName',{},'f',{},'d',{},'frames',{},'descriptors',{});
%imageDir =  'D:\PhDWork\Datasets\Active Vision Database\occlusions\Full_Curry\segmented\';
imageDir =  'E:\PhDWork\Datasets\vocabTree\';


files = ls([imageDir,'\*.bmp']);

for j = 1:2:2%(size(files,1)-1)
    %get the fisrt image
    filename1 = files(j,:);        
    robotData(j).fileName  = filename1;
    fprintf(['Processing image ' robotData(j).fileName '\n']);
    % Load the image and convert to grey
    imFile = [imageDir filename1];%[ robotData(num).fileName]
    try
        im1 = imread(imFile);
        if(size(im1, 3) > 1)
            im1 = rgb2gray(im1);
        end
        im1 = single(im1) / 255;
    catch
        robotData(j).f = [];
        robotData(j).d = [];
        continue;
    end
    [robotData(j).frames, robotData(j).descriptors] = vl_sift(im1);
    fprintf('Got %u features!\n', size(robotData(j).frames, 2));
    
    %get the secong image
    filename1 = files(j+1,:);        
    robotData(j+1).fileName  = filename1;
    fprintf(['Processing image ' robotData(j+1).fileName '\n']);
    % Load the image and convert to grey
    imFile = [imageDir filename1];%[ robotData(num).fileName]
    try
        im2 = imread(imFile);
        if(size(im2, 3) > 1)
            im2 = rgb2gray(im2);
        end
        im2 = single(im2) / 255;
    catch
        robotData(j+1).f = [];
        robotData(j+1).d = [];
        continue;
    end
    % Perform feature extraction
    fprintf('Extracting features from image... ');
    %[robotData(num).frames, robotData(num).descriptors] = vl_sift(im, 'FirstOctave', 1, 'PeakThresh', 0.01);
    [robotData(j+1).frames, robotData(j+1).descriptors] = vl_sift(im2);
    fprintf('Got %u features!\n', size(robotData(j+1).frames, 2));
    
    %match the two images
    [matches trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY]= match(robotData(j).frames, robotData(j).descriptors,robotData(j+1).frames, robotData(j+1).descriptors,im1);

    disp('no of matches');
    disp(matches);
    
    [originalFeatures1,originalFeatures2]= hough1(trainImage1,trainImage2, matches, descriptors1,descriptors2,sizeX,sizeY);
    % write the new matches to robotData
  
    robotData(j).frames = [originalFeatures1(:).locationX;originalFeatures1(:).locationY;originalFeatures1(:).scale;originalFeatures1(:).orientation];
    disp('descritors from hough');
    disp(size(originalFeatures1,2));
    desc = zeros(128,size(originalFeatures1,2));
    for feat = 1:size(originalFeatures1,2)
        desc(:,feat) = originalFeatures1(feat).descriptor;
    end
    robotData(j).descriptors = desc;
    disp('robotData');
    disp(size(robotData(j).descriptors,2));
    
    desc = zeros(128,size(originalFeatures2,2));
    for feat = 1:size(originalFeatures2,2)
        desc(:,feat) = originalFeatures2(feat).descriptor;
    end
    robotData(j+1).descriptors = desc;
    
    robotData(j+1).frames = [originalFeatures2(:).locationX;originalFeatures2(:).locationY;originalFeatures2(:).scale;originalFeatures2(:).orientation];

  

end
%disp(sum)

   
   
