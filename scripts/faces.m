<<<<<<< HEAD
function faces(sub,input_counterbalance_file, run_num, biopac)
=======
function faces(sub,input_counterbalance_file, run_num)
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
%% -----------------------------------------------------------------------------
%                           Parameters
% ------------------------------------------------------------------------------

<<<<<<< HEAD


%% 0. Biopac parameters _________________________________________________
script_dir = pwd;
% biopac channel
channel_trigger    = 0;
channel_fixation   = 1;
channel_faces      = 2;
channel_rating     = 3;

if biopac == 1
    script_dir = pwd;
    cd('/home/spacetop/repos/labjackpython');
    pe = pyenv;
    try
        py.importlib.import_module('u3');
    catch
        warning("u3 already imported!");
    end
    % Check to see if u3 was imported correctly
    % py.help('u3')
    d = py.u3.U3();
    % set every channel to 0
    d.configIO(pyargs('FIOAnalog', int64(0), 'EIOAnalog', int64(0)));
    for FIONUM = 0:7
        d.setFIOState(pyargs('fioNum', int64(FIONUM), 'state', int64(0)));
    end
    cd(script_dir);
end


%% A. Psychtoolbox parameters _________________________________________________
global p
Screen('Preference', 'SkipSyncTests', 0);
=======
%% A. Psychtoolbox parameters _________________________________________________
global p
Screen('Preference', 'SkipSyncTests', 1);
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
PsychDefaultSetup(2);
screens                        = Screen('Screens'); % Get the screen numbers
p.ptb.screenNumber             = max(screens); % Draw to the external screen if avaliable
p.ptb.white                    = WhiteIndex(p.ptb.screenNumber); % Define black and white
p.ptb.black                    = BlackIndex(p.ptb.screenNumber);
<<<<<<< HEAD
PsychImaging('PrepareConfiguration');
PsychImaging('AddTask', 'General', 'UseFastOffscreenWindows');
=======
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
[p.ptb.window, p.ptb.rect]     = PsychImaging('OpenWindow',p.ptb.screenNumber,p.ptb.black);
[p.ptb.screenXpixels, p.ptb.screenYpixels] = Screen('WindowSize',p.ptb.window);
p.ptb.ifi                      = Screen('GetFlipInterval',p.ptb.window);
Screen('BlendFunction', p.ptb.window,'GL_SRC_ALPHA','GL_ONE_MINUS_SRC_ALPHA'); % Set up alpha-blending for smooth (anti-aliased) lines
Screen('TextFont', p.ptb.window, 'Arial');
<<<<<<< HEAD
Screen('TextSize', p.ptb.window, 36);
=======
Screen('TextSize', p.ptb.window, 18);
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
[p.ptb.xCenter, p.ptb.yCenter] = RectCenter(p.ptb.rect);
p.fix.sizePix                  = 40; % size of the arms of our fixation cross
p.fix.lineWidthPix             = 4; % Set the line width for our fixation cross
p.fix.xCoords                  = [-p.fix.sizePix p.fix.sizePix 0 0];
p.fix.yCoords                  = [0 0 -p.fix.sizePix p.fix.sizePix];
p.fix.allCoords                = [p.fix.xCoords; p.fix.yCoords];

%% B. Directories ______________________________________________________________
<<<<<<< HEAD
task_dir                       = pwd; %'/home/spacetop/repos/faces/scripts';
main_dir                       = fileparts(task_dir); %'/home/spacetop/repos/faces';
repo_dir                       = fileparts(fileparts(task_dir)); % '/home/spacetop/repos'
taskname                       = 'faces';
session = 2;
bids_string                    = [strcat('spacetop_task-', taskname),...
    strcat('_ses-',sprintf('%02d', session)),...
    strcat('_sub-', sprintf('%04d', sub)), ...
    strcat('_run-',sprintf('%02d',run_num))];
sub_save_dir = fullfile(main_dir, 'data', strcat('sub-', sprintf('%04d', sub)),...
    'beh' , strcat('ses-',sprintf('%02d', session)));
repo_save_dir = fullfile(repo_dir, 'data', strcat('sub-', sprintf('%04d', sub)),...
    strcat('task-', taskname));
if ~exist(sub_save_dir, 'dir');    mkdir(sub_save_dir);     end
if ~exist(repo_save_dir, 'dir');    mkdir(repo_save_dir);   end
dir_video                      = fullfile(main_dir,'stimuli','videos');
%dir_video                      = fullfile(main_dir,'stimuli','videos_converted');
=======
task_dir                       = pwd;
main_dir                       = fileparts(task_dir);
taskname                       = 'faces';
dir_video                      = fullfile(main_dir,'stimuli','videos');
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
counterbalancefile             = fullfile(main_dir,'design', [input_counterbalance_file, '.csv']);
countBalMat                    = readtable(counterbalancefile);
countBalMat                    = countBalMat(countBalMat.RunNumber==run_num,:);
%% D. making output table ________________________________________________________
<<<<<<< HEAD
vnames = {'src_subject_id','session_id', 'param_run_num','param_counterbalance_ver',...
    'param_video_filename','param_trigger_onset','param_start_biopac'...
    'event01_fixation_onset','event01_fixation_biopac','event01_fixation_duration',...
    'event02_face_onset','event02_face_biopac',...
    'event03_rating_biopac','event03_rating_displayonset','event03_rating_responseonset','event03_rating_RT',...
    'param_end_instruct_onset','param_end_biopac','param_experiment_duration'};
=======
vnames = {'param_fmriSession', 'param_counterbalanceVer','param_videoFilename',...
    'p1_fixation_onset','p1_fixation_duration',...
    'p2_administer_type','p2_administer_filename','p3_administer_onset',...
    'p3_actual_onset','p3_actual_responseonset','p3_actual_RT'};
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
T                              = array2table(zeros(size(countBalMat,1),size(vnames,2)));
T.Properties.VariableNames     = vnames;

a                              = split(counterbalancefile,filesep);
version_chunk                  = split(extractAfter(a(end),"ver-"),"_");
<<<<<<< HEAD
T.src_subject_id(:)            = sub;
T.session_id(:)                = 2;
T.param_run_num(:)              = run_num;
T.param_counterbalance_ver(:)   = str2double(version_chunk{1});
T.param_video_filename          = countBalMat.image_filename;
=======
T.param_fmriSession(:)=run_num;
T.param_counterbalanceVer(:)   = str2double(version_chunk{1});
T.param_videoFilename          = countBalMat.image_filename;
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468

%% E. Keyboard information _____________________________________________________
KbName('UnifyKeyNames');
p.keys.confirm                 = KbName('return');
p.keys.right                   = KbName('2');
p.keys.left                    = KbName('1');
p.keys.space                   = KbName('space');
p.keys.esc                     = KbName('ESCAPE');
p.keys.trigger                 = KbName('5%');
p.keys.start                   = KbName('s');
p.keys.end                     = KbName('e');

%% F. fmri Parameters __________________________________________________________
TR                             = 0.46;

%% G. Instructions _____________________________________________________________
order=rem(sub,2)+1;
if order==1
<<<<<<< HEAD
    judgements = {'AGE' 'SEX' 'INTENSITY'};
else
    judgements = {'INTENSITY'  'SEX'  'AGE'};
end
instruct_start                 = ['We will now start the experiment.\nPlease indicate the ' judgements{run_num} ' of the face.'];
=======
judgements = {'AGE' 'SEX' 'INTENSITY'};
else
judgements = {'INTENSITY'  'SEX'  'AGE'};    
end
instruct_start                 = ['Please indicate the ' judgements{run_num} ' of the face.'];
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
instruct_end                   = 'This is the end of the experiment. Please wait for the experimenter';

taskname = judgements{run_num};
%% C. Circular rating scale _____________________________________________________
image_filepath                 = fullfile(main_dir,'stimuli','ratingscale');
image_scale_filename           = lower(['task-',taskname,'_scale.jpg']);
image_scale                    = fullfile(image_filepath,image_scale_filename);

<<<<<<< HEAD
HideCursor;

% H. Make Images Into Textures ________________________________________________
DrawFormattedText(p.ptb.window,sprintf('LOADING\n\n0%% complete'),'center','center',p.ptb.white );
Screen('Flip',p.ptb.window);

for trl = 1:length(countBalMat.ISI)

    %cue_tex{trl} = Screen('MakeTexture', p.ptb.window, imread(cue_image));
    video_filename  = [countBalMat.image_filename{trl}];
    video_file      = fullfile(dir_video, video_filename);
    [movie{trl}, ~, ~, imgw{trl}, imgh{trl}] = Screen('OpenMovie', p.ptb.window, video_file);
    rating_tex      = Screen('MakeTexture', p.ptb.window, imread(image_scale)); % pure rating scale
    %start_tex       = Screen('MakeTexture',p.ptb.window, imread(instruct_start));
    %end_tex         = Screen('MakeTexture',p.ptb.window, imread(instruct_end));
    DrawFormattedText(p.ptb.window,sprintf('LOADING\n\n%d%% complete', ceil(100*trl/length(countBalMat.ISI))),'center','center',p.ptb.white);
    Screen('Flip',p.ptb.window);
end
=======
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468

%% -----------------------------------------------------------------------------
%                              Start Experiment
% ------------------------------------------------------------------------------

%% ______________________________ Instructions _________________________________
Screen('TextSize',p.ptb.window,36);
DrawFormattedText(p.ptb.window,instruct_start,'center',p.ptb.screenYpixels/2+150,255);
Screen('Flip',p.ptb.window);

%% _______________________ Wait for Trigger to Begin ___________________________
DisableKeysForKbCheck([]);
<<<<<<< HEAD
WaitKeyPress(p.keys.start);
Screen('TextSize',p.ptb.window,28);
DrawFormattedText(p.ptb.window,'Waiting for trigger','center',p.ptb.screenYpixels/2,255);
Screen('Flip',p.ptb.window);
WaitKeyPress(p.keys.trigger);
T.param_trigger_onset(:) = GetSecs;
T.param_start_biopac(:)                   = biopac_linux_matlab(biopac, channel_trigger, 1);

=======
KbTriggerWait(p.keys.start);
Screen('TextSize',p.ptb.window,28);
DrawFormattedText(p.ptb.window,'Waiting for trigger','center',p.ptb.screenYpixels/2,255);
Screen('Flip',p.ptb.window);
T.param_triggerOnset(:) = KbTriggerWait(p.keys.trigger);
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
WaitSecs(TR*6);

%% 0. Experimental loop _________________________________________________________
for trl = 1:size(countBalMat,1)
<<<<<<< HEAD
    
=======

>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
    %% 1. Fixtion Jitter  ____________________________________________________
    jitter1 = countBalMat.ISI(trl)-1;
    Screen('DrawLines', p.ptb.window, p.fix.allCoords,...
        p.fix.lineWidthPix, p.ptb.white, [p.ptb.xCenter p.ptb.yCenter], 2);
<<<<<<< HEAD

    T.event01_fixation_onset(trl) = Screen('Flip', p.ptb.window);
    T.event01_fixation_biopac(trl)        = biopac_linux_matlab(biopac, channel_fixation, 1);
    WaitSecs(jitter1);
    jitter1_end                           = biopac_linux_matlab(biopac, channel_fixation, 0);
    T.event01_fixation_duration(trl) = jitter1_end - T.event01_fixation_onset(trl) ;

    %% 2. face ________________________________________________________________
    %video_filename = [countBalMat.image_filename{trl}];
    %video_file = fullfile(dir_video, video_filename);
    T.event02_face_biopac(trl)      = biopac_linux_matlab(biopac, channel_faces, 1);
    movie_time = video_play(video_file , p ,movie{trl}, imgw{trl}, imgh{trl});
    T.event02_face_onset(trl) = movie_time;
    biopac_linux_matlab(biopac, channel_faces, 0);


    %% 3. post evaluation rating ___________________________________________________
    T.event03_rating_biopac(trl)          = biopac_linux_matlab(biopac, channel_rating, 1);
    T.event03_rating_displayonset(trl) = GetSecs;
    [trajectory, RT, buttonPressOnset] = linear_rating(1.875,p, rating_tex, judgements{run_num});
    rating_Trajectory{trl,2}            = trajectory;
    T.event03_rating_responseonset(trl) = buttonPressOnset;
    T.event03_rating_RT(trl) = RT;
    biopac_linux_matlab(biopac, channel_rating, 0);

=======
    fStart1 = GetSecs;
    Screen('Flip', p.ptb.window);
    WaitSecs(jitter1);
    fEnd1 = GetSecs;
    
    T.p1_fixation_onset(trl) = fStart1;
    T.p1_fixation_duration(trl) = fEnd1 - fStart1;
    
    %% 2. face ________________________________________________________________
    video_filename = [countBalMat.image_filename{trl}];
    video_file = fullfile(dir_video, video_filename);
    movie_time = video_play(video_file , p );
    T.p2_administer_onset(trl) = movie_time;
    
    
    %% 3. post evaluation rating ___________________________________________________
    T.p3_actual_onset(trl) = GetSecs;
    [trajectory, RT, buttonPressOnset] = circular_rating_output(1.875,p,image_scale,judgements{run_num});
    rating_Trajectory{trl,2} = trajectory;
    T.p3_actual_responseonset(trl) = buttonPressOnset;
    T.p3_actual_RT(trl) = RT;
    
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
end

%% ______________________________ Instructions _________________________________
Screen('TextSize',p.ptb.window,36);
DrawFormattedText(p.ptb.window,instruct_end,'center',p.ptb.screenYpixels/2+150,255);
<<<<<<< HEAD
T.param_end_instruct_onset(:) = Screen('Flip',p.ptb.window);
T.param_end_biopac(:)                     = biopac_linux_matlab(biopac, channel_trigger, 0);
WaitKeyPress(p.keys.end);
T.param_experiment_duration(:) = T.param_end_instruct_onset(1) - T.param_trigger_onset(1);

%% save parameter ______________________________________________________________

% onset + response file
saveFileName = fullfile(sub_save_dir,[bids_string,'_beh.csv' ]);
repoFileName = fullfile(repo_save_dir,[bids_string,'_beh.csv' ]);
writetable(T,saveFileName);
writetable(T,repoFileName);

% trajectory data
traject_saveFileName = fullfile(sub_save_dir, [bids_string,'_beh_trajectory.mat' ]);
traject_repoFileName = fullfile(repo_save_dir, [bids_string,'_beh_trajectory.mat' ]);
save(traject_saveFileName, 'rating_Trajectory');
save(traject_repoFileName, 'rating_Trajectory');

% ptb parameters
psychtoolbox_saveFileName = fullfile(sub_save_dir, [bids_string,'_psychtoolbox_params.mat' ]);
psychtoolbox_repoFileName = fullfile(repo_save_dir, [bids_string,'_psychtoolbox_params.mat' ]);
save(psychtoolbox_saveFileName, 'p');
save(psychtoolbox_repoFileName, 'p');

clear p; Screen('Close'); close all; sca;
=======
Screen('Flip',p.ptb.window);

%% save parameter ______________________________________________________________
sub_save_dir = fullfile(main_dir, 'data', strcat('sub-', sprintf('%03d', sub)), 'beh' );
if ~exist(sub_save_dir, 'dir')
    mkdir(sub_save_dir)
end

saveFileName = fullfile(sub_save_dir,[strcat('sub-', sprintf('%03d', sub)), ...
    '_task-',taskname,'_beh.csv' ]);
writetable(T,saveFileName);

traject_saveFileName = fullfile(sub_save_dir, [strcat('sub-', sprintf('%03d', sub)), ...
    '_task-',taskname,'_beh_trajectory.mat' ]);
save(traject_saveFileName, 'rating_Trajectory');

psychtoolbox_saveFileName = fullfile(sub_save_dir, [strcat('sub-', sprintf('%03d', sub)),...
    '_task-',taskname,'_psychtoolbox_params.mat' ]);
save(psychtoolbox_saveFileName, 'p');

sca;

>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
%% -----------------------------------------------------------------------------
%                                   Function
%-------------------------------------------------------------------------------
% Function by Xiaochun Han
<<<<<<< HEAD
    function [Tm] = video_play(moviename,p, movie, imgw, imgh)
        %     function [Tm] = video_play(moviename,p, movie, imgw, imgh)
        % [p.ptb.window, rect]  = Screen(p.ptb.screenID, 'OpenWindow',p.ptb.bg);
        % Tt = 0;
        rate = 1;
        %[movie, ~, ~, imgw, imgh] = Screen('OpenMovie', p.ptb.window, moviename);
=======
    function [Tm] = video_play(moviename,p)
        % [p.ptb.window, rect]  = Screen(p.ptb.screenID, 'OpenWindow',p.ptb.bg);
        Tt = 0;
        rate = 1;
        [movie, ~, ~, imgw, imgh] = Screen('OpenMovie', p.ptb.window, moviename);
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
        Screen('PlayMovie', movie, rate);
        Tm = GetSecs;
        t = 0; dur = 0;
        while 1
            if ((imgw>0) && (imgh>0))
                tex = Screen('GetMovieImage', p.ptb.window, movie, 1);
                t = t + tex;
<<<<<<< HEAD

                if tex < 0
                    break;
                end

=======
                if tex < 0
                    break;
                end
                
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
                if tex == 0
                    WaitSecs('YieldSecs', 0.005);
                    continue;
                end
                Screen('DrawTexture', p.ptb.window, tex);
                Screen('Flip', p.ptb.window);
                Screen('Close', tex);
            end
        end
        Screen('Flip', p.ptb.window);
        Screen('PlayMovie', movie, 0);
        Screen('CloseMovie', movie);
    end

<<<<<<< HEAD
    function [time] = biopac_linux_matlab(biopac, channel_num, state_num)
        if biopac
            d.setFIOState(pyargs('fioNum', int64(channel_num), 'state', int64(state_num)))
            time = GetSecs;
        else
            time = GetSecs;
            return
        end
    end

    function WaitKeyPress(kID)
        while KbCheck(-3); end  % Wait until all keys are released.

        while 1
            % Check the state of the keyboard.
            [ keyIsDown, ~, keyCode ] = KbCheck(-3);
            % If the user is pressing a key, thensca
            if keyIsDown

                if keyCode(p.keys.esc)
                    cleanup; break;
                else keyCode(kID)
                    break;
                end
                % make sure key's released
                while KbCheck(-3); end
            end
        end
    end
clear all
clearvars
=======
>>>>>>> bf890abe8b508ad6b426fc767920929f29314468
end
