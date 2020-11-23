function [herd,sizeUp,sizeDown,sizeVert] = monthlyCheck(herd,sizeUp,sizeDown,sizeVert)
% MounthlyCheck returns the stats of the herd after one month of change

forLoop = length(herd);
nZeb = sizeUp + sizeDown + sizeVert;

for countZeb = 1:forLoop
    
    % Randomly checks if the zebra dies or gives birth
    deathRandom = rand();
    birthRandom = rand();
    
    if deathRandom<=0.034
        
        % Updating numbers
        if herd(countZeb) == 1
            sizeUp = sizeUp - 1;
        else
            if herd(countZeb) == 0
                sizeVert = sizeVert - 1;
            else
                sizeDown = sizeDown - 1;
            end
        end
        
        % the zebra needs to be deleted
        herd(countZeb) = nan;
        % Array will be organized after the loop
    else
        if birthRandom<=0.035
            
            % Ensure a zebra won't mate with itself
            chosenZebra = countZeb;
            while chosenZebra==countZeb
                chosenZebra = randi(nZeb);
                if isnan(herd(chosenZebra))
                    chosenZebra = countZeb;
                end
            end

            % Deciding which type will the new-born be
            nZeb = nZeb + 1;
            herd(nZeb) = whichCub(herd(countZeb),herd(chosenZebra));

            % Updating the numbers
            if herd(nZeb) == 1
                sizeUp = sizeUp + 1;
            else
                if herd(nZeb) == -1
                    sizeDown = sizeDown + 1;
                else
                    sizeVert = sizeVert + 1;
                end
            end
            
        end
        
    end
    

end

% Organizing the array
nZeb = nZeb - (length(herd)-length(herd(isfinite(herd))));
herd = herd(isfinite(herd));
    
end


