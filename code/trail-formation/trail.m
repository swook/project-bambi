% Set initial parameters

Gzero = 1;  % Initial G (comfort of walking) value
Gmax = 10;  % Maximum comfort of walking
I = 1;  % Intensity parameter of trampling
T = 2;  % Durability of trails
sigma = 0.5;  %  Visibility function

h = 100;  % Grid height
w = 100;  % Grid width
nagent = 7;  % Number of bambis

dt=1;   %time step

% Create environmental grid (matrix) and agent (bambis) information

GridG = zeros(h,w);  % Environmental grid

dests = {[1 1], [100 100], [100 1], [1 100]};
[A_pos, A_dest] = PlaceAgents(h, w, nagent, dests)  % Agents (bambis) positions matrix (x,y)
A_dir = zeros(nagent,2);  % Agents (bambis) direction (x,y)

