
% An online learning - Sanger's rule

% Student1, Michael Lipliansky 204627418
% Student2, Sagi Furman 311603476

% Computation and cognition undergrad - ex5

clear; close all; clc; 

load PCA_data; % Load data
format shortG   % Show 5 digits - for some reason, doesn't work on my computer

%% Training parameters
eta = 5e-5;
W = 0.1 * randn(length(X(:,1))-1 , length(X(:,1)));
dW = 0;
N_epochs = 60;

%% Creating sampling rectangle
sp = polyshape(M(1,:),M(2,:));
while sp.NumRegions ~= 1
    perm = randperm(length(M(1,:)));
    sp = polyshape(M(1,perm),M(2,perm));
end

%% Sanger's rule learning loop
for epoch = 1:N_epochs
    
    % Reorganize samples
    randsamp = randperm(length(X));
    sample = X(:,randsamp);
    
    Y = W * sample;   % Calculating the encoded answer

    % Online updating-loop 
    for m = 1:length(sample)
        for l = 1:length(Y(:,1))
            for k = 1:length(X(:,1))
                dW(l,k) = eta * Y(l,m) * (sample(k,m) - W(1:l,k)' * Y(1:l,m));  % Caculating the change in weights
            end
            
        end
        W = W + dW;   % Updating weights
    end
    
    eta = eta * exp(-epoch/(2*N_epochs));  % Scaling eta
    
    % Plot design
    scatter3(X(1,:),X(2,:),X(3,:),12 ,'.'); grid on;
    hold on
    plot(sp);
    uquiv = W(:,1)*8;
    vquiv = W(:,2)*8;
    wquiv = W(:,3)*8;
    quiver3(0, 0, 0, uquiv(1), vquiv(1), wquiv(1),'LineWidth',1.5); text(uquiv(1), vquiv(1), wquiv(1),'W1');
    quiver3(0, 0, 0, uquiv(2), vquiv(2), wquiv(2),'LineWidth',1.5); text(uquiv(2), vquiv(2), wquiv(2),'W2');
    w1norm = sqrt(sum(W(:,1).^2));
    w2norm = sqrt(sum(W(:,2).^2));
    angle = rad2deg(atan2(norm(cross(W(1,:),W(2,:))), dot(W(1,:),W(2,:))));
    xlabel('x1'); ylabel('x2'); zlabel('x3');
    format shortG   % Try again
    title (sprintf('||W1|| = %d, ||W2|| = %d, <(W1, W2) = %d \n percentage of progress %d \n', ...
        w1norm, w2norm, angle, round(epoch/N_epochs*100)));
    hold off
    
    pause(0.05);
end