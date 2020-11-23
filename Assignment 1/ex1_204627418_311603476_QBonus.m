function [Ans] = ex1_204627418_311603476_QBonus(A,B)
% Function returns a line vector of Euclidian distances between columns

Ans = (sum((A(:,:)-B(:,:)).^2)).^(0.5);


end

