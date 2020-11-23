function [x1] = ex1_204627418_311603476_Q2(a,x0)
% Function returns the square root of a, if the primary guess is less than 1000
% calculations from the root. Otherwise, the function will retun an error.

for NRloop = 1:1001
    
    % calculate the next guess
    x1 = x0 - (((x0^2)-a)/(2*x0));
    
    % checks if the difference is close enough, only 1000 times
    if abs(x0-x1)<10^(-8) && NRloop~=1001
        disp ('the square root is'); disp(x1);
        break;
    else
        x0 = x1;
    end
end

% if the loop ended without a result, display an error
if NRloop == 1001
    error('Try a closer guess. It took more than 1000 computations to try find the square root.')
end

end

