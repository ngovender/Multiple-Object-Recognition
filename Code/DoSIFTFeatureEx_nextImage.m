function [robotData] = DoSIFTFeatureEx_nextImages(imageDir,filename1)
%DOSIFTFEATUREEX [robotData] = DoSIFTFeatureEx(robotData, imageDir)
%   This function takes robotData structure, loads each of the images in
%   the dataset, performs SIFT feature extraction and stores the results in
%   the structure. imageDir is the directory in which the images can be
%   found
%   This function assumes the presence of the VLFEAT library

robotData = struct('fileName',{},'f',{},'d',{},'frames',{},'descriptors',{});
%imageDir =  'D:\PhDWork\Datasets\occlusions\Minus2_Curry\segmented\';
%imageDir =  'D:\PhDWork\Datasets\vocabtree\';
%imageDir = 'D:\PhDWork\Datasets\occlusions\Confusion_Curry\segmented\';
%imageDir = 'D:\PhDWork\Datasets\occlusions\Full_Lensbox\segmented\';
%files = ls([imageDir,'*.bmp']);


%for idx = 1:size(files)
 %   disp(files(idx, :))
  %  disp(idx);
   % filename1 = files(idx,:);        
   idx = 1;
    
    robotData(idx).fileName  = filename1;
    fprintf(['Processing image ' robotData(idx).fileName '\n']);
    % Load the image and convert to grey
    imFile = [imageDir robotData(idx).fileName]
   % try
        im = imread(imFile);
        if(size(im, 3) > 1)
            im = rgb2gray(im);
        end
        im = single(im) / 255;
%     catch
%         robotData(idx).f = [];
%         robotData(idx).d = [];
%         %continue;
%     end

    % Perform feature extraction
    fprintf('Extracting features from image... ');
    [robotData(idx).frames, robotData(idx).descriptors] = vl_sift(im, 'FirstOctave', 1, 'PeakThresh', 0.01);
    fprintf('Got %u features!\n', size(robotData(idx).frames, 2));
%end

   
   

   
   
