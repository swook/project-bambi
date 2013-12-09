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
			% Upper X coordinate beyond width of grid
			dX = V(y, x) - V(y, x - 1);
		elseif x - 1 < 1
			% Lower X coordinate before start of grid
			dX = V(y, x + 1) - V(y, x);
		else
			% Normal case where not at grid edge
			dX = 0.5 * (V(y, x + 1) - V(y, x - 1));
		end

		if y + 1 > h
			% Upper Y coordinate beyond height of grid
			dY = V(y, x) - V(y - 1, x);
		elseif y - 1 < 1
			% Lower Y coordinate before start of grid
			dY = V(y + 1, x) - V(y, x);
		else
			% Normal case where not at grid edge
			dY = 0.5 * (V(y + 1, x) - V(y - 1, x));
		end

		dr      = dR(p, :);       % Vector from agent to destination
		glim    = 0.8 * norm(dr); % Limit gradient contribution to 80%
		                          % of dR contribution

		g      = [dX dY]; % Gradient vector
		g_norm = norm(g); % 2-Norm of gradient
		if g_norm > glim
			g = g / g_norm * glim; % Limit gradient to glim
		end

		numer = dR(p, :) + g; % Add contribution from dest and grad-V
		norm_numer = norm(numer);

		if norm_numer == 0.0 % If numerator 0, don't divide by 0, set to 0
			e(p, :) = [0, 0];
		else
			e(p, :) = numer / norm(numer);
		end
	end
end
