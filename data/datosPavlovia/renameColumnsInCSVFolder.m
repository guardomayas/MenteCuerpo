function renameColumnsInCSVFolder(folder_path)
    csv_files = dir(fullfile(folder_path, '*.csv'));
    
    for i = 1:length(csv_files)
        file_name = csv_files(i).name;
        file_path = fullfile(folder_path, file_name);
        
        % Check if the file is empty or contains only a single row
        file = fopen(file_path, 'r');
        first_line = fgetl(file);
        fclose(file);
        if isempty(first_line)
            fprintf('Skipping empty file: %s\n', file_name);
            continue;
        end
        
        data = readtable(file_path);
        
        old_cols = {'ss_Amt', 'ss_Delay', 'll_Amt', 'll_Delay'};
        new_cols = {'ss_am', 'ss_del', 'll_am', 'll_del'};
        
        for j = 1:length(old_cols)
            old_col = old_cols{j};
            new_col = new_cols{j};
            if any(strcmp(data.Properties.VariableNames, old_col))
                data.Properties.VariableNames{strcmp(data.Properties.VariableNames, old_col)} = new_col;
            end
        end
        
        writetable(data, file_path, 'Delimiter', ',', 'WriteRowNames', false);
    end
end

% Specify the folder path where your CSV files are located
%folder_path = '/path/to/your/folder';
%rename_columns_in_csv(folder_path);



