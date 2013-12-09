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

function FV = calcFV(F, A_pos, sigma)
% CALCFV Calculates the fire potential, represent the fire influence from
%        neighbouring cells. Loudness of fire alarm!

	F      = double(F > 0);  % Remove cells with "-1"
	h      = size(F, 1);     % Height of grid
	w      = size(F, 2);     % Width of grid
	n      = h * w;          % Number of grid cells
	nagent = size(A_pos, 1); % Number of agents

	% A matrix of FV, fire potential
	FV = zeros(h, w);

	neigh = [0 0; 0 1; 1 0; 0 -1; -1 0]; %; -1 -1; -1 1; 1 -1; 1 1];
	neighN = size(neigh, 1);

	% Per agent, calculate potential per position of itself and neighbours
	for p = 1:nagent
		for i = 1:neighN
			x = A_pos(p, 1) + neigh(i, 1);
			y = A_pos(p, 2) + neigh(i, 2);
			if x < 1 || y < 1 || x > w || y > h
				% Invalid coordinates, skip
				continue;
			end

			if FV(y, x) > 0
				% V has already been calculated here
				continue;
			end

			% Repeat position h*w (number of grid cells) times for
			% quicker Matlab operations
			r = repmat([x y], h*w, 1);

			% Create list of indices with x in col 1, y in col 2
			tmp = {};
			[tmp{1:2}] = ind2sub(size(F), 1:numel(F));
			ind = cat(1, tmp{2}, tmp{1}).';

			% Calculate distance between agent and all grid positions
			dr   = ind - r;
			dist = sqrt(sum(dr .^ 2, 2));
			dist = reshape(dist, h, w);

			% Calculate contribution of agent
			FVcontrib = exp(-dist ./ sigma(y, x)) .* F;

			% Increment V at agent's position by contribution
			FV(y, x) = sum(FVcontrib(:));
		end
	end
end
