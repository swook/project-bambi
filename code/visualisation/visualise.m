function I = visualise(Gmax, G, varargin)
% VISUALISE(Gmax, G, A, e, F) Visualises trail (G), fire (F), agents (A), and
%                             agents' direction (e). G and F are equal size
%                             grids, while agents is a Nx2 matrix where each row
%                             is position [x, y] of an agent.

	global Vis_Disabled
	if Vis_Disabled
		return;
	end

	% Get agents
	A = zeros();
	if nargin >= 3
		A = varargin{1};
	end

	% Get agent direction
	e = zeros(size(A));
	if nargin >= 4
		e = varargin{2};
	end

	% Get fire grid, F
	F = zeros(size(G));
	if nargin >= 5
		F = varargin{3};
	end

	draw(Gmax, G, A, e, F);

	% Show frame
	global Vis_Frame;
	imshow(Vis_Frame);

	% Pause momentarily
	pause(0.1);

	% Store frame into video file
	global Vis_WriteEnabled;
	if Vis_WriteEnabled
		global Vis_VObj;
		writeVideo(Vis_VObj, Vis_Frame);
	end
end
