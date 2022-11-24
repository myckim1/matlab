clc
clear

maximum_value = 2500;
for z = 2:1:maximum_value %Iterate over initial guesses of 2 to maximum_value
    a=z; %Set the initial guess equal to a.
    counter = 0;
    while a ~= 1  %Continue loop until a = 1
        counter = counter + 1;
        if mod(a,2) == 0 %Check if a is even (divisible by 2)
            a = a/2;
        else 
            a = 3*a+1;
        end
    counter_tracker(z-1) = counter+1; %z-1 as indexing starts with 1
    end
end

%Plotting the graph
plot(2:1:maximum_value,counter_tracker,'o');
title("Plotting the number of iterations from a = 2 to a = "+maximum_value);
xlabel("Initial Guess")
ylabel("Number of Iterations");