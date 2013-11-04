function [ itr ] = Itrample( G,Gmax,I )
%ITRAMPLE returns the "trampling" intensity of bambis

itr = I*( 1 - G/Gmax);


end

