% Main function
function basic
	% Clear all variables before starting
	clear all;
	clc;

	% Input Variables used in simulation
	h = 500;	% Height of grid
	w = 800;	% Width of grid
	p = 0.005;	% Probability of a tree growing in an empty slot

	% Generate initial forest
	[trees, onfire] = generateInitial(h, w);

	% Loop forever
	while 1
		% Process a step
		% - Pass in trees and onfire matrices (grids) as argument, and get
		%   updated ones back.
		[trees, onfire] = step(trees, onfire, h, w, p);
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
	ntrees = trees;
	nonfire = zeros(size(onfire));

	neighbours = {[-1 -1] [-1 0] [-1 1] [0 1] [0 -1] [1 -1] [1 0] [1 1]};
	for j = 1:h
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

				% Spread fire
				for n = 1:8
					nj = neighbours{n}(1) + j;
					ni = neighbours{n}(2) + i;
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
					if trees(nj, ni)
						nonfire(nj, ni) = 1;
					end
				end
			end
		end
	end
	imshow(cat(3, nonfire, ntrees, zeros(size(trees))));
	pause(0.001);
end
