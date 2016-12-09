function [out] = taper_tukey(data, fraction)

npts = length(data);

tukey = tukeywin(npts, 2*fraction);
tukey = tukey(:, ones(size(data, 2), 1)); % n*1 to n*m

out = data .* tukey;

end

