function create(pictureSource, typeOfStaircase, blockSize_signal, blockSize_noise, signalStaircase, noiseStaircase, OutputFolder)
    symbols=['a','b','c','d','e','f','g','h','i'];

    if contains(typeOfStaircase,'signal')
        imageSymbol=checkSymbol(strcat(OutputFolder,typeOfStaircase,'-staircase/','1/'),symbols);
        imageSymbol=symbols(imageSymbol);
        for i=1:length(signalStaircase)
            signal_precentage=signalStaircase(i);
            folder=strcat(OutputFolder,typeOfStaircase,'-staircase/', num2str(i));
            if ~exist(folder, 'dir')
                mkdir(folder);
            end
            for j=1:length(noiseStaircase)
                noise_precentage=noiseStaircase(j);
                output=strcat(folder,'/',num2str(j),imageSymbol,'.png');
                createPicture(pictureSource,signal_precentage,noise_precentage,blockSize_signal,blockSize_noise,output);
            end
        end
    elseif contains(typeOfStaircase,'noise')
        imageSymbol=checkSymbol(strcat(OutputFolder,typeOfStaircase,'-staircase/','1/'),symbols);
        imageSymbol=symbols(imageSymbol);
        for i=1:length(noiseStaircase)
            noise_precentage=noiseStaircase(i);
            folder=strcat(OutputFolder,typeOfStaircase,'-staircase/', num2str(i));
            if ~exist(folder, 'dir')
                mkdir(folder);
            end
            for j=1:length(signalStaircase)
                signal_precentage=signalStaircase(j);
                output=strcat(folder,'/',num2str(j),imageSymbol,'.png');
                createPicture(pictureSource,signal_precentage,noise_precentage,blockSize_signal,blockSize_noise,output);
            end
        end  
    end
end