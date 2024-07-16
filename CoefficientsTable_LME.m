function coefficientsTable = CoefficientsTable_LME(lmeObject)
   
% Extracting fixed effect coefficients
    fixedeffects = fixedEffects(lmeObject);

    % Creating a table with all information
    coefficientsTable = table(lmeObject.Coefficients.Name, fixedeffects, ...
        'VariableNames', {'Name', 'Estimate'});

    % Adding other columns to the table
    coefficientsTable.SE = lmeObject.Coefficients.SE;
    coefficientsTable.tStat = lmeObject.Coefficients.tStat;
    coefficientsTable.DF = lmeObject.Coefficients.DF;
    coefficientsTable.pValue = lmeObject.Coefficients.pValue;
    coefficientsTable.Lower = lmeObject.Coefficients.Lower;
    coefficientsTable.Upper = lmeObject.Coefficients.Upper;
    Rsquared = lmeObject.Rsquared.Adjusted;
    newRow = {'Rsquared', Rsquared, 0, 0, 0, 0, 0, 0};
    coefficientsTable = [coefficientsTable; newRow];
    % Get the variable name of lmeObject
    varName = inputname(1);
    % Construct the file name
    fullFilePath = 'result_tables/GLM';  % Replace this with your desired directory
    fileName = [varName '_GLM.csv'];
    fullFilePathAndName = fullfile(fullFilePath, fileName);

    writetable(coefficientsTable, fullFilePathAndName);
    %disp(coefficientsTable)
    
end


