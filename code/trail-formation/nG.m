function [ nextG ] = nG( r,G,A_pos,Gzero,Gmax,I,T )
%dG time evolution of Ground 


nextG=Vregen( G,Gzero,T );


    for i=1:size(A_pos,1)
        if r==A_pos
           nextG=nextG+Itrample(G,Gmax,I);
        end
    end
end