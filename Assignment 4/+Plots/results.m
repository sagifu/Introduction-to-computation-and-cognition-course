function results(images, Y_out, labels)
%RESULTS Plot a subset of samples along with their true labels and 
%classification results

% Input validation
assert(size(images, 3) == length(Y_out));
assert(length(Y_out) == length(labels));

% Set the subplots grid
N_max = 30;                         % maximum number of displayed examples
N_examples = min(N_max, size(images, 3));
N_rows = floor(sqrt(N_examples));
N_cols = 2*ceil(N_examples/N_rows);

% Choose random samples
ex_perm = randperm(size(images, 3), N_examples);

for ex = 1:N_examples
    
    % Get the image's random index
    c_ex = ex_perm(ex);
    
    % Plot the image
    subplot(N_rows, N_cols, 2*ex - 1);
    imagesc(1 - images(:, :, c_ex));
    colormap gray;
    axis off square;
    
    % Write the label and true label
    subplot(N_rows, N_cols, 2*ex);
    if Y_out(c_ex) == labels(c_ex)
        text_color = 'b';
    else
        text_color = 'r';
    end
    text(0, 0.65, ...
        sprintf('y: %d\ny_0: %d', ...
        Y_out(c_ex), labels(c_ex)), ...
        'Color', text_color);
    axis off;
    
end

end

