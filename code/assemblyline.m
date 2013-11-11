function assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, nagent, N)
	% Perform trail formation
	cd 'trail-formation'
	[G, A_pos] = trail(Gzero, Gmax, I, T, sigma, v, h, w, nagent, N);
	cd ..

	% Loop for forest fire and path finding
	for i = 1:inf
		% Perform forest fire
		cd 'forest-fire'
		cd ..

		% Perform path finding
		cd 'path-finding'
		cd ..
	end
end
