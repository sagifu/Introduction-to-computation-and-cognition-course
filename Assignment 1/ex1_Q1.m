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
        
    
    
    for n = 2:240
        [zebras,nUp,nDown,nVert] = monthlyCheck(zebras,nUp,nDown,nVert);
    end
    
    MeanUp(times) = nUp;
    MeanDown(times) = nDown;
    MeanVert(times) = nVert;
    
    disp(times/100);
end
%subplot(3,1,1);plot(MeanUp,'r');title('upStripe');
%subplot(3,1,2);plot(MeanDown,'b');title('downStripe');
%subplot(3,1,3);plot(MeanVert,'g');title('vertStripe');
%subplot(3,2,2);bar(semUp);title('upStripe');
%subplot(3,2,4);bar(semDown);title('downStripe');
%subplot(3,2,6);bar(semVert);title('vertStripe');
semVert = std(MeanVert);
semDown = std(MeanDown);
semUp = std(MeanUp);

hold on
bar(mean(MeanUp),'r');title('a lot of times');
bar(mean(MeanDown),'b');
bar(mean(MeanVert),'g');
hold off

