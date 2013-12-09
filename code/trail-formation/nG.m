% Copyright (c) 2013 Team Bambi
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

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
