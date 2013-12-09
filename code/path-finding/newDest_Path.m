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

function newD = newDest_Path(A_pos, A_dest, dests)
% NEWDEST Selects new destination for an agent by proximity

	newD = zeros(size(A_pos));

	nagent = size(A_pos, 1);
	ndests = numel(dests);

	% Loop per agent
	for i = 1:nagent

		% Calculate distance between agent and its current destination
		dist_cur   = norm(A_pos(i, :) - A_dest(i, :));
		newD(i, :) = A_dest(i, :);

		% Loop through available destinations
		for d = 1:ndests

			% Calculate distance from agent's pos to selected destination
			dist_new = norm(A_pos(i, :) - dests{d});

			% If distance to new destination is shorter
			if dist_new < dist_cur

				% Set agent destination as selected destination
				newD(i, :) = dests{d};

				% Stop looking for new destinations
				break;
			end
		end
	end
end
