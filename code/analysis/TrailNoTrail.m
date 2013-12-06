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
	nagent = 50; % Number of bambis

	dests = {[1, 1], [w, 1], [1, h], [w, h]};

	N = 10; % Number of iterations

	% Forest fire parameters
	F = zeros(h,w);         % Setting fire matrix
	timer = zeros(h,w);     % Setting countdown matrix for fire duration

	% Generate an agent position/destination setup to use
	cd ../trail-formation
	[genA_pos, genA_dest] = PlaceAgents(h, w, nagent, dests);
	cd ../analysis

	% Set fire to middle-top pixels
	F(1:2, 24:26) = 1;

	% Perform set of instructions
	global Vis_Disabled;
	Vis_Disabled = false;
	NoVideo   = true;
	cd ..

	for i = 1:15
		stats = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, i * 20, F, timer,...
			struct('NoVideo', NoVideo, 'NoFireInit', 1),...
			struct('A_pos', genA_pos, 'A_dest', genA_dest));
	end

	cd analysis
	Vis_Disabled = false;
%end
