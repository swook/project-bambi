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
