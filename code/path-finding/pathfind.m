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

function [G, A_pos, A_dest, A_running, e] = pathfind(G, F, Gmax, sigma, v, A_pos, A_dest, A_running, dests)
% PATHFIND Carries a step of path finding out by taking into account the spread
%          of fire and G (likability of area).

	% Set initial parameters
	dt = 1; % Time step

	h      = size(G, 1);
	w      = size(G, 2);
	nagent = size(A_pos, 1);

	% Matrix of sigma values, in matrix form. Can use a grid of variable
	% visibility in the future.
	sigma = sigma * ones(h,w);

	% Move agent
	V              = calcV(G, A_pos, sigma);
	FV             = calcFV(F, A_pos, sigma);
	[e, A_running] = calcDirection_Path(V, FV, A_pos, A_dest, A_running);
	A_pos          = nextPos_Path(G, Gmax, A_pos, e, v, dt, h, w);
	A_dest         = newDest_Path(A_pos, A_dest, dests); % Set nearest destination to be dest of agents
end
