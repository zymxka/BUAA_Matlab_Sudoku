function [train, test] = accessNumberData(nSamples)
% 将图形文件转化为训练集
    numberData = fullfile(srcRoot, 'data', 'number_data');
    trainLocation = fullfile(numberData, 'train');
    testLocation = fullfile(numberData, 'test');
    
    if nSamples > 0 && ~isfolder(trainLocation)
        refreshData(trainLocation, nSamples);
    end
    if ~isfolder(testLocation)
        Numbers.extractNumberData(testLocation);
    end
    
    if nSamples > 0
        train = imageDatastore(trainLocation, 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
        
        samples = train.countEachLabel;
        if any(samples.Count < nSamples)
            refreshData(trainLocation, nSamples);
            train = imageDatastore(trainLocation, 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
        elseif any(samples.Count > nSamples)
            train = splitEachLabel(train, nSamples);
        end
    else
        train = [];
    end
    test = imageDatastore(testLocation, 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
end

function refreshData(trainLocation, nSamples)
    if isfolder(trainLocation)
        rmdir(trainLocation, 's');
    end
    Numbers.generateSyntheticNumberData(trainLocation, nSamples);
end
        

