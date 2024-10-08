function lgraph = resnet18Like()
    %% 创建层次图
    lgraph = layerGraph();
    
    %% 添加层分支
    tempLayers = [
        imageInputLayer([64 64 3],"Name","data","Normalization","zscore")
        convolution2dLayer([7 7],64,"Name","conv1","BiasLearnRateFactor",0,"Padding",[3 3 3 3],"Stride",[2 2])
        batchNormalizationLayer("Name","bn_conv1")
        reluLayer("Name","conv1_relu")
        maxPooling2dLayer([3 3],"Name","pool1","Padding",[1 1 1 1],"Stride",[2 2])];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],64,"Name","res2a_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn2a_branch2a")
        reluLayer("Name","res2a_branch2a_relu")
        convolution2dLayer([3 3],64,"Name","res2a_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn2a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res2a")
        reluLayer("Name","res2a_relu")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],64,"Name","res2b_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn2b_branch2a")
        reluLayer("Name","res2b_branch2a_relu")
        convolution2dLayer([3 3],64,"Name","res2b_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn2b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res2b")
        reluLayer("Name","res2b_relu")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([1 1],128,"Name","res3a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch1")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],128,"Name","res3a_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1],"Stride",[2 2])
        batchNormalizationLayer("Name","bn3a_branch2a")
        reluLayer("Name","res3a_branch2a_relu")
        convolution2dLayer([3 3],128,"Name","res3a_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn3a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res3a")
        reluLayer("Name","res3a_relu")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],128,"Name","res3b_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn3b_branch2a")
        reluLayer("Name","res3b_branch2a_relu")
        convolution2dLayer([3 3],128,"Name","res3b_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn3b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res3b")
        reluLayer("Name","res3b_relu")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([1 1],256,"Name","res4a_branch1","BiasLearnRateFactor",0,"Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch1")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],256,"Name","res4a_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1],"Stride",[2 2])
        batchNormalizationLayer("Name","bn4a_branch2a")
        reluLayer("Name","res4a_branch2a_relu")
        convolution2dLayer([3 3],256,"Name","res4a_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn4a_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res4a")
        reluLayer("Name","res4a_relu")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        convolution2dLayer([3 3],256,"Name","res4b_branch2a","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn4b_branch2a")
        reluLayer("Name","res4b_branch2a_relu")
        convolution2dLayer([3 3],256,"Name","res4b_branch2b","BiasLearnRateFactor",0,"Padding",[1 1 1 1])
        batchNormalizationLayer("Name","bn4b_branch2b")];
    lgraph = addLayers(lgraph,tempLayers);

    tempLayers = [
        additionLayer(2,"Name","res4b")
        reluLayer("Name","res4b_relu")
        globalAveragePooling2dLayer("Name","pool5")
        fullyConnectedLayer(10,"Name","fc10")
        softmaxLayer("Name","prob")
        classificationLayer("Name","ClassificationLayer_predictions")];
    lgraph = addLayers(lgraph,tempLayers);

    % 清理辅助变量
    clear tempLayers;
    
    %% 连接层分支
    lgraph = connectLayers(lgraph,"pool1","res2a_branch2a");
    lgraph = connectLayers(lgraph,"pool1","res2a/in2");
    lgraph = connectLayers(lgraph,"bn2a_branch2b","res2a/in1");
    lgraph = connectLayers(lgraph,"res2a_relu","res2b_branch2a");
    lgraph = connectLayers(lgraph,"res2a_relu","res2b/in2");
    lgraph = connectLayers(lgraph,"bn2b_branch2b","res2b/in1");
    lgraph = connectLayers(lgraph,"res2b_relu","res3a_branch1");
    lgraph = connectLayers(lgraph,"res2b_relu","res3a_branch2a");
    lgraph = connectLayers(lgraph,"bn3a_branch1","res3a/in2");
    lgraph = connectLayers(lgraph,"bn3a_branch2b","res3a/in1");
    lgraph = connectLayers(lgraph,"res3a_relu","res3b_branch2a");
    lgraph = connectLayers(lgraph,"res3a_relu","res3b/in2");
    lgraph = connectLayers(lgraph,"bn3b_branch2b","res3b/in1");
    lgraph = connectLayers(lgraph,"res3b_relu","res4a_branch1");
    lgraph = connectLayers(lgraph,"res3b_relu","res4a_branch2a");
    lgraph = connectLayers(lgraph,"bn4a_branch1","res4a/in2");
    lgraph = connectLayers(lgraph,"bn4a_branch2b","res4a/in1");
    lgraph = connectLayers(lgraph,"res4a_relu","res4b_branch2a");
    lgraph = connectLayers(lgraph,"res4a_relu","res4b/in2");
    lgraph = connectLayers(lgraph,"bn4b_branch2b","res4b/in1");

    
end