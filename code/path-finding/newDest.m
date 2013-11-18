function nDest = newDest(A_pos, A_dest, dests)
% NEWDEST Selects new destination for an agent by proximity

	nDest = zeros(size(A_pos));

	% Loop per agent
	for i = 1:size(A_pos, 1)

		% Calculate distance between agent and its current destination
		dist_cur = norm(A_pos(i, :) - A_dest(i, :));

		% Loop through available destinations
		for d = 1:numel(dests)

			% Calculate distance from agent's pos to selected destination
			dist_new = norm(A_pos(i, :) - dests{d});

			% If distance to new destination is shorter
			if dist_new < dist_cur

				% Set agent destination as selected destination
				nDest(i, :) = dests{d};

				% Stop looking for new destinations
				break;
			end
		end
	end
end
