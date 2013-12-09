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

clear all;
clc;

% Trail formation parameters
Gzero = 10;   % Initial G (comfort of walking) value
Gmax  = 100;  % Maximum comfort of walking
I     = 10;   % Intensity parameter of trampling
T     = 200;  % Durability of trails
sigma = 2.0;  % Visibility function
v     = 1.0;  % Speed of agents

h      = 50; % Grid height
w      = 50; % Grid width
nagent = 70; % Number of bambis

% Destinations of agents
dests = {[1, 1], [w, 1], [1, h], [w, h]};

% Number of iterations
N = 150;

% Forest fire parameters
F = zeros(h,w);         % Setting fire matrix
timer = zeros(h,w);     % Setting countdown matrix for fire duration

% Perform set of instructions
NoVideo = false;

% Run simulation
assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer,...
	struct('NoVideo', NoVideo), struct());
