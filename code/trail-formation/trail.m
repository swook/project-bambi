function [G, A_pos] = trail(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N)
% TRAIL Carries out trail formation

	% Set initial parameters
	dt = 1; % Time step

	% Create environmental grid (matrix) and agent (bambis) information
	G     = Gzero * ones(h,w);  % Environmental grid
	sigma = sigma * ones(h,w);  % Grid of visibility values

	%% Initial agents placement
	[A_pos, A_dest] = PlaceAgents(h, w, nagent, dests);  % Agents (bambis) positions matrix (x,y)
	A_dir = zeros(nagent,2);  % Agents (bambis) direction (x,y)

	%% Run simulation
	for i = 1:N
		% Calculate next values of G
		tic;
		G      = nG(G, A_pos, Gzero, Gmax, I, T, dt);
		V      = calcV(G, A_pos, sigma);
		e      = calcDirection(V, A_pos, A_dest);
		A_pos  = nextPos(A_pos, e, v, dt, h, w);
		A_dest = newDest(A_pos, A_dest, dests);

		A = zeros(size(G));
		for p = 1:nagent
			A(A_pos(p, 2), A_pos(p, 1)) = Gmax;
		end

		% Simple visualisation
		H1 = surf(G);      % 3D contour plot of values
		hold on;
		H2 = surf(A);
		hold off;

		view(2);             % Set to bird's eye view
		axis square;         % Set 1:1 grid cell size ratio
		colormap(summer);    % Sets colour scale to go from green to yellow
		colorbar;            % Shows the colour bar
		caxis([Gzero Gmax]); % Sets axis limits of colour bar

		t = toc;
		disp(['Done with step ' num2str(i) ' after ' num2str(t * 1000, 3) ' ms.']);
		pause(1e-2);
    end
    csvwrite('g',G);
end
