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
nagent = 50; % Number of bambis

N = 150; % Number of iterations

% Forest fire parameters
F = zeros(h,w);         % Setting fire matrix
timer = zeros(h,w);     % Setting countdown matrix for fire duration


% Fire Initialization
flag =0;
while(flag == 0)
    randPos = floor(size(G,1)*rand(1,2));
    if (Gold(randPos(1), randPos(2)) < 0.25*Gmax)
        flag = 1;
        F(randPos(1), randPos(2)) = 1;
        timer(randPos(1), randPos(2)) = 5;
        
    end 
end



% Path finding parameters


% Perform set of instructions
[G, A_pos] = assemblyline(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, F, timer);

