clear;
clc;
dbstop if error;
%---------------------------------------------------------------------
% parameters
fraction = 0.02; % tukey window each end
halfwidth = 20; % spectral run abs mean window

dir = '/Users/LeafRiver/Documents/Fun/Noise/Data/XF/H1320';
append =                                    '_tr_XF.H1320.01.BHZ.SAC';
%---------------------------------------------------------------------
% load data
for hour = 1 : 24
    if (hour <= 9) % handle hour 01~09
        zero = '0';
    else
        zero = '';
    end

    in   =  strcat(dir, '/',        zero, num2str(hour), append);
    out  =  strcat(dir, '/', 'sw_', zero, num2str(hour), append);
    %---------------------------------------------------------------------
    % data sampling
    [time, vel] = readsac(in);
    npts = length(vel);
    delta = time(2) - time(1);
    %---------------------------------------------------------------------
    % one bit normalization
    ob = onebit(vel);
    %---------------------------------------------------------------------
    % correlation
    ac_ob = xcorr(ob, 'coeff');
    %---------------------------------------------------------------------
    % Tukey taper after cor
    tp_ac_ob = taper_tukey(ac_ob, fraction);
    %---------------------------------------------------------------------
    % whiten
    [sw_tp_ac_ob, npow, freq] ...
                    = deconvolve(tp_ac_ob, delta);

    %        = smooth(tp_ac_ob, delta, halfwidth);
    %---------------------------------------------------------------------
    % write output
    lag_length = length(sw_tp_ac_ob) - 1;
    lag = 0 : delta : lag_length * delta;
    status = writesac(lag, sw_tp_ac_ob, out);

end
%---------------------------------------------------------------------
%{
% plot
figure(1);
plot(t, gaussian);
xlim([0 50]);



figure(2);
loglog(freq, amp_cor(1 : npow/2 + 1), 'blue');
hold on;
loglog(freq, amp_smooth(1 : npow/2 + 1), 'red');
hold on;
loglog(freq, amp_whiten(1 : npow/2 +1), 'green');
hold off;
%x1 = 6*3600 + 1500;
%x2 = x1 + 15*60;
xlim([0.01 1]);

figure(3);
semilogy(freq, amp_ft(1 : npow/2 + 1));
xlim([f2 f3]);
%}
