clear;
clc;
dbstop if error;
tic
%-----------------------------------------------------------------
% parameters
fraction = 0.02; % tukey window each end
halfwidth = 15; % spectra run absolute mean window halfwidth in seconds
%-----------------------------------------------------------------
% data location
datadir = '/Users/LeafRiver/Documents/Fun/Noise/Data/XF/H0720';
%-----------------------------------------------------------------
% load data
monthsdir = strcat(datadir, '/', '200*');
months = dir(monthsdir);
for nmonth = months'
    daysdir = strcat(datadir, '/', nmonth.name, '/', '200*_*_*');
    days = dir(daysdir);
    for nday = days'
        in  = strcat(datadir,'/',nmonth.name,'/',nday.name,'/',   'tr_',nday.name,'.SAC');
        out = strcat(datadir,'/',nmonth.name,'/',nday.name,'/','sw_tr_',nday.name,'.SAC');
        %-----------------------------------------------------------------
        % data sampling
        [time, vel] = readsac(in);
        npts = length(vel);
        delta = time(2) - time(1);
        %-----------------------------------------------------------------
        % one bit normalization
        ob = onebit(vel);
        %-----------------------------------------------------------------
        % correlation
        ac_ob = xcorr(ob, 'coeff');
        %-----------------------------------------------------------------
        % Tukey taper after cor
        tp_ac_ob = taper_tukey(ac_ob, fraction);
        %-----------------------------------------------------------------
        % whiten
        %[sw_tp_ac_ob, npow, freq] = deconvolve(tp_ac_ob, delta);
        [sw_tp_ac_ob, npow, freq]  = smooth(tp_ac_ob, delta, halfwidth);
        %-----------------------------------------------------------------
        % write output
        lag_length = length(sw_tp_ac_ob) - 1;
        lag = 0 : delta : lag_length * delta;
        status = writesac(lag, sw_tp_ac_ob, out);
    end
end
toc
