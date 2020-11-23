function [cubSign] = whichCub(pairSign1,pairSign2)
% whichCub returns what type of zebra will be born

% Condition 1 - both up
if pairSign1==1 && pairSign2==1
    zebraCub = rand();
    if zebraCub<0.9
        cubSign = 1;
    else
        if zebraCub<0.99
            cubSign = -1;
        else
            cubSign = 0;
        end
    end
else
    
    % Condition 2 - up and down
    if pairSign1==1 && pairSign2==-1 || pairSign1==-1 && pairSign2==1
        zebraCub = rand();
        if zebraCub<0.2
            cubSign = 1;
        else
            if zebraCub<0.7
                cubSign = -1;
            else
                cubSign = 0;
            end
        end
    else
        
        % Condition 3 - up and verticle
        if pairSign1==1 && pairSign2==0 || pairSign1==0 && pairSign2==1
            zebraCub = rand();
            if zebraCub<0.5
                cubSign = 1;
            else
                if zebraCub<0.9
                    cubSign = -1;
                else
                    cubSign = 0;
                end
            end
        else
            
            % Condition 4 - both down
            if pairSign1==-1 && pairSign2==-1
                zebraCub = rand();
                if zebraCub<0.99
                    cubSign = 1;
                else
                    if zebraCub<0.999
                        cubSign = -1;
                    else
                        cubSign = 0;
                    end
                end
            else
                
                % Condition 5 - down and verticle
                if pairSign1==-1 && pairSign2==0 || pairSign1==0 && pairSign2==-1
                    zebraCub = rand();
                    if zebraCub<0.001
                        cubSign = 1;
                    else
                        if zebraCub<0.3
                            cubSign = -1;
                        else
                            cubSign = 0;
                        end
                    end
                else
                    
                    % Condition 6 - both verticle
                    zebraCub = rand();
                    if zebraCub<0.1
                        cubSign = 1;
                    else
                        if zebraCub<0.4
                            cubSign = -1;
                        else
                            cubSign = 0;
                        end
                    end
                end
                
            end
        end
    end
end

