%clear all;
clc;

% Trail formation parameters
Gzero = 10;   % Initial G (comfort of walking) value
Gmax  = 100;  % Maximum comfort of walking
I     = 10;   % Intensity parameter of trampling
T     = 200;  % Durability of trails
sigma = 2.0;  % Visibility function
v     = 1.0;  % Speed of agents

G     = imread('smallh1.png');
G     = ~G;
G     = G*Gmax;


h      = size(G,1); % Grid height
w      = size(G,2); % Grid width


% Possible destinations of agents
dests = {[53 10], [24 94], [10 58], [60 37], [57 31], [3 54]};

nagent = 7; % Number of bambis

N = 15; % Number of iterations

% Forest fire parameters
F = zeros(h,w);         % Setting fire matrix
timer = zeros(h,w);     % Setting countdown matrix for fire duration




% Path finding parameters


% Perform set of instructions
realassemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer,G);

