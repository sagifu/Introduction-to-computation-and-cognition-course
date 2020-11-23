MeanUp = zeros(100,1);
MeanDown = zeros(100,1);
MeanVert = zeros(100,1);

for times = 1:100
    
        % Creating an array for zebras and amount values
        zebras = zeros(10000,1);
        nUp = 0;
        nDown = 0;
        nVert = 0;
        
        % Creating a pseudo-equal array of zebras
        for n = 1:10000
            a = rand();
            if a<=0.33
                zebras(n) = -1; % DownStripe
                nDown = nDown + 1;
            else
                if a<=0.66
                    zebras(n) = 0; % VerticleStripe
                    nVert = nVert + 1;
                else
                    zebras(n) = 1; % UpStripe
                    nUp = nUp + 1;
                end
            end
        end
        
    
    % Checking the zebra herd stats for 240 months
    % Assuming the random placement is the first month
    for n = 2:240
        [zebras,nUp,nDown,nVert] = monthlyCheck(zebras,nUp,nDown,nVert);
    end
    
    % Remembers the amount of zebras from each type after 20 years for final calculation
    MeanUp(times) = nUp;
    MeanDown(times) = nDown;
    MeanVert(times) = nVert;
    
    % Displays progress percentage, one percent for every 20 years check.
    disp('progress percentage:');
    disp(times);
end

% Preparing variables and making a bar plot
x = categorical({'Up: Mean, SEM','Down: Mean, SEM','Vert: Mean, SEM'});
y = [mean(MeanUp) std(MeanUp); mean(MeanDown) std(MeanDown); mean(MeanVert) std(MeanVert)];
Graphs = bar(x,y);title('The herd');
xtipss = Graphs(1).XData;
ytipss1 = Graphs(1).YData;
labelss1 = string(round(Graphs(1).YData));
text(xtipss,ytipss1,labelss1,'HorizontalAlignment','right','VerticalAlignment','bottom')
ytipss2 = Graphs(2).YData;
labelss2 = string(round(Graphs(2).YData));
text(xtipss,ytipss2,labelss2,'HorizontalAlignment','left','VerticalAlignment','bottom')

