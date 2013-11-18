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
dests = {[1 1], [50 50], [50 1], [1 50]};

h      = 50; % Grid height
w      = 50; % Grid width
nagent = 50;  % Number of bambis

N = 10000; % Number of iterations

% Forest fire parameters

% Fire Initialization
Fi = zeros(h,w);
origin = [50 50];   % Coordinates of the starting point of the fire
Fi(origin) = 1;     % Setting that point on fire

% Path finding parameters


% Perform set of instructions
[G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, nagent, N);
