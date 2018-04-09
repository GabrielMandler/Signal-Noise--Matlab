function output=createPicture(picture,signalPrecentage,noisePrecentage)
clear;
clc;
rng('shuffle');

clc
rng('shuffle');



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
BWcopy=BW;

[height, width, ~] = size(BW);

signal=organizeMatrix(BW);

BW2=ones(height,width);
noise=organizeMatrix(BW2);
BW2=zeros(height,width);

signalNum = numel(signal);
noiseNum = height*width;

[rowsNoise,colsNoise]=ind2sub([height,width],noise);
[rowsSignal,colsSignal]=ind2sub([height,width],signal);

arrSignal=zeros(length(rowsSignal),2);
arrSignal(:,1)=rowsSignal;
arrSignal(:,2)=colsSignal;

signalPoints = round((signalNum*signalPrecentage)/100);
prevRndNum=zeros(signalNum,1);

while signalPoints > 0
        rowB=-1;
        colB=-1;
        %get a block from the signal
        while rowB<=0 || colB<=0
            randomIdx = randi(signalNum);
            blockHeight=0;
            while blockHeight<20
               blockHeight = randi(blockSizeSignal); 
            end
            blockWidth=0;
            while blockWidth<20
               blockWidth = randi(blockSizeSignal); 
            end
            row=rowsSignal(randomIdx);
            col=colsSignal(randomIdx);
            rowB=row-blockHeight;
            colB=col-blockWidth;
        end
       %delete the block
       for i=0:blockHeight
            for j=0:blockWidth
                if BW(rowB+i,colB+j)==1
                    if signalPoints<0
                        break;
                    end
                    signalPoints=signalPoints-1;
                    BW(rowB+i,colB+j)=0;
                end
            end
            if signalPoints<0
                break;
            end
       end
end

BWbeforeNoise=BW;

totalNoiseToAdd=round((noiseNum*noisePrecentage)/100);
noiseAdded =totalNoiseToAdd; 

blockSize=20;
[noiseAdded,BW]=insertNoise(BW,BWbeforeNoise,blockSize,noiseAdded,noiseNum,signalNum,rowsNoise,colsNoise,rowsSignal,colsSignal);

dots=1;
for i=1:length(arrSignal)
    x=arrSignal(i,1);
    y=arrSignal(i,2);
    if ~ismember([x y+dots],arrSignal, 'rows') && BW(x,y+dots)==1
        BW(x,y+dots)=0;
        noiseAdded=noiseAdded-1;
    end
    if ~ismember([x y-dots],arrSignal, 'rows') && BW(x,y+dots)==1
        BW(x,y-dots)=0;
        noiseAdded=noiseAdded-1;
    end
    if ~ismember([x+dots y],arrSignal, 'rows') && BW(x,y+dots)==1
        BW(x+dots,y)=0;
        noiseAdded=noiseAdded-1;
    end
    if ~ismember([x-dots y],arrSignal, 'rows') && BW(x,y+dots)==1
        BW(x-dots,y)=0;
        noiseAdded=noiseAdded-1;
    end
end

finalPrecentage=round( ((totalNoiseToAdd-noiseAdded)/noiseNum)*100)
imwrite(label2rgb(BW, gray, 'w'),'C:/Users/gabriel/Documents/MATLAB/topDown-Pictures/1/1.png');
end
%{

while 1
select=input('Choose one of the following options:\n 1. Random precentage\n 2. Custom precentage\nYour selection: ');
    if select==1 || select==2
        break
    end
end

if select==1
    signalPrecentage=rand*100; 
    noisePrecentage=rand*100;
    fprintf('Random signal: %0.1f\n Random noise: %0.1f\n',signalPrecentage,noisePrecentage)
elseif select==2
    signalPrecentage=input('Please insert the signal precentage to remove: ');
    noisePrecentage=input('Please insert the noise precentage to add: ');
end

imshow(label2rgb(BW, gray, 'w'))
imshowpair(~BWbeforeNoise, ~BW, 'montage')
%}

