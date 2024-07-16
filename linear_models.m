

%% Análisis multivariado (modelo lineal generalizado y modelo lineal mixto
%T = readtable('datosMCmasDescuento_20240716.xlsx');
T = readtable('datosMCmasDescuento_20220224.xlsx');
T = T(find(~isnan(T.ln_kappa)), :)
%% modelos
Dem_formula = 'ln_kappa~1+edad+sexo+(1|record_id)+(edad|record_id)+(sexo|record_id)';
lme_Dem = fitlme(T, Dem_formula);
model_Dem = fitglm(T, 'ln_kappa ~ 1 + edad + sexo');
display(model_Dem)

Adict_formula = 'ln_kappa~1+tabaco+alcohol+(1|record_id)+(tabaco|record_id)+(alcohol|record_id)';
lme_Adict = fitlme(T, Dem_formula);
model_Adict = fitglm(T, 'ln_kappa ~ 1 + tabaco + alcohol'); %queda pendiente recodificar la variable del alcohol
display(model_Adict)

% Convert the cell array to a numeric array
numeric_bmi = str2double(T.ndice_de_masa_corporal_kg);
T.ndice_de_masa_corporal_kg = numeric_bmi;

Metab_formula = 'ln_kappa~1+ndice_de_masa_corporal_kg+colesterol_mg_dl+glucemia_mg_dl+(1|record_id)+(ndice_de_masa_corporal_kg|record_id)+(colesterol_mg_dl|record_id)+(glucemia_mg_dl|record_id)';
Metab_formula = 'ln_kappa~1+imc+colesterol+(1|num)+(imc|num)+(colesterol|num)';

lme_Metab = fitlme(T, Metab_formula);
model_Metab = fitglm(T, 'ln_kappa ~ 1 + ndice_de_masa_corporal_kg + colesterol_mg_dl + glucemia_mg_dl');
display(model_Metab)

WtHr_formula = 'ln_kappa~1+ICintTalla+colesterol_mg_dl+glucemia_mg_dl+(1|record_id)+(ICintTalla|record_id)+(colesterol_mg_dl|record_id)+(glucemia_mg_dl|record_id)';
lme_WtHr = fitlme(T, WtHr_formula);
model_WtHr = fitglm(T, 'ln_kappa ~ 1 + ICintTalla + colesterol_mg_dl + glucemia_mg_dl');
display(model_Metab)


Piscol_formula = 'ln_kappa~1+estrs+iritotal+atencinemocional+claridaddesentimientos+reparacinemocional+(1|num)+(estrs|num)+(iritotal|num)+(atencinemocional|num)+(claridaddesentimientos|num)+(reparacinemocional|num)';
lme_Piscol = fitlme(T, Piscol_formula);
model_Psicol = fitglm(T, 'ln_kappa ~ 1 + estrs + iritotal + atencinemocional + claridaddesentimientos + reparacinemocional');
display(model_Psicol)

Cardio_formula = 'ln_kappa~1+ scvscore + (1|num) + (1|scvscore)';
lme_Cardio = fitlme(T, Cardio_formula);

model_Cardio = fitglm(T, 'ln_kappa ~ 1 + scvscore');
display(model_Cardio)

final_formula = 'ln_kappa ~ 1 + inteligencia_emocional_tmms24_co + estrs + edad + imc + colesterol + glucemia + iritotal+ (1|num) + (inteligencia_emocional_tmms24_co|num) + (estrs|num) + (edad|num) + (imc|num) + (colesterol|num) + (glucemia|num) + (iritotal|num)' 
final_lme = fitlme(T, final_formula);
model_final = fitglm(T, 'ln_kappa ~ 1 + inteligencia_emocional_tmms24_co * estrs + edad + imc + colesterol + glucemia + iritotal');
display(model_final)

[r,p] = corr(T.estrs,T.inteligencia_emocional_tmms24_co,'rows','complete')
%%
s = scatter(T.fc,T.ln_kappa);