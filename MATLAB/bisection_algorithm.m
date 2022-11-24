%Solve using the bisection method
% First choose arbitrary numbers --> see if they're
%Solving cos(x) = x
clear
clc

lower_guess = 0.5*rand();
upper_guess = 0.5*(1+rand());

while cos(upper_guess)-upper_guess>0
    upper_guess = 0.5*(1+rand());
end

guess = (lower_guess+upper_guess)/2;
err = get_err(guess);
counter = 0;

while abs(err) > 0.00001
    err=get_err(guess);
    counter = counter + 1;
    if err > 0
        lower_guess = guess;
        guess = (guess+upper_guess)/2;
    elseif err<0
        upper_guess = guess;
        guess = (lower_guess+guess)/2;
    end
end
fprintf('The final solution is %u, in %u iterations',guess,counter)
function err = get_err(x)
    err = (cos(x) - x);
end
