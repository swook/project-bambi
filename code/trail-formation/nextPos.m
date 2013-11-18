function nPos = nextPos(A_pos, e, v, dt, h, w)
% NEXTPOS Sets the new position of agents depending on the direction they are
%         moving to, and the speed at which they are moving.

	dr   = v * e;
	nPos = round(A_pos + dr * dt);

	% If new position is below 1, set to 1
	nPos(nPos <= 0) = 1;

	% If new x-position is below width
	nPos(nPos(:, 1) > w) = w;

	% If new y-position is below height
	nPos(nPos(:, 2) > h) = h;
end
