% This function is used for plotting the radar screen, no changes in this
% function are necessary
% Input of the function is a vector which contains the angles which we have
% detected in radians.
function plotRadar(theta,iteration,transparency)
n = length(theta);
fractions = 360;
delayParam = 0.0001;
arc_degree = 30;
flag = zeros(length(theta));
sort(theta);
T=1;
for i=arc_degree:1:fractions
    k = 360/fractions;
    polarplot([0 i*k/360*2*pi],[0,1],'g','LineWidth',1);
    hold on
    polarplot([0 (i-arc_degree)*k/360*2*pi],[0,1],'g','LineWidth',1);
    hold on
    temp=0;
    for j=T:1:n
        if theta(j)<i*k/360*2*pi && theta(j)>=(i-arc_degree)*k/360*2*pi && flag(j)==0
            polarscatter(theta(j),1,'filled','square','SizeData',200,'MarkerFaceColor','red','MarkerFaceAlpha',transparency(j));
            hold on
            temp= temp+1;
            flag(j)=1;
            T=T+1;
        end
    end
    pause(delayParam/fractions);
    children = get(gca, 'children');
    delete(children(1+temp:2+temp));
    if i==fractions
       rlim([0 1]); 
    end
    
end
delete(children(:));
if (rem(iteration,10) == 0)
    savefig([pwd,'\Results\Iteration',num2str(iteration)]); 
end