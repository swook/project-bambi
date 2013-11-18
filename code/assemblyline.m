function [G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N)
% ASSEMBLYLINE Performs all calculations which are part of our model, namely:
%              1. Trail formation by agents on a grid of vegetation.
%              2. The spreading of a forest fire on the mentioned grid.
%              3. The path finding of an agent in the grid in the case of fire.

	% Perform trail formation
	cd 'trail-formation'
	[G, A_pos] = trail(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N);
	cd ..

	% Let's stop here for now
% 	return;

	% Loop for forest fire and path finding
	for i = 1:inf
		% Perform forest fire
		cd 'forest-fire'
%         spreadfire(G);
		cd ..

		% Perform path finding
		cd 'path-finding'
		[G, A_pos] = pathfind(G, F, sigma, v, A_pos, dests);
		cd ..

		% Remove the dead Bambis. We don't need them.
		[F, A_pos]= removeDeadBambis();

		% Check if we should stop. (Are all Bambis dead or at their destinations?)
		termCond = termCheck();
	end
end
