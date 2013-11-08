function [ A_pos, A_dest ] = PlaceAgents( h,w,nagent, dests )
%
    A_pos = zeros(nagent, 2);
    A_dest = zeros(nagent, 2);

    for i = 1:nagent
        A_pos(i, 1) = ceil(rand * w);
        A_pos(i, 2) = ceil(rand * h);

        A_dest(i, :) = dests{ceil(rand * numel(dests))};
    end

end

