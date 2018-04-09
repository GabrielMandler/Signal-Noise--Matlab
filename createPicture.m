function finalPrecentage=createPicture(picture,signalPrecentage,noisePrecentage,blockSize_signal,blockSize_noise,output)
    rng('shuffle');
    %% make Image Ready
    [BW, height, width]=makeImageReady(picture);
    %% organizeMatrices
    signal=organizeMatrix(BW);

    BW2=ones(height,width);
    noise=organizeMatrix(BW2);

    signalNum = numel(signal);
    noiseNum = height*width;

    [rowsNoise,colsNoise]=ind2sub([height,width],noise);
    [rowsSignal,colsSignal]=ind2sub([height,width],signal);
   

    arrSignal=zeros(length(rowsSignal),2);
    arrSignal(:,1)=rowsSignal;
    arrSignal(:,2)=colsSignal;

    signalPoints = round((signalNum*signalPrecentage)/100);
    
    %% remove Signal
    BW=removeSignal(BW,signalPoints,signalNum,blockSize_signal,rowsSignal,colsSignal);
 
    BWbeforeNoise=BW;

    totalNoiseToAdd=round((noiseNum*noisePrecentage)/100);
    noiseAdded =totalNoiseToAdd; 
    %% insert Noise
    [noiseAdded,BW]=insertNoise(BW,BWbeforeNoise,blockSize_noise,noiseAdded,noiseNum,signalNum,rowsNoise,colsNoise,rowsSignal,colsSignal);
    
    %% insert Noise
    dots=3;
    BW=fixEdges(BW,dots,arrSignal,noiseAdded);
    
    finalPrecentage=round( ((totalNoiseToAdd-noiseAdded)/noiseNum)*100);
    %% save image 
    imwrite(label2rgb(BW, gray, 'w'),output,'WriteMode','append');

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
end
