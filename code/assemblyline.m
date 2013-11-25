function [G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer)
% ASSEMBLYLINE Performs all calculations which are part of our model, namely:
%              1. Trail formation by agents on a grid of vegetation.
%              2. The spreading of a forest fire on the mentioned grid.
%              3. The path finding of an agent in the grid in the case of fire.

	% Perform trail formation
	cd 'trail-formation'
	[G, A_pos] = trail(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N);
	cd ..

	% Loop for forest fire and path finding
	for i = 1:inf
		% Perform forest fire
		cd 'forest-fire'
	        [F G timer] = Fire(F, G, timer, Gmax);
		cd ..

		% Perform path finding
		cd 'path-finding'
		[G, A_pos, A_dest, e] = pathfind(G, F, sigma, v, A_pos, dests);
		cd ..

		% Remove the dead Bambis. We don't need them.
		A_pos = removeDeadBambis(F, A_pos, A_dest, h, w);

		% Visualise this situation
		cd 'visualisation'
		visualise(Gmax, G, A_pos, e, F);
		cd ..

		% Pause momentarily
		pause(0.1);

		% Check if we should stop. (Are all Bambis dead or at their destinations?)
		if size(A_pos, 1) < 1
			break
		end
	end
end
