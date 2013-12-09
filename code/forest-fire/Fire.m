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

function [Fnew Gnew timer] = Fire(Fold, Gold, timer, Gmax)

	% Input Variables used in simulation
	h = size(Gold, 1);          % Height of grid
	w = size(Gold, 2);          % Width of grid
    tmax = 10;                  % Max Duration of Fire
    tmin = 1;                   % Min Duration of Fire
    probscale = 0.8;            % Fire Brutality (low values reduce the probability of any node catching on fire)
    Ginv = 1/Gmax;
    % max(max((ones(size(Gold)) - Gold*Ginv)))
    Start = 0.045*(ones(size(Gold)) - Gold*Ginv);   % Normalized vegetation matrix

    % Finding number of neighbours on fire
    x = Fold;
    x(x == -1) = 0;             % On fire or not
    k = [1 1 1; 1 0 1; 1 1 1];  % Convolution Kernel
    x = conv2(x,k,'same');      % Returns a matrix having the count of the neighbours on fire for each position

    % Define relative coordinates for 8 neighbours of a tree.
	neighbours = {[-1 -1] [-1 0] [-1 1] [0 1] [0 -1] [1 -1] [1 0] [1 1]};

    Fnew = Fold;
    Gnew = Gold;

    for i=1:h                   % Loop over rows
        for j=1:w               % Loop over columns

            if (Fold(i,j) == -1)
                continue;
            elseif (Fold(i,j) == 1)

                if timer(i,j) == 1
                    Fnew(i,j) = -1;
                    timer(i,j) = 0;
                else
                    timer(i,j) = timer(i,j)-1;
                end

                for n = 1:8         % Loop over neighbours
                        % Calculate new coordinates
                        nj = neighbours{n}(1) + j;
                        ni = neighbours{n}(2) + i;

                        % Correct new coordinates in case out of grid
                        if nj <= 0 || ni <= 0 || nj > w || ni > h
                            continue;
                        end

                        nof = x(ni,nj); % No. of neighbours on fire for ni,nj node

                        niter = 0;
                        while ((Fnew(ni,nj)~=1) && (niter <= nof))
                            niter=niter+1;
                            p = rand(1,1);
                            if (Fold(ni,nj) == -1)
                                continue;
                            elseif (p < probscale*Start(ni,nj))
                                Fnew(ni,nj) = 1;
                                timer(ni,nj) = 5; %floor(5*Start(ni,nj)/0.045)+1;
                            end
                        end
                end
            end
        end
    end









        % Neighbour scan and probablistically evolving the fire-front
        % Scan F matrix for those nodes on fire

