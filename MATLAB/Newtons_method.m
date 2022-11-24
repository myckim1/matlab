clc
clear

x = 0:0.05:10;
c = @(t) 3*exp(-2*t)+2*exp(-3*t) -2;
tol = 0.00001;

%Estimate solution using bisection
counter_bisection = 0;
x1 = 0; %lower bound
x2 = 5; %Upper bound
guess = (x1+x2)/2;
while abs(c(guess)) > tol
    counter_bisection = counter_bisection+1;
    err = c(guess);
    if err < 0
        x2 = guess;
    else
        x1 = guess;
    end
    guess = (x1+x2)/2;
end
fprintf("It took %u iterations to get to %u",counter_bisection,guess);

%Using fzero method
guess_zero = fzero(c,0.4);
disp(guess_zero);