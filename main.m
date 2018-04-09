
%% select signal and noise staircases
signalStaircase=[30,50,75,90];
noiseStaircase=[7,12,16,23];

%% calling input 
answer=inputSettings();

%% creating picture
if ~isempty(answer)
    %% parse arguments
    [pictureSource, typeOfStaircase, blockSize_signal, blockSize_noise, OutputFolder]=parseArg(answer);

    %% creating images
    create(pictureSource, typeOfStaircase, blockSize_signal, blockSize_noise, signalStaircase, noiseStaircase, OutputFolder);
end
