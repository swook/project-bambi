function nPos = nextPos(G, Gmax, A_pos, e, v, dt, h, w)
% NEXTPOS Sets the new position of agents depending on the direction they are
%         moving to, and the speed at which they are moving.

	vmin = 0.4 * v;
	vmax = 2.0 * v;

	vG = G ./ Gmax * (vmax - vmin) + vmin; % Get a grid of % of max G * velocity
	% vG(vG > vmax) = vmax * ones(size(vG(vG > vmax)));

	% Get indices of agents within G or vG matrix
	A_idx = sub2ind(size(G), A_pos(:, 2), A_pos(:, 1));
	A_v   = vG(A_idx);

	dr   = e .* cat(2, A_v, A_v);
	nPos = round(A_pos + dr * dt);

	% If new position is below 1, set to 1
	nPos(nPos <= 0) = 1;

	nagent = size(A_pos, 1);
	for p = 1:nagent
		% If new x-position is above width
		if nPos(p, 1) > w
			nPos(p, 1) = w;
		end

		% If new y-position is above height
		if nPos(p, 2) > h
			nPos(p, 2) = h;
		end
	end
end
