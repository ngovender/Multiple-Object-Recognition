function[matchedRobustFeatures] = Features(data)

[r c] = size(data);
for j = 1:1%c % number of images in the database
    matchedRobustFeatures = robustMatch(data(1:j), j, 1)
end
