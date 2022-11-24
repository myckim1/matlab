clear
clc

%From the worksheet (to get what solutions should be)
A1 = [0.04 0.54 0.26; 0.93 0.24 0; 0.03 0.22 0.74];
b1 = [2;6;2];
F1 = A1\b1;
F1 = round(F1,4); %Round F1 to 4 decimal points.

%Get F1,F2,F3 using Overall, F1, F2 balances.
A2 = [1 1 1; 0.04 0.54 0.26; 0.93 0.24 0]; %Setting the matrix
b2 = [10;2;6]; %AF = b
F2 = A2\b2; %(A^-1)AF = (A^-1)b --> F = (A^-1)b
F2 = round(F2,4); %Round F2 to 4 decimal points.

%Taking it further
%First I am creating a general matrix of F1,F2,F3,Overall
all_rows = [0.04 0.54 0.26; 0.93 0.24 0; 0.03 0.22 0.74; 1 1 1];
all_solutions = [2;6;2;10];
%I indexed it according to the stream numbers (and put overall as 4 for
%convenience)
rows_index = perms(1:length(all_rows)); %Permute across 1 to number of row vectors possible
rows_index = rows_index(:,1:length(all_rows)-1); %omit the last row (since we are doing 4P3 or for other for a general case of n equation, nPn-1)

for n=1:length(rows_index) %Loop through all permutations of rows
    index = rows_index(n,:); %Get the indices
    A = all_rows(index(1),:); %Start the matrix with the first row in the indices array
    b = all_solutions(index(1)); %Do the same with the solution

    for i = index(2:length(index)) %Now that we have the first rows, we concatenate the rest --> Hence starting from 2nd row.
        A = vertcat(A,all_rows(i,:));
        b = vertcat(b,all_solutions(i));
    end
    %Now that we have A and b, we can calculate F.
    F = A\b; %equivalent to inv(A)*b
    check_values(:,n) = (F1 == round(F,4)); %If all values of this array are 1, that means all every permutation of equations give the same solution.
end
%Now we need a way to check that all elements in the matrix are equal to 1.
disp(all(all(check_values(:,:) == 1))); %They are equal!