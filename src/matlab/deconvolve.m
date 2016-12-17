%function [cor_out, npow, freq] = deconvolve(cor, delta)
function [amp_cor, amp_smooth, amp_whiten, cor_out, npow, freq] = deconvolve(cor, delta)
npts = length(cor);


% gaussian window
alpha = 1000; % smaller, sigma larger

% damp to handle divided by zero
damp = 1e-10;

% deconvolve
% apply gaussian window
gaussian = gausswin(npts, alpha);
gaussian = gaussian(:, ones(size(cor, 2), 1)); % n*1 to n*m

cor_smooth = cor .* gaussian;

% ifft --> fft
npow = 2 ^ max(nextpow2(npts), 15);
freq =  (0 : (npow/2)) / (delta * npow);

spec_cor     = ifft(cor, npow); % fourier transform function
spec_smooth  = ifft(cor_smooth, npow);

amp_cor      = abs(spec_cor); % amplitude spectra
amp_smooth   = abs(spec_smooth);

% whiten
amp_whiten = amp_cor ./ (amp_smooth + damp);

% fft --> ifft
cor_whiten = fft(amp_whiten, npow);
cor_out = 2 * real(cor_whiten(1 : (npts-1) / 2)) ./ npow;

% normalize
maximum = max(abs(cor_out));
cor_out = cor_out / maximum;

end

