function [G, A_pos] = pathfind(G, A_pos, v, dests)
	% Set initial parameters
	dt = 1; % Time step

	h = size(G, 1);
	w = size(G, 2);

	A_dest = zeros(size(A_pos));
	% newDest(); % Set destination of agent

	% Move agent
	V      = calcV(G, A_pos, sigma);
	e      = calcDirection(V, A_pos, A_dest);
	A_pos  = nextPos(A_pos, e, v, dt, h, w);
	A_dest = newDest(A_pos, A_dest, dests);
end
