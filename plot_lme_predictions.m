function scatter_lme_predictions(lme, T, Yvar, celltype, data_name)

% Make the predictions of the model 
prediction = predict(lme, T);

% Plot the scatter plot
figure;

scatter(T.(Yvar), prediction);
xlabel(['Observed ' data_name]);
ylabel(['Predicted ' data_name]);
title(['Observed vs Predicted ' data_name ' for ' celltype]);

% Display model statistics
annotation('textbox', [0.7, 0.8, 0.1, 0.1], 'String', sprintf('R^2: %.4f\nBIC: %.4f', lme.Rsquared.Ordinary, lme.ModelCriterion.BIC), 'FitBoxToText', 'on', 'BackgroundColor', 'w');

% Display model formula
formula_str = sprintf('Model Formula:\n%s', char(lme.Formula));
formula_label = uicontrol('style', 'text', 'Units', 'normalized', 'Position', [0.55, 0.68, 0.25, 0.1], 'String', formula_str, 'HorizontalAlignment', 'left', 'BackgroundColor', 'w');
formula_label.FontSize = 7;

end
