function [ vreg ] = Vregen( G,Gzero,T )
%VREGEN yields the impact on G due to regeneration rate of vegetation

vreg = (Gzero - G)./T;

end

