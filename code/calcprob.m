function [p] = calcprob(G,Gmax)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    sizeg = size(G);
    Ginv = 1/Gmax;
    Start = G*Ginv;
    Rmat = rand(sizeg);
    p = (Rmat > Start);
end

