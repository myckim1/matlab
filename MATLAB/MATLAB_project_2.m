%Setting up the base matrix
A = zeros(8,8);
b = ([100 0 0 0 0 0 0 0])';
%Eq. 1: F1A-F3A
A(1,1)=1; A(1,5)=-1;

%Eq. 2: F1B-F3B
A(2,2)=1; A(2,6)=-1;

%Eq. 3: 0.4F1A-F2A
A(3,1)=0.4; A(3,3)=-1;

%Eq. 4: 1.2F1A+F1B-F2B
A(4,1)=1.2; A(4,2)=1; A(4,4)=-1;

%Eq. 5: 0.8F2A-F3A
A(5,3)=0.8; A(5,5)=-1;

%Eq. 6: 0.2F2A-F4A
A(6,3)=0.2; A(6,7)=-1;

%Eq. 7: 0.8F2B-F4B
A(7,4)=0.8; A(7,8) = -1;

%Eq. 8: 0.2F2B - F3B
A(8,4)=0.2; A(8,6) = -1;

%Solving for F
F= A\b;

%Using fsolve to solve Part 2
x0 = ones(8,1); %Creating an "initial guess" where all values = 1
A_fsolve = @(x) Process(x);
F_fsolve = fsolve(A_fsolve,x0);

%Comparing the answers between Part 1 and Part 2
%Visually, it seems fine. Checking with code:
is_equal = isequal(round(F,4),round(F_fsolve,4));
%results were rounded because the very high decimal places may differ due
%to different methods used.

%Using fsolve to solve Part 2
x0_part3 = ones(9,1);
A_fsolve_part3 = @(x) Process_modified(x);
F_fsolve_part3 = fsolve(A_fsolve_part3,x0_part3,optimoptions('fsolve','MaxIter',2000));

%Function for the fsolve
function y = Process(x)
%Only takes in the input vector: 8x1 vector F1A,F1B,...
    y(1)=x(1)-x(5)-100;
    y(2)=x(2)-x(6);
    y(3)=0.4*x(1)-x(3);
    y(4)=1.2*x(1)+x(2)-x(4);
    y(5)=0.8*x(3)-x(5);
    y(6)=0.2*x(3)-x(7);
    y(7)=0.8*x(4)-x(8);
    y(8)=0.2*x(4)-x(6);
end

%Modified version for part 3 fsolve (including all the new given
%information)
function y = Process_modified(x)
%Only takes in the input vector: 9x1 vector F1A,F1B,...,T
    y(1)=x(1)-x(5)-100;
    y(2)=x(2)-x(6);
    %Equation 3 is using the equilibrium constant
    y(3)=(x(4).^2)/(x(3).*(x(3)+x(4)))-2.05;
    
end