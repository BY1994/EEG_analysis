%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG ICA
%
%   -> run ICA 
%
% created at 2019.04.25 PBY
% github: https://github.com/BY1994
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preamble
% clear all
% close all
% clc

%% parameters
% Name of the analysis
AnalyName = 'ica';

% EEG file location
% EEGloc = 'D:\EEG ���� ����\�� ����\Ex1_n2pc_tar\���ĵ�����\pp\'; 
% EEGloc = 'D:\EEG ���� ����\�� ����\Ex2_n2pc_dist\���ĵ�����\pp\';
EEGloc = 'D:\EEG ���� ����\�� ����\Ex7_n2pc_tar_single\���ĵ�����\pp\';

cd(EEGloc);

% find Files
runStr = '*.set';
fileNames = dir(runStr);
foldersize = size(fileNames,1);

% sampling rate
resamplerate = 500;

%% eeglab
eeglab;

%% preprocessing
for file = 1:foldersize
        
    fprintf('\n\nprocessing file %d \n', file)  
    
    % 1. load EEG file
%     EEG = pop_loadcnt(fileNames(file).name , 'dataformat', 'auto', 'memmapfile', '');
%     EEG = eeg_checkset( EEG );
    EEG = pop_loadset('filename',fileNames(file).name,'filepath',EEGloc);
    EEG = eeg_checkset( EEG );
    
    % 2. ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','off');
    EEG = eeg_checkset( EEG );
    
    % 3. save
    if ~exist(AnalyName, 'dir')
        mkdir(AnalyName);
    end
    EEG = pop_saveset( EEG, 'filename',strcat(extractBefore(fileNames(file).name, "."), '_', AnalyName, '.set'),'filepath',strcat(EEGloc, AnalyName));
    EEG = eeg_checkset( EEG );
end
