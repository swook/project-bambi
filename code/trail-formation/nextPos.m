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

function nPos = nextPos(A_pos, e, v, dt, h, w)
% NEXTPOS Sets the new position of agents depending on the direction they are
%         moving to, and the speed at which they are moving.

	dr   = v * e;
	nPos = round(A_pos + dr * dt);

	% If new position is below 1, set to 1
	nPos(nPos <= 0) = 1;

	nagent = size(A_pos, 1);
	for p = 1:nagent
		% If new x-position is above width
		if nPos(p, 1) > w
			nPos(p, 1) = w;
		end

		% If new y-position is above height
		if nPos(p, 2) > h
			nPos(p, 2) = h;
		end
	end
end
