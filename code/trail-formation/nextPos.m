function nPos = nextPos(A_pos, e, v, dt, h, w)
% NEXTPOS Sets the new position of agents depending on the direction they are
%         moving to, and the speed at which they are moving.

	dr   = v * e;
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
