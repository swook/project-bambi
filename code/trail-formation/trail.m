% Copyright (c) 2013 Team Bambi
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

function [G, A_pos, A_dest] = trail(Gzero, Gmax, I, T, sigma, v, h, w, dests, nagent, N, extraparams)
% TRAIL Carries out trail formation

	% Set initial parameters
	dt = 1; % Time step

	% Create environmental grid (matrix) and agent (bambis) information
	G     = Gzero * ones(h,w);  % Environmental grid
	sigma = sigma * ones(h,w);  % Grid of visibility values

	%% Initial agents placement
	if isfield(extraparams, 'A_pos') && isfield(extraparams, 'A_dest')
		A_pos = extraparams.A_pos;
		A_dest = extraparams.A_dest;
	else
		[A_pos, A_dest] = PlaceAgents(h, w, nagent, dests);  % Agents (bambis) positions matrix (x,y)
	end
	A_dir = zeros(nagent,2);  % Agents (bambis) direction (x,y)

	%% Run simulation
	for i = 1:N
		% Calculate next values of G
		tic;
		G      = nG(G, A_pos, Gzero, Gmax, I, T, dt);
		V      = calcV(G, A_pos, sigma);
		e      = calcDirection(V, A_pos, A_dest);
		A_pos  = nextPos(A_pos, e, v, dt, h, w);
		A_dest = newDest_Trail(A_pos, A_dest, dests);

		if ~isfield(extraparams, 'NoVis') || ~extraparams.NoVis
			cd ../visualisation
			visualise(Gmax, G, A_pos, e);
			cd ../trail-formation
		end

		% A = zeros(size(G));
		% for p = 1:nagent
		% 	A(A_pos(p, 2), A_pos(p, 1)) = Gmax;
		% end

		% % Simple visualisation
		% H1 = surf(G);      % 3D contour plot of values
		% hold on;
		% H2 = surf(A);
		% hold off;

		% view(2);             % Set to bird's eye view
		% axis square;         % Set 1:1 grid cell size ratio
		% colormap(summer);    % Sets colour scale to go from green to yellow
		% colorbar;            % Shows the colour bar
		% caxis([Gzero Gmax]); % Sets axis limits of colour bar

		t = toc;
		disp(['TRAIL> Done with step ' num2str(i) ' after ' num2str(t * 1000, 3) ' ms.']);
		pause(1e-2);
    end
    %csvwrite('g',G);
end
