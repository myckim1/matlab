clear 
clc %Prepare the workspace

a = 2463; %Create random integer between 20 and 1000
fprintf("The first guess is %u \n",a) %To display to the user what the first guess was.
counter = 0; %To count the number of iterations until a = 1
initial_guess = a; %This is for the plot title

while a ~= 1 && counter < 100000 %Continue loop until a = 1, Maximum of 100000 iterations
    counter = counter + 1;
    iterated_values(counter) = a;
    if mod(a,2) == 0 %Check if a is even (divisible by 2)
        a = a/2;
    else 
        a = 3*a+1;
    end
end

iterated_values(counter+1) = 1; %Just to include the end result.
fprintf("It took %u iterations to get to a = 1", counter)

%Plotting the iterated values
x = 1:1:(counter+1); %+1 to include the final a = 1 iteration and keep dimensions consistent

plot(x,iterated_values,'-o','MarkerSize',3);
title("Iteration over an intial guess of " + initial_guess);
    