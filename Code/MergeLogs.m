function features = MergeLogs(imageData, robotData)
%MERGELOGS dataset = MergeLogs(imageData, robotData)
%   This function takes two sets of datalogs, the first pertaining to the
%   image list in the form 
%       [time imageId]
%   and the second pertaining to the robot odometry in the form
%       [time x y phi v omega]
%   and produces a structure that combines the two logs and interpolates
%   the odometry to get the robots position at the time the image was
%   taken.
%   The inputs to the function may be supplied by the text datalogs
%   produced by the MCamera and MAria modules.

% Extract robot time
robotTime = robotData(:, 1);
imageTime = imageData(:, 1);

% Interpolate robot odometry at image times
imageId = imageData(:, 2);
x = interp1(robotTime, robotData(:,2), imageTime);
y = interp1(robotTime, robotData(:,3), imageTime);
phi = interp1(robotTime, robotData(:,4), imageTime);
v = interp1(robotTime, robotData(:,5), imageTime);
omega = interp1(robotTime, robotData(:,6), imageTime);

features = struct([]);
for idx = 1:length(imageTime)
    features = [features; struct('time', (imageTime(idx) - imageTime(1)) / 1000, ...
        'fileName', sprintf('UNDIST_im%05u.jpg', imageId(idx)), ...
        'X', [x(idx); y(idx); phi(idx)], ...
        'V', [v(idx); omega(idx)])];
end
