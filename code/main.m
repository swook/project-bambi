clear all;
clc;

% Trail formation parameters
Gzero = 10;   % Initial G (comfort of walking) value
Gmax  = 60;   % Maximum comfort of walking
I     = 20;   % Intensity parameter of trampling
T     = 300;  % Durability of trails
sigma = 3;    % Visibility function
v     = 1.0;  % Speed of agents

h      = 100; % Grid height
w      = 100; % Grid width
nagent = 100; % Number of bambis

N = 400; % Number of iterations

% Forest fire parameters


% Path finding parameters


% Perform set of instructions
[G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, nagent, N);
