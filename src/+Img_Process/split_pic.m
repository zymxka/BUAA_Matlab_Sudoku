%返回分割之后的数字图像和识别出的数独的四个顶点
function [numbers, vetex, cube] = split_pic(ClassificationInputSize, im, mask)
    number_size = ClassificationInputSize(1);
    %获取mask的四个顶点
    vetex = Img_Process.get_vetex(mask);
    %按照数字图像的size将识别出来的数独矩阵分割
    [numbers, cube] = Img_Process.split_numbers(im, vetex, number_size);
%     vetexs = {vetex};
end