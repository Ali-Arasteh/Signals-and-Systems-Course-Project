function [Omega, Fourier] = Fourier_Calculator( x , Frequency_Resolution )
    %
    % In this function, you can calculate the fourier transform of your
    %   desired Signal.
    % x ---> is the column vector x[n] which you want to calculate its fourier
    % transform.
    % Frequency_Resolution ----> is a scalar input which define the
    % resoluion of Frequency vector. which we have :
    %                            omega[n] = n * Frequency Resolution * pi
    %
    % Omega is Frequency vector which Fourier transform of signal, x, is
    % calculated on it. We return the fourier transform values in Fourier
    % vector. Note that these vectors have same lengths.
    
    % Compute the Fourier Transfrm in this Part :
    
    
    % ???? Mid =   % To find the zero point of signal
        % ---> Your code:
    Mid = floor(length(x)/2) + 1;
        
    % We use Frequency_Resolution to find how accurate our Omega axis can
    % be.
    
    Omega = zeros( length( -1:Frequency_Resolution:1 ), 1);
    Fourier = zeros(length(Omega),1);
    
    % Omega Vector = ???
    % Fourier Calculation = ???
        % ---> Your code:
    Omega = pi .* (-1:Frequency_Resolution:1);
    for i = 1:length(Omega)
       sum = 0;
       for j = 1:length(x)
           sum = sum + x(j) * exp((-1) * 1i * (j - Mid) * Omega(i));
       end
       Fourier(i) = sum;
    end

    

    
    
   
end