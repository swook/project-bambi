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

function I = visualise(Gmax, G, varargin)
% VISUALISE(Gmax, G, A, e, F) Visualises trail (G), fire (F), agents (A), and
%                             agents' direction (e). G and F are equal size
%                             grids, while agents is a Nx2 matrix where each row
%                             is position [x, y] of an agent.

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
