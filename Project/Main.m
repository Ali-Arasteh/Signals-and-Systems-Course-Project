%% Signals & Systems Project --- Source Localization of K-sources

    % ----> In this project, you are going to find the azimuth angle of
    %           some different sources and a guess about how far they are
    %           from us.
    
    % This is the your main code and you can control every thing from it!
    % ** If this is your first time with MATLAB, either press F5 or click on the green
    %    triangular button (RUN).
    
    % For the requested tasks, you need to change inside of the functions,
    % and also add some code in this main code.
    
    % ---> Make sure that you have added a path to the main file of
    %      project.
    
    %% Let's get things clear!
    
        clc
        clear all2      
        close all
    
        % This part is to clear the command window, remove all the pre-defined
        % parameters and close all open figures
        
        % needed folders
        addpath('Functions')
        addpath('Data')
        addpath('Results')
    
    %% Defining needed Parameters
        
        % In this part, all the needed parameters are defined and set
        %   valued. You can modify them upon our questions.
        % All the parameters are totally explained in the Project
        %   Description.
        
        
        Frequency_0 = 10 * 10^6;                % Our working Frequency (Hz)
        Omega_0 = 2 * pi * Frequency_0;         % Angular Frequency
        Delta = 3 * 10^8 / ( 2 * Frequency_0);  % Delta = lambda / 2
        M = 401;                                % M is number of our receiver sensors. Note that it must be odd.

        
        
   %% Data Generation
        
        % You should use this part, if you want to create your own data.
        % If you don't want, just simply comment this part.
   
        Number_of_Objects = input('Enter Number of Objects you want\n');
        Data = Data_Generation_for_Students( M, Number_of_Objects, Delta, Omega_0);
                                % Number of Sensors, Number of Objects,
                                % Delta and working angular frequency
                                
    %% Loading Radar_Data
        
        % When you are in main folder of project, you can load data by this
        % way:
        
        % If you are using the Data given to you, use this lines:
%             Raw_Data = load('Data\Data_1.mat');
%             Radar_Data = Raw_Data.Sensors_Data;
            
        % If you are working with your own data, use this lines instead:
        
            Raw_Data = load('Data\Radar_Data.mat');
            Radar_Data = Raw_Data.Sensors_Data;
        
    %% Fourier Calculation and localizing the sources
   
        % In this section, at first we are going to calculate the fourier
        % transform of Radar_data. Note that we are doing that on location of
        % sensors, not time! 
        

        % We will do this for all time points, so we need a loop.

        Ts = size(Radar_Data,2);        % Ts is number of time snapshots.
        Frequency_Resolution = 0.001;   % Frequencies are divided whitin pi*Frequency_Resolution.

        No_Objects = 0;
        for time = 1 : Ts

            [W,F] = Fourier_Calculator(Radar_Data(:,time), Frequency_Resolution);
            % Since it is just the magnitude of this transform which
            % matters for us, we will work only with it.
            
            [Angles, Intensities] = Source_Localizer( abs(F), W, M, Omega_0, Delta, time );
            
            % This Lines are for checking whether if any objects are found.
            % You can change Number of Iterations which we will end our
            % search ( which is 10 in first situation)
                if ( (isempty(Angles) == 1) | (Angles == 0))
                    No_Objects = No_Objects + 1;
                end
                if ( No_Objects == 10)
                    break
                end
                
                
            plotRadar(pi * Angles / 180, time, Intensities)

        end
        
    