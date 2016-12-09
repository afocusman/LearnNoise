clear;
clc;
dbstop if error;
%------------------------------------------------------------------
% parameters
length_agc = 15; % agc window

dir = '/Users/LeafRiver/Documents/Fun/Noise/Data/XF/H1320';
append =                                    '_tr_XF.H1320.01.BHZ.SAC';
%------------------------------------------------------------------
for hour = 1 : 24
    % load data
    if (hour <= 9) % handle hour 01~09
        zero = '0';
    else
        zero = '';
    end
    in   =  strcat(dir, '/ft_sw_',     zero, num2str(hour), append);
    out  =  strcat(dir, '/agc_ft_sw_', zero, num2str(hour), append);
    %------------------------------------------------------------------
    [time, vel] = readsac(in);
    delta = time(2) - time(1);
    %------------------------------------------------------------------
    % AGC
    agc_vel = gain(vel, delta, 'agc', length_agc, 1);
    %------------------------------------------------------------------
    % write output
    lag_length = length(agc_vel) - 1;
    lag = 0 : delta : lag_length * delta;
    status = writesac(lag, agc_vel, out);

end
