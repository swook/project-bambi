function V = calcV(G, A_pos, sigma)
h = size(G, 1);
w = size(G, 2);
N = size(A_pos, 1);

% 3D matrix where 3rd dimension is per agent
V = zeros(h, w, N);

% Per agent, calculate potential per position
for p = 1:size(A_pos, 1)
	r_a = A_pos(p, :);
	for j = 1:size(G, 1)
		for i = 1:size(G, 2)
			V(j, i, p) = V(j, i, p) + exp(-norm([i j] - r_a) / sigma(j,  i)) * G(j, i);
		end
	end
end
end
