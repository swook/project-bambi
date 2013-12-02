clear all;
clc;

% Trail formation parameters
Gzero = 10;   % Initial G (comfort of walking) value
Gmax  = 100;  % Maximum comfort of walking
I     = 10;   % Intensity parameter of trampling
T     = 200;  % Durability of trails
sigma = 2.0;  % Visibility function
v     = 1.0;  % Speed of agents

h      = 45; % Grid height
w      = 80; % Grid width
nagent = 50; % Number of bambis

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
