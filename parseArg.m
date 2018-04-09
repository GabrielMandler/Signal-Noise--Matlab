function [pictureSource, typeOfStaircase, blockSize_signal, blockSize_noise, OutputFolder]=parseArg(answer)
    pictureSource=strcat('pictures/',answer{1});
    typeOfStaircase=lower(answer{2});
    blockSize_signal=str2double(answer{3});
    blockSize_noise=str2double(answer{4});
    OutputFolder=answer{5};
end