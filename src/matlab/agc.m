function out = agc(filein, fileout)
%-----------------------------------------------------------------
% parameters
length = 15; % spectral run abs mean window
%-----------------------------------------------------------------
[time, vel] = readsac(filein);
delta = time(2) - time(1);
%-----------------------------------------------------------------
% AGC
agc_vel = gain(vel, delta, 'agc', length, 1);
%-----------------------------------------------------------------
% write output
lag = 0 : delta : 50;
out = writesac(lag, agc_vel, fileout);
end
