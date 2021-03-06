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

function [newA_pos, newA_dest, newA_run, stats] = removeDeadBambis(F, A_pos, A_dest, A_running, h, w, flags, stats)
% REMOVEDEADBAMBIS Removes all dead or escaped agents from grid
	newA_pos   = [];
	newA_dest  = [];
	newA_run   = [];
	neighbours = {[1 0], [0 1], [-1 0], [0 -1]};

	nagent = size(A_pos, 1);
	nneigh = numel(neighbours);

	Nonfire = 0;
	for i = 1:nagent
		% If Bambi is at its destination
		if norm(A_pos(i, :) - A_dest(i, :)) < 5
			stats.Escaped = stats.Escaped + 1;
			continue;
		end
		% If Bambi is on a cell on fire
		if F(A_pos(i, 2), A_pos(i, 1)) > 0
			stats.Dead = stats.Dead + 1;
			continue;
		end
		% If no borders and bambis on border
		if isfield(flags, 'NoBorder') && flags.NoBorder
			if A_pos(i, 1) == 1 || A_pos(i, 1) == w || A_pos(i, 2) == 1 || A_pos(i, 2) == h
				stats.Escaped = stats.Escaped + 1;
				continue;
			end
		end

		Nonfire = 0; % Variable to count how many neighbours are on fire
		for j = 1:nneigh
			x = A_pos(i, 1) + neighbours{j}(1);
			y = A_pos(i, 2) + neighbours{j}(2);

			% If coordinates valid and cell on fire
			if x > 0 && x < w && y > 0 && y < h && F(y, x) > 0
				% Increment number of on fire neighbours
				Nonfire = Nonfire + 1;
			end
		end

		% If there are neighbours not on fire, place into new list of A
		if Nonfire < nneigh
			newA_pos  = [newA_pos; A_pos(i, :)];
			newA_dest = [newA_dest; A_dest(i, :)];
			newA_run  = [newA_run; A_running(i)];
		end
	end
end
