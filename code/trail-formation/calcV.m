function V = calcV(G, A_pos, sigma)
h = size(G, 1);
w = size(G, 2);
N = size(A_pos, 1);

% 3D matrix where 3rd dimension is per agent
V = zeros(h, w, N);

% Per agent, calculate potential per position
parfor p = 1:size(A_pos, 1)
	r_a = A_pos(p, :);

	%% More direct method, but slow
	% for j = 1:size(G, 1)
	% 	for i = 1:size(G, 2)
	% 		V(j, i, p) = V(j, i, p) + exp(-norm([i j] - r_a) / sigma(j,  i)) * G(j, i);
	% 	end
	% end

	r_a = repmat(r_a, h*w, 1);

	% Create list of indices with x in col 1, y in col 2
	tmp = {};
	[tmp{1:2}] = ind2sub(size(G), 1:numel(G));
	ind = cat(1, tmp{2}, tmp{1}).';

	dr = ind - r_a;
	V(:, :, p) = V(:, :, p) + reshape(-sqrt(sum(dr .^ 2, 2)), h, w) ./ sigma .* G;
end
end
