% Set initial parameters

Gzero = 1;    % Initial G (comfort of walking) value
Gmax  = 100;  % Maximum comfort of walking
I     = 30;   % Intensity parameter of trampling
T     = 400;  % Durability of trails
sigma = 20;   % Visibility function
v     = 1.0;  % Speed of agents

h      = 100;  % Grid height
w      = 100;  % Grid width
nagent = 200;  % Number of bambis

dt = 1; % Time step

% Create environmental grid (matrix) and agent (bambis) information
G     = Gzero * ones(h,w);  % Environmental grid
sigma = 1.0 * ones(h,w);    % Grid of visibility values

%% Initial agents placement
dests = {[1 1], [100 100], [100 1], [1 100]};
[A_pos, A_dest] = PlaceAgents(h, w, nagent, dests);  % Agents (bambis) positions matrix (x,y)
A_dir = zeros(nagent,2);  % Agents (bambis) direction (x,y)

%% Open Matlab pools for parallelisation
if matlabpool('size') == 0
	matlabpool('open');
end

%% Run simulation
for i = 1:1000
	disp(i)

	% Calculate next values of G
	G      = nG(G, A_pos, Gzero, Gmax, I, T, dt);
	V      = calcV(G, A_pos, sigma);
	e      = calcDirection(V, A_pos, A_dest);
	A_pos  = nextPos(A_pos, e, v, dt, max([h w]));
	A_dest = newDest(A_pos, A_dest, dests);

	A = zeros(size(G));
	for p = 1:nagent
		A(A_pos(p, 2), A_pos(p, 1)) = Gmax;
	end

	% Simple visualisation
	H1 = surf(G);      % 3D contour plot of values
	hold on;
	H2 = surf(A);
	hold off;

	view(2);             % Set to bird's eye view
	axis square;         % Set 1:1 grid cell size ratio
	colormap(summer);    % Sets colour scale to go from green to yellow
	colorbar;            % Shows the colour bar
	caxis([Gzero Gmax]); % Sets axis limits of colour bar

	pause(.01);
end
