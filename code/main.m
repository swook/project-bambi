%clear all;
clc;

% Trail formation parameters
Gzero = 10;   % Initial G (comfort of walking) value
Gmax  = 100;  % Maximum comfort of walking
I     = 10;   % Intensity parameter of trampling
T     = 200;  % Durability of trails
sigma = 2.0;  % Visibility function
v     = 1.0;  % Speed of agents

% Possible destinations of agents
dests = {[1 1], [80 1], [1 45], [80 45]};

h      = 45; % Grid height
w      = 80; % Grid width
nagent = 70; % Number of bambis

N = 150; % Number of iterations

% Forest fire parameters
F = zeros(h,w);         % Setting fire matrix
timer = zeros(h,w);     % Setting countdown matrix for fire duration




% Path finding parameters


% Perform set of instructions
assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer);

