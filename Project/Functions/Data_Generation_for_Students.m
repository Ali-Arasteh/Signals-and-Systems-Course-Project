function Sensors_Data = Data_Generation_for_Students(M, K,Delta, Omega_0)

    % In this function, received signals for M sensors from K sources are
    %   generated.
    % M = Number of Sensors
    % K = Number of Sources
    % Delta = Distance between two adjacent sensor
    % Omega_0 = Frequency of transmitted signal and received signal
    % You will be asked about objects initial positions in the plane, and
    % their speeds. Then the data will be generated.
    % Some noise are added to signals.
    
    dt = 0.1;  % time Quany
    Time_Vector = 0:dt:10;
    T = length( Time_Vector ); % Number of time points
    Velocity_X = zeros ( K, 1);
    Velocity_Y = zeros ( K, 1);
    
    Xs = zeros(K, T);
    Ys = zeros(K, T);
    
    for obj = 1 : K
        Xs (obj , 1) = input(['Object Number ',num2str(obj),' Initial X Position\n']);
        Ys (obj , 1) = input(['Object Number ',num2str(obj),' Initial Y Position\n']);
        Velocity_X (obj , 1) = input(['Object Number ',num2str(obj),' Initial X Speed\n']);
        Velocity_Y (obj , 1) = input(['Object Number ',num2str(obj),' Initial Y Speed\n']);
    end
    
    for time = 2 : T
        Xs (:, time) = Xs (:, time - 1) + Velocity_X * dt;
        Ys (:, time) = Ys (:, time - 1) + Velocity_Y * dt;
    end
    
    Distance_Matrix = sqrt(Xs .^2 + Ys .^2); % Distance of Sources from Central Sensor
    Angle_Matrix = atan(Ys./Xs) + abs(atan(Ys./Xs)<0)*pi ; % Angles of Sources from Central Sensor
    
    
    Random_Phase_Noise = rand( K, T ) * pi/4 ; % Random noise added in phase off Central sensor received signal
    
    Sensors_Data = zeros( M, T );
        % Received Signal at all time points for all sensors --> size =
        %       Number of Sensors * Number of time points
        
    Midle_Index = floor(M/2) + 1; % Index of central sensor
    
    Source_Effects = zeros( K, T);
    for counter = 1 : K
        Source_Effects( counter, : ) = (1./(Distance_Matrix( K, : ).^2)) .* (exp( i * (Omega_0 * Time_Vector) ) ) .* exp( i * Random_Phase_Noise( counter,:));
    end
    
    lambda = 3 * (10^8) / ( Omega_0 / (2*pi) ) ; % Wave_length
    Delay_Matrix = - (2*pi/lambda) * Delta * cos(Angle_Matrix);
    
    for sensor_counter = 1 : M
        for t = 1 : T
            for source_counter = 1 : K
                Sensors_Data( sensor_counter, t ) = Sensors_Data( sensor_counter, t ) + Source_Effects( source_counter, t) * exp( i * Delay_Matrix( source_counter, t ) * (sensor_counter - Midle_Index));
            end
        end
    end
    
    Final_Noise = 0.000001*randn( M, T );
    Sensors_Data = Sensors_Data + Final_Noise;
    
    save('Data\Radar_Data.mat','Sensors_Data');

end