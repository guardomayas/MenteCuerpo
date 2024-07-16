function coefficientsTable = CoefficientsTable_GLM (GLMObject)
    % Extracting coefficient names
    coefNames = GLMObject.CoefficientNames';

    % Extracting coefficient estimates
    coefEstimates = GLMObject.Coefficients.Estimate;

    % Extracting standard errors
    coefSE = GLMObject.Coefficients.SE;

    % Extracting t-statistics
    coefTStat = GLMObject.Coefficients.tStat;

    % Extracting p-values
    coefPValue = GLMObject.Coefficients.pValue;

    % Calculating adjusted R-squared
    Rsquared = GLMObject.Rsquared.Adjusted;

    % Constructing the table
    coefficientsTable = table(coefNames, coefEstimates, coefSE, coefTStat, coefPValue, ...
        'VariableNames', {'Name', 'Estimate', 'SE', 'tStat', 'pValue'});

    % Adding adjusted R-squared to the table
    coefficientsTable = [coefficientsTable; {'Rsquared',Rsquared, NaN, NaN, NaN}];

    % disp(coefficientsTable)

    % Get the variable name of GLMObject
    varName = inputname(1);

    % Construct the file name
    fullFilePath = 'result_tables/GLM';  % Replace this with your desired directory
    fileName = [varName '_GLM.csv'];
    fullFilePathAndName = fullfile(fullFilePath, fileName);

    % Writing the table to a CSV file
    writetable(coefficientsTable, fullFilePathAndName);
end
