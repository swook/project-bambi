function nPos = nextPos(A_pos, e, v, dt, n)
	dr   = v * e;
	nPos = round(A_pos + dr * dt);
	for i = 1:numel(nPos)
		if nPos(i) <= 0
			nPos(i) = 1;
		elseif nPos(i) > n
			nPos(i) = n;
		end

	end
end
