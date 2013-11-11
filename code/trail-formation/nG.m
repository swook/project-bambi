function [ nextG ] = nG(G, A_pos, Gzero, Gmax, I, T, dt)
	% dG time evolution of Ground
	%  G is nxn matrix of G values

	% dG is nxn matrix
	dG = Vregen( G,Gzero,T );

	% Contribution from pedestrian trampling
	contribI = Itrample(G,Gmax,I);

	% Iterate over agents
	% - We can do this because agent only contributes to ground at its own position.
	for i = 1:size(A_pos, 1) % size(A_pos, 1) gives no. of rows of A_pos
		x = A_pos(i, 1);
		y = A_pos(i, 2);
		dG(y, x) = dG(y, x) + contribI(y, x);
	end

	nextG = G + dt*dG;
	nextG(nextG > Gmax) = Gmax;
end
