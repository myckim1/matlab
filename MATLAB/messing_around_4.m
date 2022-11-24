clear, clc

function [V S] = get_V_S(R,r)
    V = ((pi^2)/4)*(R+r)*(R-r)^2;
    S = (pi^2)*(R+r)*(R-r);
end