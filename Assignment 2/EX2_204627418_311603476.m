
    % Simulation of an intergrate-and-fire neuron

    % TODO: Michael Lifliansky, 204627418
    % TODO: Sagi Furman, 311603476

    % Computation and cognition undergrad - ex2
    % See word document, for instructions

    clear; close all; clc;

    %% Declare simulation parameters (we will work in units of Volts, Siemens, Farads and Sec)
    gL = 1e-4; % conductance (S/cm^2), 1/R
    C = 1e-6; % capacitance (F/cm^2)
    tau = C/gL; % sec - time constant, equal to RC
    TH_in_mV = 30; % mV
    TH = TH_in_mV/1000; % V
    tau_R = 0.004; % sec - Refractoriness

    dt = 0.0001; % time step for numerical integration
    t_final = 1; % sec, duration of numerical simulation
    n = round(t_final/dt); % number of iterations (steps)
    V = NaN(1,n+1); % initialize array for the voltage trace
    V(1) = 0; % initial condition for the voltage - This is V(0)
    %In matlab we arrays are 1-indexed (V(1) is the first element)
    %This is why we have 10001 columns in I

    t = (0:n)*dt; % time vector (n+1 components)

    %% load external current
    %TODO: After you implement 'the plotting section', load the currents
    %(one by one) and plot the applied current and the neuron's response

  %  load I_const; % loading I
    % load I_sin; %loading II
    % load I_exp; %loading III
     load I_step; %loading IV

    %% Numerical integration
    %TODO: add a comment to each line that explains what it does
    % HINT: Explain it to me like I know matlab pretty well, but I don't have a
    %   clue in neuroscience or differntial equations.
    RP_flag = 0; %variable indicates the RP (refractory period).
    for idx = 1:n % defining a loop which runs the number of desired iteretions.
        VV = V(idx) + (-V(idx)/tau + I(idx)/C)*dt; % dynamical equation of an RC circuit
        %Updates the "membranal" voltage using the sum of the previous voltage and the current dV (change in voltage).  

   %     if VV >= TH % checks if the current value of the voltage is higher or equal to the TH 
     %        VV = 0; % resets the voltage value 
      %       RP_flag = 1; % indicates the begining of RP
       %     t_RP_start = t(idx); % saves the time that RP has began.
        % end
        if RP_flag % during the RP the voltage value remains 0.
            VV = 0; % during the RP the voltage value remains 0.
            if (t(idx) - t_RP_start >= tau_R) % checks if the difference between the current time and the time that the RP started is higher or equal to the RP time (tau_R).
                RP_flag = 0; % the end of the RP.
            end
        end

        V(idx+1) = VV; % updates the next Voltage Value 
    end

    %% The plotting section
    % TODO: 
    %1. Read about the 'subplot()' function and use it in this section
    %   A hint: you need to use it twice using different parameters
    %2. Notice that you need to rescale the units of the Y axis values
    %   from A to microA and from V to mV.
    %   Look at the tables here 'https://en.wikipedia.org/wiki/Metric_prefix',
    %     if you are having problems with the rescaling.
    figure('Color','w');
    %TODO: plot() the the applied current as a function of time
    set(gca,'FontSize',16)
    I = I.*10^6; % change Aׁ values to mA
    subplot(2,1,1); plot(t, I);
    ylabel('Current [\muA]')
    %TODO: plot() the TH as a dashed horizontal line
    hold on
    subplot(2,1,2); plot(TH, '-');
    %TODO: plot() the voltage trace as a function of time
    % Note: the simulation computes the voltage of the neuron relative to the
    % resting potential. Thus, the Y-axis starts from zero.
    set(gca,'FontSize',16)
    V = V.*10^3  ; % change V values to mV
    subplot(2,1,2); plot(t, V);
    ylim([0 35]);
    yline(TH*1000, '--')
    xlabel('Time [S]');
    ylabel('Relative Voltage [mV]')
 
  
   
   
   
