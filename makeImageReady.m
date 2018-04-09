function [BW, height, width]=makeImageReady(picture)
    I = imread(picture);

    I = imresize(I, [300 300]); 

    I2 = rgb2gray(I);

    BW = ~imbinarize(I2);

    rndNum=randi(4);
    switch rndNum
        case 1
            x1=200;x2=200;x3=400;x4=400;
        case 2
            x1=200;x2=400;x3=400;x4=200;
        case 3
            x1=400;x2=200;x3=200;x4=400;
        case 4
            x1=400;x2=400;x3=200;x4=200;
    end

    BW = padarray(BW,[x1 x2],'replicate','pre');
    BW = padarray(BW,[x3 x4],'replicate','post');
    [height, width, ~] = size(BW);
end