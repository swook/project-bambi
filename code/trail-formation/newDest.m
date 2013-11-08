function nDest = newDest(A_pos, A_dest, dests)
	nDest = A_dest;
	parfor i = 1:size(A_pos, 1)
		d = norm(A_pos(i, :) - A_dest(i, :));
		if d < 10;
			nDest(i, :) = pickNew(A_dest(i, :), dests);
		end
	end
end

function newD = pickNew(cur, dests)
	newD = dests{ceil(rand * numel(dests))};
	if newD(1) == cur(1) && newD(2) == cur(2)
		newD = pickNew(cur, dests);
	end
end
