clear all;
clc;

% Trail formation parameters
Gzero = 1;    % Initial G (comfort of walking) value
Gmax  = 80;   % Maximum comfort of walking
I     = 40;   % Intensity parameter of trampling
T     = 1000; % Durability of trails
sigma = 200;  % Visibility function
v     = 1.0;  % Speed of agents

h      = 100; % Grid height
w      = 100; % Grid width
nagent = 50;  % Number of bambis

N = 400; % Number of iterations

% Forest fire parameters


% Path finding parameters


% Perform set of instructions
assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, nagent, N);
