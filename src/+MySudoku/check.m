function flag=check(matrix,row,col,answer)
    for i = 1 : 9%检查行
        if matrix(row,i) == answer
            flag = false;
            return;
        end
    end
    
    for i = 1 : 9%检查列
        if matrix(i,col) == answer
            flag = false;
            return;
        end
    end
    
    block_row = floor((row - 1) / 3) + 1;
    block_col = floor((col - 1) / 3) + 1;

    block_row_to = block_row * 3;
    block_row_from = block_row_to - 2;
    block_col_to = block_col * 3;
    block_col_from = block_col_to - 2;

    for i = block_row_from : block_row_to%检查3*3宫格
        for j = block_col_from : block_col_to
            if matrix(i,j) == answer
                flag = false;
                return;
            end
        end
    end
    
    flag=true;
    
end

