function [ nextG ] = nG( r,G,A_pos,Gzero,Gmax,I,T,dt )
%dG time evolution of Ground 

dG=Vregen( G,Gzero,T );

    for i=1:size(A_pos,1)
        if r==A_pos
           dG=dG+Itrample(G,Gmax,I);
        end
    end
    
    nextG=G+dt*dG;
end