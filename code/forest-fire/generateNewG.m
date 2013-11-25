function [Gnew] = generateNewG(Fold, Gold, Gmax)

    Gnew = Gold;
    
    Gnew(Fold == 1) = -Gmax; % Putting negative values to nodes on fire
    
    Gnew(Fold == -1) = Gmax/2; % Setting average attractiveness to already burnt nodes
    
    return;
end