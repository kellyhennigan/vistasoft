function dtiFixTensorsAndDT6(dt6file)

% Usage: dtiFixTensorsAndDT6(dt6file)
%
% This function will get a tensor file from a dt6file & run DTIFIXTENSORS
% on it to set all negative eigenvalues to 0, write this to a new file
% (NEWTENSORFILE), and update the DT6FILE so that this new tensor nifti is
% what is associated with the subject.
%
% Default if NEWTENSORFILE not specified, add "nonneg_" as filename prefix
%
% DY 03/2008
% kjh: edited for different file structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist(dt6file,'file')~=2
    error(['can''t find dt6file ' dt6file])
end

% load dt6file first using dtiLoadDt6() then later using load() to get
% absolute and relative tensor file paths, respectively
dt=dtiLoadDt6(dt6file); 
tensorfile_fullpath = dt.files.tensors;
[tensordir,tfile]=fileparts(tensorfile_fullpath);
newtensorfile = ['nonneg_' tfile '.gz'];
newtensorfile_fullpath=fullfile(tensordir,newtensorfile);

dtiFixTensors(tensorfile_fullpath,newtensorfile_fullpath);

% load dt6.at again using load() to get just relative paths
dt=load(dt6file);
tensorfile = dt.files.tensors;
[tensordir,tfile]=fileparts(tensorfile);
dt.files.tensors=fullfile(tensordir,newtensorfile);

save(dt6file,'-struct','dt');


%%




