function getBDataEstudiantes(xlsfile)
%addpath( 'C:\Users\silvia.lopez\OneDrive - Universidad del rosario\Grupo Mente y Cuerpo\tarea\tareaMenteCuerpo\datos_270419\XLS'); %for office PC
% addpath('/Users/silvia/OneDrive - Universidad del rosario/Proyectos/Ninos obesidad/ninos_shared/ninos_290918'); %for mac
addpath(fullfile('/MATLAB Drive/URosario/datosMyC'))

%raw = xlsread([xlsfile],'Sheet1');
T = readtable([xlsfile]);

% Extract variables of interest for analysis: subject#, session#,
% ss_am, ss_del, ll_am, ll_del, respT_corr, respT_rt.
% for respT.corr, 1=chose delayed and 0=chose immediate

data = [T.ss_am T.ss_del T.ll_am T.ll_del T.respT_corr T.respT_rt]; %output psychopy csv

% Remove practice trials
%data = data(10:end,:);

% Remove rows with NaNs:
data(isnan(data(:,1)),:) = [];

% % Total number of trials imported - this number can change accordingly when
% % non-answered trials are removed below
trialNum = length(data);
sub = T.participant(1);
ses = T.session(1);

if iscell(sub)==1
    sub = str2double(sub);
end
if iscell(ses)==1
    ses = str2double(ses);
end

% if isnan(sub) = 1
%     sub = raw(10,35);
% end
% 
% if isnan(ses) = 1
%     ses = raw(10,34);
% end

thisdir = pwd;
% make a data directory if necessary
if ~isdir(fullfile(thisdir,'bData'))
    disp('Making data directory');
    mkdir('bData');
end

% save output file as structure containing all fields of 'data' + subject
% and session number
outfile = fullfile('bData',sprintf('BE_S%d_%d.mat',sub,ses));
save(outfile,'data','sub','ses','trialNum');

end