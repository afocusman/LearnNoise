clear;
clc;
dbstop if error;
tic
%------------------------------------------------------------------
% parameters
length_agc = 15; % agc window
%------------------------------------------------------------------
% data location
datadir = '/Users/LeafRiver/Documents/Fun/Noise/Data/XF/H0720';
%-----------------------------------------------------------------
% daily agc
monthsdir = strcat(datadir, '/', '200*');
months = dir(monthsdir);
for nmonth = months'
    daysdir = strcat(datadir, '/', nmonth.name, '/', '200*_*_*');
    days = dir(daysdir);
    for nday = days'
        in  = strcat(datadir,'/',nmonth.name,'/',nday.name,    '/ft_sw_tr_',nday.name,'.SAC');
        out = strcat(datadir,'/',nmonth.name,'/',nday.name,'/agc_ft_sw_tr_',nday.name,'.SAC');
    %------------------------------------------------------------------
    % AGC
    status = agc(in, out, length_agc);
    end
end

% monthly agc
for nmonth = months'
    in  = strcat(datadir,'/',nmonth.name,    '/sk_',nmonth.name,'.SAC');
    out = strcat(datadir,'/',nmonth.name,'/agc_sk_',nmonth.name,'.SAC');
    %------------------------------------------------------------------
    % AGC
    status = agc(in, out, length_agc);
end

% yearly agc
in  = strcat(datadir,     '/sk.SAC');
out = strcat(datadir, '/agc_sk.SAC');
status = agc(in, out, length_agc);
%------------------------------------------------------------------
toc