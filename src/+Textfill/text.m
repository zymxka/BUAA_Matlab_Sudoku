function [fimg] = text(draft,siz)
%TEXT 此处显示有关此函数的摘要
%   此处显示详细说明
    
    x = (1:9) - 0.5;
    [x,y] = meshgrid(x,x);
    x = siz(1)./9 .* x(:);
    y = siz(2)./9 .* y(:);

    txt = cellstr(num2str(draft(:)));
    txt = replace(txt, '0', '');
    
    bw = zeros(siz);

    fimg = insertText(bw, [x,y], txt, ...
        "FontSize", ceil(0.4375*siz(1)./9), ...
        "TextColor", [86, 84, 255], ...
        "BoxOpacity", 0, ...
        "AnchorPoint","Center");
    
    fimg = im2bw(fimg);
    
end

