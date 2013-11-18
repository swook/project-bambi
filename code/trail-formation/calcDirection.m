function e = calcDirection (V, A_pos, A_dest)
% CALCDIRECTION Calculates the direction an agent should move in this time step

	h = size(V, 1);     % Height of grid
	w = size(V, 2);     % Width of grid
	n = size(A_pos, 1); % Number of agents
	e = zeros(n, 2);    % New list of direction coordinates for agents

	% Calculate gradient of V
	% [dX, dY] = gradient(V);

	% Calculate vector from agent to destination
	dR = A_dest - A_pos;

	% For each agent
	for p = 1:n
		% Get position coordinates of agent
		x = A_pos(p, 1);
		y = A_pos(p, 2);

		if x + 1 > w
			dX = V(y, x) - V(y, x - 1);
		elseif x - 1 < 1
			dX = V(y, x + 1) - V(y, x);
		else
			dX = 0.5 * (V(y, x + 1) - V(y, x - 1));
		end

		if y + 1 > h
			dY = V(y, x) - V(y - 1, x);
		elseif y - 1 < 1
			dY = V(y + 1, x) - V(y, x);
		else
			dY = 0.5 * (V(y + 1, x) - V(y - 1, x));
		end

		dr      = dR(p, :);
		glim    = 0.8 * norm(dr);

		g      = [dX dY];
		g_norm = norm(g);
		if g_norm > glim
			g = g / g_norm * glim;
		end

		numer = dR(p, :) + g;
		norm_numer = norm(numer);
		if norm_numer == 0.0
			e(p, :) = [0, 0];
		else
			e(p, :) = numer / norm(numer);
		end
	end
end
