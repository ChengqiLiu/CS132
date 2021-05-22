classdef ChessBoard < handle
    properties(Access = public)
        matrix
        Init_Chessboard
        Cao_row
        ZhangFei_row
        ZhaoYun_row
        HuangZhong_row
        MaChao_row
        GuanYu_row
        Soldier_1_row
        Soldier_2_row
        Soldier_3_row
        Soldier_4_row
        Cao_col
        ZhangFei_col
        ZhaoYun_col
        HuangZhong_col
        MaChao_col
        GuanYu_col
        Soldier_1_col
        Soldier_2_col
        Soldier_3_col
        Soldier_4_col
        
        mainMenu
        mainInterfaceUI
        selfUI
        WinUI
    end
    methods(Access = public)
        function is_dirD = downCheck(board,row,column)
            is_dirD = false;
            if row(end)+1 <= 5
                if board.matrix(row(end)+1,column) == zeros(1,length(column))
                    is_dirD = true;
                end 
            end
        end
        function is_dirU = upCheck(board,row,column)
            is_dirU = false;
            if row(1)-1 >= 1
                if board.matrix(row(1)-1,column) == zeros(1,length(column))
                    is_dirU = true;
                end 
            end
        end
        function is_dirL = leftCheck(board,row,column)
            is_dirL = false;
            if column(1)-1 >= 1
                if board.matrix(row,column(1)-1) == zeros(length(row),1)
                    is_dirL = true;
                end
            end
        end
        function is_dirR = rightCheck(board,row,column)
            is_dirR = false;
            if column(end)+1 <= 4
                if board.matrix(row,column(end)+1) == zeros(length(row),1)
                    is_dirR = true;
                end
            end
        end
        
        function downMove(board,row,column)
            board.matrix(row(1),column) = zeros(1,length(column));
            board.matrix(row + 1, column) = ones(length(row),length(column));
        end
        function upMove(board,row,column)
            board.matrix(row(end),column) = zeros(1,length(column));
            board.matrix(row - 1, column) = ones(length(row),length(column));
        end
        function leftMove(board,row,column)
            board.matrix(row,column(end)) = zeros(length(row),1);
            board.matrix(row,column - 1) = ones(length(row),length(column));
        end
        function rightMove(board,row,column)
            board.matrix(row,column(1)) = zeros(length(row),1);
            board.matrix(row,column + 1) = ones(length(row),length(column));
        end
        
        function InitAttributes(board,cb,Cao_r,Cao_c,ZF_r,ZF_c,ZY_r,ZY_c,HZ_r,HZ_c,MC_r,MC_c, ...
                GY_r,GY_c,S1_r,S1_c,S2_r,S2_c,S3_r,S3_c,S4_r,S4_c)
                board.matrix = cb;
                board.Init_Chessboard = cb;
                board.Cao_row = Cao_r;
                board.ZhangFei_row = ZF_r;
                board.ZhaoYun_row = ZY_r;
                board.HuangZhong_row = HZ_r;
                board.MaChao_row = MC_r;
                board.GuanYu_row = GY_r;
                board.Soldier_1_row = S1_r;
                board.Soldier_2_row = S2_r;
                board.Soldier_3_row = S3_r;
                board.Soldier_4_row = S4_r;
                board.Cao_col = Cao_c;
                board.ZhangFei_col = ZF_c;
                board.ZhaoYun_col = ZY_c;
                board.HuangZhong_col = HZ_c;
                board.MaChao_col = MC_c;
                board.GuanYu_col = GY_c;
                board.Soldier_1_col = S1_c;
                board.Soldier_2_col = S2_c;
                board.Soldier_3_col = S3_c;
                board.Soldier_4_col = S4_c;
        end
    end
    
end