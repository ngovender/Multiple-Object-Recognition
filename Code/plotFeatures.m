function[] = plotFeatures(features)

 path = 'D:\PhDWork\Datasets\Active Vision Database\vocabTree\';
    filename1 = strcat(path,'spice1_a.bmp');
    filename2 = strcat(path,'spice1_b.bmp');
    filename3 = strcat(path,'spice1_c.bmp');
    filename4 = strcat(path,'spice1_d.bmp');
    im = imread(filename1);
    figure;imshow(filename1);
    hold on;
    plot(features(145).frames(1,:),features(145).frames(2,:),'ro');
    
    figure;imshow(filename2);
    hold on;
    plot(features(146).frames(1,:),features(146).frames(2,:),'ro');
    
    figure;imshow(filename3);
    hold on;
    plot(features(147).frames(1,:),features(147).frames(2,:),'ro');
    
    figure;imshow(filename4);
    hold on;
    plot(features(148).frames(1,:),features(148).frames(2,:),'ro');