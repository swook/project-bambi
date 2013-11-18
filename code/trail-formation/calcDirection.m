function e = calcDirection (V, A_pos, A_dest)
% CALCDIRECTION Calculates the direction an agent should move in this time step

	h = size(V, 1);     % Height of grid
	w = size(V, 2);     % Width of grid
	n = size(A_pos, 1); % Number of agents
	e = zeros(n, 2);    % New list of direction coordinates for agents

	% Calculate gradient of V
	[dX, dY] = gradient(V);

	% Calculate vector from agent to destination
	dR = A_dest - A_pos;

	% For each agent
	for p = 1:n
		% Get position coordinates of agent
		x = A_pos(p, 1);
		y = A_pos(p, 2);
		numer = dR(p, :) + [dX(y, x) dY(y, x)];

		norm_numer = norm(numer);
		if norm_numer == 0.0
			e(p, :) = [0, 0];
		else
			e(p, :) = numer / norm(numer);
		end
	end
end
