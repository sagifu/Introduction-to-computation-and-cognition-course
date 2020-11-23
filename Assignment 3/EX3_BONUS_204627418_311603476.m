
    % Simulation of a learning tempotron

    % Student1, Michael Lipliansky and 204627418
    % Student2, Sagi Furman 311603476

    % Computation and cognition undergrad - ex3
    % See PDF document for instructions

    clear; close all; clc;

%% Declare simulation parameters
gL      = 1e-4;     % conductance (S/cm^2), 1/R
C       = 1e-6;     % capacitance (F/cm^2)
tau_m   = C/gL;     % sec - time constant, equal to RC
tau_s   = tau_m/4;  % sec - time constant, equal to RC
TH      = 30*1E-3;  % firing threshold, in mV

dt      = 0.0001;       % time step for numerical integration
t_final = 0.5;          % sec, duration of numerical simulation
t       = 0:dt:t_final; % time vector

%% Define the (normalized) kernel function
alpha   = tau_m/tau_s;
kappa   = (alpha^(-1/(alpha - 1)) - alpha^(-alpha/(alpha - 1)))^(-1);
K       = @(x) (x > 0).*kappa.*(exp(-x/tau_m) - exp(-x/tau_s));

%% Declare the learning parameters
% TODO 1: Change the learning rate, as instructed in the PDF document. Only
%         try this after the learning already works. 
eta      	= 1e-3;	% Learning rate
max_steps   = 1000;	% Maxinal number of learning steps

%% Load inputs
% TODO 2: After you implement all of the missing code, load the inputs (one
%         by one) and answer the questions in the PDF file. 
 load X_2SDIW;   % X
% load X_2SDIF;   % X
% load X_2PGN;    % X
% load X_2PVTG;   % X
% load X_PRND;    % X

%% Deduce the number of input neurons from the input
N   = length(X{1}.x);          % number of input neurons

%% Initialize the tempotron's weights
W   = TH.*0.5.*(rand(N, 1));    % tempotron's weights
W0  = W;                        % initial weights (for future reference)

%% Learning loop
for learning_step = 1:max_steps
    
    % Choose a random sample
    sample = X{randi(length(X))};
    
    % Integrate & Fire neuron's simulation
    V	= zeros(size(t));	% the tempotron's voltage
    spk	= 0;                % spike occurance flag
    
    % Spikes' data per neuron
    
    % Neurs will be cell array containing four columns, each row 
    %  indicates an input neuron.
    % The first, neurs.inp, contains a vector of spikes' times.
    % The second, neurs.idx, indicates the next spike of the input neuron that will
    %  be processed.
    % The third, neurs.N_spk, indicates number of input spikes for each neuron.
    % The fourth, neurs.id, is the serial number of the neuron.
    
    neurs = cellfun(@(a, b) struct('inp', a, ...              % a copy of the input
                                   'idx', 1, ...              % next spike's index
                                   'N_spk', length(a), ...    % total number of spikes
                                   'id', b), ...              % neuron's id
                    sample.x, num2cell(1:N));
    
    % Ignore input neurons which never spike
    k = 1;
    while k <= length(neurs)
        if isempty(neurs(k).inp)
            neurs(k) = [];
        else
            k = k + 1;
        end
    end
    
    % While there are any non-processed spikes
    while ~isempty(neurs)
        
        % Get the next spike for each input neuron
         next_spks = arrayfun(@(a) a.inp(a.idx), neurs);
        
        % Select the next spike
        [t_i_j, k]	= min(next_spks);	% next spike's time & neuron  
        i           = neurs(k).id;
        
        % Handle the input left for processing
        neurs(k).idx = neurs(k).idx + 1;	% update the relevant spike index
        if neurs(k).idx > neurs(k).N_spk
            neurs(k) = [];
        end
        
        % We have an array named next_spks which contains the next spike for each input neuron, with the help of the 'idx' parameter.
        % After that we want to identify the earliest spike time (t_i_j) and the index of this neuron in the next_spks array (k).
        % Then we get its "real" identity (id) so we will know which wheight needs to be updated.
        % After that we promote the 'idx' of that neuron so next iteration we will check its' next spike.
        % Additionaly, if the 'idx' exceeds the number of spikes of a single neuron, we erase it from our working array (neurs).
        
        % Update the voltage
        V = V + W(i).*K(t - t_i_j);
        
        % Check if the voltage threshold has been crossed
        
        [V_max, t_idx] = max(V);
        t_max = t(t_idx);
        
        if V_max > TH
            spk = 1;	% set the spike flag
            break;      % shunting
        end
        
    end
    
    % If there is no need to learn anything, skip the learning
    
    if spk==sample.y0
        continue;
    end
    
    
    % Get the gradient of the weights
    W_grad = zeros(size(W));
    for i = 1:N                         % loop over neurons
        for j = 1:length(sample.x{i})   % loop over spikes
            t_i_j = sample.x{i}(j); % next spike time
            if t_i_j < t_max    % get only inputs prior to t_max
                W_grad(i) = W_grad(i) + K(t_max - t_i_j); % update the gradient
            end
        end
    end
    
    % Update the weights

    if sample.y0==1
        W   = W + W_grad.*eta;
    else
        W   = W - W_grad.*eta;
    end
    
end

%% Plots

% Set the subplots grid
n_plots	= 3*length(X);
n_rows 	= 3*ceil(length(X)/4);
n_cols 	= ceil(n_plots/n_rows);

% Create the figure
figure('Name', 'Tempotron''s results', ...
    'Units', 'normalized', ...
    'Position', [0, 0, 1, 1]);

% For each sample, draw 3 different plots
for n_sample = 1:length(X)
    
    % Define the sample's plot color according to the teacher's signal
    if X{n_sample}.y0
        sample_color = 'r';
    else
        sample_color = 'b';
    end
    
    % Input's raster plot
    subplot(n_rows, n_cols, 3*n_cols*floor((n_sample-1)/n_cols)+rem((n_sample-1),n_cols)+1);
    plot_input_spikes(t, X{n_sample}.x, sample_color);
    title(['Sample #' num2str(n_sample) ': Input']);
    
    % Tempotron's response - before learning
    subplot(n_rows, n_cols, 3*n_cols*floor((n_sample-1)/n_cols)+rem((n_sample-1),n_cols)+1+n_cols);
    plot_postsynaptic_voltage(t, X{n_sample}.x, K, W0, TH, tau_m, sample_color);
    title(['Sample #' num2str(n_sample) ': Voltage before learning']);
    
    % Tempotron's response - after learning
    subplot(n_rows, n_cols, 3*n_cols*floor((n_sample-1)/n_cols)+rem((n_sample-1),n_cols)+1+2*n_cols);
    plot_postsynaptic_voltage(t, X{n_sample}.x, K, W, TH, tau_m, sample_color);
    title(['Sample #' num2str(n_sample) ': Voltage after learning']);
    
end
