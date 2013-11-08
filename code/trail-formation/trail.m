% Set initial parameters

Gzero = 1;    % Initial G (comfort of walking) value
Gmax  = 10;   % Maximum comfort of walking
I     = 5;    % Intensity parameter of trampling
T     = 1;    % Durability of trails
sigma = 10;  %  Visibility function

h      = 100;  % Grid height
w      = 100;  % Grid width
nagent = 100;  % Number of bambis

dt = 0.1; % Time step

% Create environmental grid (matrix) and agent (bambis) information
G     = Gzero * ones(h,w);  % Environmental grid
sigma = 1.0 * ones(h,w);    % Grid of visibility values

%% Initial agents placement
dests = {[1 1], [100 100], [100 1], [1 100]};
[A_pos, A_dest] = PlaceAgents(h, w, nagent, dests);  % Agents (bambis) positions matrix (x,y)
A_dir = zeros(nagent,2);  % Agents (bambis) direction (x,y)

%% Run simulation
for i = 1:1000
	disp(i)

	% Calculate next values of G
	G = nG(G, A_pos, Gzero, Gmax, I, T, dt);
	V = calcV(G, A_pos, sigma);

	% Simple visualisation
	surf(V(:,:,1));             % 3D contour plot of values
	view(2);             % Set to bird's eye view
	colormap(summer);    % Sets colour scale to go from green to yellow
	colorbar;            % Shows the colour bar
	% caxis([Gzero Gmax]); % Sets axis limits of colour bar

	pause(.1);
end
