function [field] = segmentation(img, nn)
%SEGMENTATION 此处显示有关此函数的摘要
%   此处显示详细说明

%     field = nnseg(img, nn);
    field = mainseg(img, nnseg(img, nn));

end

function mask = nnseg(img, nn)
    
    inSiz = nn.Layers(1).InputSize;
    outSiz = size(img);
    
    cont = semanticseg(imresize(img, inSiz(1:2)), nn);
    mask = imresize((cont == 'sudoku'), outSiz(1:2));
    
    
    erodeSize =  ceil(min(size(mask))/45);
    dilateSize = ceil(min(size(mask))/20);
    
    mask = imclearborder(mask);
    mask = imerode(mask, ones(erodeSize));
    mask = imdilate(mask, strel('disk', dilateSize));
    
end

function mask = mainseg(img, mask)
    
    bw = imbinarize(rgb2gray(img), 'adaptive', 'Sensitivity', 0.7);
    img = ~bw & mask;

    regions = sortrows(regionprops('table', img, ...
                            'FilledArea', 'Image',...
                            'FilledImage', 'BoundingBox'), 4);
    filledRegion = imerode(regions{end, 3}{1}, ones(3));
    boundingBox = regions{end, 1};
    
    mask = zeros(size(img));
    mask(ceil(boundingBox(2)):floor(boundingBox(2) + boundingBox(4)), ...
            ceil(boundingBox(1)):floor(boundingBox(1) + boundingBox(3)), ...
            :) = repmat(filledRegion, 1, 1);
%     imshow(mask), title('boundingbox')
end