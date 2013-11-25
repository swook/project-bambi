function [newA_pos, newA_dest] = removeDeadBambis(F, A_pos, A_dest, h, w)
% REMOVEDEADBAMBIS Removes all dead or escaped agents from grid
	newA_pos   = [];
	newA_dest  = [];
	neighbours = {[1 0], [0 1], [-1 0], [0 -1]};

	nagent = size(A_pos, 1);
	nneigh = numel(neighbours);

	Nonfire = 0;
	for i = 1:nagent
		% If Bambi is at its destination or on a cell on fire
		if norm(A_pos(i, :) - A_dest(i, :)) < 3 || F(A_pos(i, 2), A_pos(i, 1)) > 0
			continue;
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
		end
	end
end
