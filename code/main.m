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
F = zeros(h,w);      % Setting fire matrix
timer = zeros(h,w);     % Setting countdown matrix for fire duration


% Fire Initialization
F(h/2,w/2) = 1;     % Setting that point on fire
timer(h/2,w/2) = 5;


% Path finding parameters


% Perform set of instructions
[G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer);

