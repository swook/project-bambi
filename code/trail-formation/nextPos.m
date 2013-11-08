function nPos = nextPos(A_pos, e, v, dt, n)
	dr   = v * e;
	nPos = round(A_pos + dr * dt);

	nPos(nPos <= 0) = 1;
	nPos(nPos > n) = n;
end
