%function TrailNoTrail()
% TRAILNOTRAIL compares the situation where a trail exists or not exists and sees
%              the effect this has on bambi survival rate while varying the parameters:
%              - N     (Number of iterations, corresponding to trail strength)
%              - sigma (Visibility or vision of agents)
%
%              The following parameters are kept constant
%              - Gzero, Gmax
%              - I, T
%              - v (mainly due to the fact that agents jump for v > ~1)
%              - dimension of grid
%              - initial position and destinations of agents
%              - destinations

	% Trail formation parameters
	Gzero = 10;   % Initial G (comfort of walking) value
	Gmax  = 100;  % Maximum comfort of walking
	I     = 10;   % Intensity parameter of trampling
	T     = 200;  % Durability of trails
	sigma = 2.0;  % Visibility function
	v     = 1.0;  % Speed of agents

	h      = 50; % Grid height
	w      = 50; % Grid width
	nagent = 100; % Number of bambis

	dests = {[1, 1], [w, 1], [1, h], [w, h]};

	N = 100; % Number of iterations

	% Forest fire parameters
	F = zeros(h,w);         % Setting fire matrix
	timer = zeros(h,w);     % Setting countdown matrix for fire duration

	% Generate an agent position/destination setup to use
	cd ../trail-formation
	[genA_pos, genA_dest] = PlaceAgents(h, w, nagent, dests);
	cd ../analysis

	% Set fire to middle-top pixels
	F(1, w/2 - 1:w/2 + 1) = 1;
	timer(1, w/2 - 1:w/2 + 1) = 5;

	% Some variables for use in plotting later on
	x      = [];
	y      = [];
	y_err  = [];
	trials = [];

	% Show bambi positions
	cd ../visualisation
	global Vis_WriteEnabled;
	Vis_WriteEnabled = false;
	visualise(Gmax, Gzero * ones(h, w), genA_pos, genA_dest - genA_pos);
	cd ../analysis

	% Start parallel pool as necessary
	if matlabpool('size') == 0
		matlabpool 'open'
	end

	cd ..
	for i = 1:20
		% Get trail formation output once
		stats = assemblyline(Gzero, Gmax, I, T, 0.1 * i, v, h, w, dests, nagent, N, F, timer,...
			struct('OnlyTrail', true, 'NoVis', true, 'NoVideo', true, 'NoFireInit', true),...
			struct('A_pos', genA_pos, 'A_dest', genA_dest));
		G = stats.G_postTrail;

		% Do fire + path finding only for trials
		parfor t = 1:8
			stats = assemblyline(Gzero, Gmax, I, T, 0.1 * i, v, h, w, dests, nagent, N, F, timer,...
				struct('NoTrail', true, 'NoVis', true, 'NoVideo', true, 'NoFireInit', true),...
				struct('A_pos', genA_pos, 'A_dest', genA_dest, 'G', G));
			trials = [trials stats.SurvivalRate];
		end
		x     = [x     i];
		y     = [y     mean(trials)];
		y_err = [y_err std(trials)];
	end

	plot(x, y);
	errorbar(x, y, y_err);
	xlabel 'Visibility of trails';
	ylabel 'Survival rate of agents';
	cd analysis

	saveas(gcf, 'TrailNoTrail_sigma.fig', 'fig');
	print('-depsc', 'TrailNoTrail_sigma.eps');
%end
