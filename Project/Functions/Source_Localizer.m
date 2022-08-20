function [Thetas, Intensity] = Source_Localizer( X, Omega, M, Omega_0, Delta, iteration )
%
    % In this function, You should find the peaks of Fourier transform.
    % X ---- > X is the fourier transform vector. 
    % Omega ----> Frequenct Vector.
    %            # These two must have same lengths! #
    %
    % Omega_0 ----> Is the Frequency which the signals are transmited whit
    %                in time domain.
    % Delta -----> Distance between Anthenas.
    % iteration ----> Your loop counter, which indicates at which time we
    %                   are.   t = iteration * time resolution.
    %
    % Thetas ----> is the vector of calculated angles for each objects. So, its length 
    %               is equal to number of objects It must be in degrees.
    % Intensity ----> Is a measure for how far the object is. It has a same
    %                   length as Thetas. for near objects, it is about 1
    %                   and its minimum value is 0.1;
    
    
    
    
    Threshold = mean (X) + 5 * std(X);  % We need a Threshold to find a peak.
    
    % if you want to see the diagram and the peaks, uncomment this part.
    % You can add an "%" before "%{" and "%}" signs.
    
      %{  
        figure
        findpeaks( X, Omega,'MinPeakHeight' , Threshold)
        xlabel('Omega')
        ylabel('Magnitude of Fourier Transform');
        title('Peaks of Fourier Transform');
        key = waitforbuttonpress;
      %}
     
    
    [ Peaks, Peak_locations ] = findpeaks( X, Omega, 'MinPeakHeight' , Threshold)
    
    Thetas = 0;
    
    % In this part, you must calculate Objects angles from peak omegas.
    % ---> Your code:
    
    Thetas = acos( - Peak_locations ./ pi);
    Thetas = Thetas .* (360 / (2 * pi));
    

    % In this part, we want to find how far is the source.
    % There are better measurements, but we divide the distance from 0 to
    % 500 into 20 divisions
    
    if ( Thetas ~= 0 )
        Intensity = (20 - floor( sqrt( M./Peaks ) / 5 ))/ 20;
        for k = 1 : length(Intensity)
            if(Intensity(k) < 0.1)
                Intensity(k) = 0.1;
            end
        end
    else
        Intensity = 0;
    end

    Save_Results(iteration, Thetas, Intensity); % This function save your results in a text file.

end