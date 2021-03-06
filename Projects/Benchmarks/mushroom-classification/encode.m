% encode.m
% Author: Sean Devonport
% A script that encodes mushroom data.
%%
function [p,t]=encode(file)
    Data   = fopen(file);
    D = textscan(Data,'%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c');

    P = [D{2} D{1} D{3} D{4} D{5} D{6} D{7} D{8} D{9} D{10} D{11} D{12} D{13} D{14} D{15} D{16} D{17} D{18} D{19} D{20} D{21} D{22} D{23}]';

    T = D{1}';

    pi = [];
    ti = [];
    
    % Encode data
    for i = 1:size(P,2)
        for j = 1:size(P,1)
            % Convert char to int
            pi(j,i) = double(P(j,i))-97; 
        end
        if T(i) == 'e'
            ti(i) = 1;
        else
            ti(i) = 0;
        end
    end

    p = [];
    t = [];

    % Remove incomplete data
    for i = 1:size(pi,2)
        j = find(pi(:,i)<0);
        if isempty(j)
            p = [p, pi(:,i)];
            t = [t, ti(:,i)];
        end
    end
end