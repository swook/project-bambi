function [Fnew Gnew] = FireUpdate(Fold, Gold, Gmax)

	% Input Variables used in simulation
	h = size(Gold, 1);          % Height of grid
	w = size(Gold, 2);          % Width of grid
    tmax = 10;                  % Max Duration of Fire
    tmin = 1;                   % Min Duration of Fire
    
    P = calcprob(Gold, Gmax);   % Gets a martix P that determines if the node will catch fire or not based on vegetation intensity
    
    % Neighbour scan and probablistically evolving the fire-front
    
    