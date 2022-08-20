function Save_Results(iteration, Theta, Intensity)
%
    %  We use this function to store the outputs in a text file.
    % You need to give the vectors of calculated angles and objects Distance intensity in vectors with same lengths.
    % iteration is your loop counter. we will find time with it.

    if (iteration ==1)
        delete([pwd,'\Results\Outputs.txt'])
        files = ls( [pwd,'\Results'] );
        for k = 3 : size(files, 1)
            delete([pwd,'\Results\',files(k,:)])
        end
    end
    
    file = fopen([pwd,'\Results\Outputs.txt'],'a+');
    fprintf(file,'%d:',iteration);
    
    for l = 1 : length(Theta)
        fprintf(file,'(%f,%f)',Theta(l),Intensity(l));
    end
    fprintf(file,'\n');
    
    fclose(file);


end
