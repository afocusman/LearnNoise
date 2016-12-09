## Preprocess

0.fetch data

- fetch.pl

1.SEED to SAC(SAC PZs/RESP extracted)

- rdseed.pl

2.rename

- rename.pl

3.remove instrument response

- transfer.pl

[4].resample

resample.pl

5.cut to day then hours & rmean, rtrend, taper

- cut_day.pl
- cut_hour.pl

## More noisy

6.temporal normalization

6.a one bit

- onebit.pl

6.b run absolute mean

- run_abs_mean.pl

7.auto correlation & taper

- acor.pl

8.spectral whiten

8.a spectral domain run absolute mean

- whiten.pl

8.b deconvolve windowed correlation

- deconvolve.m

## Post-process

9.filter

- filter.pl

10.stack(normalized)

- stack.pl

11.AGC

- oneday_agc.m

## Appendix

Reference: Bensen, G.D., et al. (2007). Processing seismic ambient noise data to obtain reliable broad-band surface wave dispersion measurements. Geophysical Journal International 169, 1239–1260.

Preprocessing scripts from [SAC_Docs_zh](https://github.com/seisman/SAC_Docs_zh).

AGC code from [SeismicLab](http://seismic-lab.physics.ualberta.ca/).
