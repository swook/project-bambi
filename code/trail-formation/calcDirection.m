function e = calcDirection (V, A_pos, A_dest)
h = size(V, 1);
w = size(V, 2);
n = size(V, 3);
e = zeros(n, 2);

parfor p = 1:n
	[dX, dY] = gradient(V(:, :, p));
	dV = dX + dY;

	x = A_pos(p, 1);
	y = A_pos(p, 2);
	numer = A_dest(p, :) - [x y] + dV(y, x);

	norm_numer = norm(numer);
	if norm_numer == 0.0
		e(p, :) = [0, 0];
	else
		e(p, :) = numer / norm(numer);
	end
end
