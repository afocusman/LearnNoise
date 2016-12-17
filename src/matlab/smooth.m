function [cor_out, npow, freq] = smooth(cor, delta, halfwidth)

npts = length(cor);
halfwidth = floor(halfwidth / delta); % n points in frequency domain(integer)

% run abs mean in spcetral domain
npow = 2 ^ max(nextpow2(npts), 15);
freq =  (0 : (npow/2)) / (delta * npow);

spec_cor     = ifft(cor, npow);
amp_cor      = abs(spec_cor);

for i = halfwidth + 1 : npow - halfwidth
    sum = 0;
    for j = -halfwidth : halfwidth
        sum = sum + amp_cor(i+j);
    end
    amp_whiten(i) = amp_cor(i) / (sum / (2 * halfwidth + 1));
end

amp_whiten(1 : halfwidth) = 0;
amp_whiten(npow - halfwidth + 1 : npow) = 0;

% fft --> ifft
cor_whiten = fft(amp_whiten, npow);
cor_out = 2 * real(cor_whiten(1 : (npts-1) / 2)) ./ npow;

% normalize
maximum = max(abs(cor_out));
cor_out = cor_out / maximum;

end

