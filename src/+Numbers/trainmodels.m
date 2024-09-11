function net = trainmodels(outputName)

    if nargin < 1
        outputName = 'numberNet';
    end
    
    %% Parameters
    modelDirectory = fullfile(srcRoot(),'models');
    nSamples = 5000;
    
    %% Get the training data
    [train, test] = Numbers.accessNumberData(nSamples);
    
    augmenter = imageDataAugmenter( ...
        'RandXReflection',false, ...
        'RandYReflection',false);
    
    %% Set up the training options
    options = trainingOptions('sgdm', ...
                                'Plots', 'training-progress', ...
                                'L2Regularization', 1e-2, ...
                                'MaxEpochs', 8, ...
                                'Shuffle', 'every-epoch', ...
                                'InitialLearnRate', 0.01, ...
                                'LearnRateDropFactor', 0.1, ...
                                'LearnRateDropPeriod', 3, ...
                                'LearnRateSchedule', 'piecewise', ...
                                'ValidationData', test, ...
                                'ValidationPatience', Inf, ...
                                'MiniBatchSize', 64);
                            
    %% Setup the network
    layers = Numbers.resnet18Like();
    augtrain = augmentedImageDatastore(layers.Layers(1).InputSize, train, 'DataAugmentation',augmenter);
    
    %% Train
    net = trainNetwork(augtrain, layers, options);
    
    %% Save the output model
    if ~isfolder(modelDirectory)
        mkdir(modelDirectory);
    end
    outputFile = fullfile(modelDirectory, outputName);
    save(outputFile);
end