classdef Parser < handle
    %PASSER sudokuPaser
    
    %   Loads Semantic Segmentation Network && Number Classify
    %   Network during Creation; 
    %   Run Parser.parse(img) to solve sodoku on img.
    
    properties
        SemanticNet
        SemSize
        NumberNet
        NumberSize
        matrix
        draft
    end
    
    properties(Constant = true)
        color = [0.75, 0.57, 0.90]
    end
    
    methods
        function obj = Parser()
            path = fullfile(srcRoot(), 'models', 'semanticNet.mat');
            if ~isfile(path)
                Semantics.trainmodels('semanticNet')
            end
            data = load(path, 'net');
            obj.SemanticNet = data.net;
            obj.SemSize = data.net.Layers(1).InputSize;
            
            path = fullfile(srcRoot(), 'models', 'numberNet.mat');
            if ~isfile(path)
                Numbers.trainmodels('numberNet')
            end
            data = load(path, 'net');
            obj.NumberNet = data.net;
            obj.NumberSize = data.net.Layers(1).InputSize;
            
        end
        
        function [result, fimg, gimg] = parse(obj,img)
           %% Recognize
            mask = Semantics.segmentation(img, obj.SemanticNet);
            [numberImages, vetex, cube] = Img_Process.split_pic(obj.NumberSize, img, mask);
            numbers = obj.NumberNet.classify(cat(4, numberImages{:}));

           %% Solve
            obj.matrix = double(reshape(numbers,9,9)) - 1;
            obj.draft = obj.matrix;
            obj.sudoku(1);
            result = obj.matrix;
           
           %% FillBack
            siz = size(cube);
            cube = imresize(cube, 4*siz(1:2));
            fimg = Textfill.text(obj.matrix - obj.draft, size(cube));
            gimg = Textfill.projection(fimg, vetex, size(img));
            fimg = imoverlay(cube, fimg, obj.color);
            gimg = imoverlay(img, gimg, obj.color);
        end
        
        function y = sudoku(obj, number)
            if(number>81)
                y = 1;
            else    
                raw = floor((number - 1) / 9) + 1;
                col = mod((number - 1),9) + 1;
                if(obj.matrix(raw,col)~=0)
                   y = obj.sudoku(number+1);
                else
                   for i = 1 : 9
                      if MySudoku.check(obj.matrix,raw,col,i)
                         obj.matrix(raw,col)=i;
                         if obj.sudoku(number+1)
                             y = 1;
                             return
                         end
                      end
                   end
                   obj.matrix(raw,col)=0;
                   y = 0;
                   return
                end    
            end
        end
        
    end
end

