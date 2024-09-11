function [trainsetImgs, trainsetLabels, testsetImgs, testsetLabels] = ...
            accessSudokuData(trainingFraction, includeExtra)
        
% Copyright 2018, The MathWorks, Inc.
    
    glob = loadGroundTruth('sudokuLabels.mat');
    rng(0);
    Images = glob.DataSource.Source;
    Labels = glob.LabelData.PixelLabelData;
    
    fileCnt = numel(Images);
    hashIx = randperm(fileCnt);
    Siz = round(trainingFraction * fileCnt);
    trainIx = hashIx(1:Siz);
    testIx = hashIx(Siz+1:end);
    
    if includeExtra
        glob = loadGroundTruth('extraLabels.mat');
        extraImg = glob.DataSource.Source;
        extraLabel = glob.LabelData.PixelLabelData;
        trainImages = [Images(trainIx); extraImg];
        trainLabels = [Labels(trainIx); extraLabel];
    else
        trainImages = Images(trainIx);
        trainLabels = Labels(trainIx);
    end
    
    trainsetImgs = imageDatastore(trainImages);
    trainsetLabels = pixelLabelDatastore(trainLabels, ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);
    testsetImgs = imageDatastore(Images(testIx));
    testsetLabels = pixelLabelDatastore(Labels(testIx), ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);

end

function ret = loadGroundTruth(labelFile)
    
    labelDir = fullfile(srcRoot(), 'data', 'labels');
    labelF = fullfile(labelDir, labelFile);
    data = load(labelF, 'gTruth');
    ret = data.gTruth;
    changeFilePaths(ret, ...
        ["C:\Users\jpinkney\MATLAB Drive Connector\deep-sudoku", fullfile(srcRoot(), "data")]);
    changeFilePaths(ret, ...
        ["raw_data", fullfile(srcRoot(), "data", "raw_data")]);

end