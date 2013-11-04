% Main function
function basic
	% Clear all variables before starting
	clear all;
	clc;

	% Input Variables used in simulation
	h = 500;	% Height of grid
	w = 800;	% Width of grid
	p = 0.005;	% Probability of a tree growing in an empty slot

	% Generate initial forest and grid with on-fire trees marked
	[trees, onfire] = generateInitial(h, w);

	% Loop forever
	while 1
		% Process a step
		% - Pass in trees and onfire matrices (grids) as argument, and get
		%   updated ones back.
		[trees, onfire] = step(trees, onfire, h, w, p);

		% Pause to allow Matlab to show visualisation
		pause(0.01);
	end
end

% Creates a grid of trees to start from and sets a few on fire.
function [trees, onfire] = generateInitial(h, w)
	% Load in files
	trees = rgb2gray(imread('trees.png')) > 1;
	onfire = rgb2gray(imread('onfire.png')) > 1;
end

% Processes the forest fire by one step
function [ntrees, nonfire] = step(trees, onfire, h, w, p)
	% Copy trees and onfire to work on and return to main function.
	ntrees = trees;
	nonfire = onfire;

	% Define relative coordinates for 8 neighbours of a tree.
	neighbours = {[-1 -1] [-1 0] [-1 1] [0 1] [0 -1] [1 -1] [1 0] [1 1]};

	% Iterate over rows
	for j = 1:h
		% Iterate over columns
		for i = 1:w

			% Grow tree.
			if ~trees(j, i) && rand < p
				ntrees(j, i) = 1;
			end

			% If tree is on fire.
			if onfire(j, i)
				% Burn down tree on fire from previous turn.
				ntrees(j, i) = 0;
				nonfire(j, i) = 0;

				% Spread fire to neighbour trees
				for n = 1:8
					% Calculate new coordinates
					nj = neighbours{n}(1) + j;
					ni = neighbours{n}(2) + i;

					% Correct new coordinates in case out of grid
					if nj <= 0
						nj = nj + h;
					end
					if ni <= 0
						ni = ni + w;
					end
					if nj > h
						nj = nj - h;
					end
					if ni > w
						ni = ni - w;
					end

					% If tree exists, set on fire
					if trees(nj, ni)
						nonfire(nj, ni) = 1;
					end
				end
			end
		end
	end

	% Cheat for visualisation, put onfire matrix as R, trees matrix as G,
	% and 0 as B. This shows red for fire, green for trees, and black for
	% neither.
	imshow(cat(3, nonfire, ntrees, zeros(size(trees))));
end
