function symbol=checkSymbol(sourceFolder,symbols)
    for i=1:length(symbols)
        fileName=strcat(sourceFolder,'1',symbols(i),'.png')
        if ~exist(fileName, 'file')
            break;
        end
    end
    symbol=i;
end