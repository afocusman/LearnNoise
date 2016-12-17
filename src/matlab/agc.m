function out = agc(filein, fileout, agc_length)

%-----------------------------------------------------------------
[time, vel] = readsac(filein);
delta = time(2) - time(1);
%-----------------------------------------------------------------
% AGC
agc_vel = gain(vel, delta, 'agc', agc_length, 1);
%-----------------------------------------------------------------
% write output
lag_length = length(agc_vel) - 1;
lag = 0 : delta : lag_length * delta;
out = writesac(lag, agc_vel, fileout);
end
