function I = visualise(Gmax, G, varargin)
% VISUALISE(Gmax, G, A, F) Visualises trail (G), fire (F), and agents (A).
%                          G and F are equal size grids, while agents is a Nx2 matrix
%                          where each row is position [x, y] of an agent.

	% Get agents
	A = zeros();
	if nargin >= 3
		A = varargin{1};
	end

	% Get fire grid, F
	F = zeros(size(G));
	if nargin >= 4
		F = varargin{2};
	end

	draw(Gmax, G, A, F);

	global Vis_Frame;
	imshow(Vis_Frame);
end
