function history(history)
%HISTORY Plots training metrics' history
% Plots the training/validation squared error and accuracy as a function of
% epochs. 

n_epochs = length(history) - 1;

% Error plot
yyaxis left;
plot(0:n_epochs, cellfun(@(a) a.valid_err, history), ...
     0:n_epochs, cellfun(@(a) a.train_err, history));
xlabel('Epoch');
ylabel('Error');

% Accuracy plot
yyaxis right;
plot(0:n_epochs, 100*cellfun(@(a) a.valid_acc, history), ...
     0:n_epochs, 100*cellfun(@(a) a.train_acc, history));
ylabel('Accuracy [%]');
ylim([0, 100]);

legend({'Validation error', ...
    'Training error', ...
    'Validation accuracy', ...
    'Training accuracy'}, 'Location', 'east');

end

