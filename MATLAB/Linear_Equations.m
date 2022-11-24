A = [0.04 0.54 0.26 ; 0.93 0.24 0 ; 0.03 0.22 0.74];
b = [2;6;2];
tic
    x = A\b;
toc

tic
    F = inv(A)*b;
toc

commandwindow