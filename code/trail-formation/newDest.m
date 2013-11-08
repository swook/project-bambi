function nDest = newDest(A_pos, A_dest, dests)
nDest = A_dest;
for i = 1:size(A_pos, 1)
	d = norm(A_pos(i, :) - A_dest(i, :));
	if d < 5;
		nDest(i, :) = dests{ceil(rand * numel(dests))};
	end
end
end
