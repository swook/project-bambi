% Copyright (c) 2013 Team Bambi
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

%function TrailNoTrail_N()
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
	F(1:2, w/2 - 1:w/2 + 1) = 1;
	timer(1:2, w/2 - 1:w/2 + 1) = 5;

	% Some variables for use in plotting later oR
	x       = [];
	y       = [];
	y_err   = [];
	y_nb    = [];
	y_nberr = [];
	trials  = [];

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
		trials = [];
		stats = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, i * 10, F, timer,...
			struct('OnlyTrail', true, 'NoVis', true, 'NoVideo', true, 'NoFireInit', true),...
			struct('A_pos', genA_pos, 'A_dest', genA_dest));
		G = stats.G_postTrail;

		% Do fire + path finding only for trials
		parfor t = 1:8
			stats = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, i * 10, F, timer,...
				struct('NoTrail', true, 'NoVis', true, 'NoVideo', true, 'NoFireInit', true),...
				struct('A_pos', genA_pos, 'A_dest', genA_dest, 'G', G));
			trials = [trials stats.SurvivalRate];
		end

		x     = [x     i * 10];
		y     = [y     mean(trials)];
		y_err = [y_err std(trials)];

		% Do fire + path finding for trials without borders
		trials = [];
		parfor t = 1:8
			stats = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, i * 10, F, timer,...
				struct('NoTrail', true, 'NoVis', true, 'NoVideo', true, 'NoFireInit', true, 'NoBorder', true),...
				struct('A_pos', genA_pos, 'A_dest', genA_dest, 'G', G));
			trials = [trials stats.SurvivalRate];
		end

		y_nb = [y_nb mean(trials)];
		y_nberr = [y_nberr std(trials)];
	end
	cd analysis

	% Parameter name for file naming
	pn = 'N';
	xl = 'Number of steps taken in Trail Formation';

	% Plot closed border version
	plot(x, y);
	errorbar(x, y, y_err);
	xlabel(xl);
	ylabel 'Survival rate of agents';
	ylim([0 100]);
	saveas(gcf, ['output/TrailNoTrail_' pn '.fig'], 'fig');
	print('-depsc', ['output/TrailNoTrail_' pn '.eps']);
	print('-dpng', ['output/TrailNoTrail_' pn '.png']);

	% Plot open border version
	plot(x, y);
	errorbar(x, y_nb, y_nberr);
	xlabel(xl);
	ylabel 'Survival rate of agents';
	ylim([0 100]);
	saveas(gcf, ['output/TrailNoTrail_NoBord_' pn '.fig'], 'fig');
	print('-depsc', ['output/TrailNoTrail_NoBord_' pn '.eps']);
	print('-dpng', ['output/TrailNoTrail_NoBord_' pn '.png']);

%end
