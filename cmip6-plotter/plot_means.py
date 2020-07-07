import sys
import argparse
import os
import xarray as xr
from matplotlib import pyplot as plt
import matplotlib.colors as mcolors
from itertools import cycle
import statsmodels.api as sm


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--paths', nargs="+", required=True)
    args = parser.parse_args()

    variable = args.paths[0].split('.')[7]

    fig, ax = plt.subplots()
    fig.set_size_inches(18.5, 10.5)
    plt.title(variable)

    colors = cycle(mcolors.TABLEAU_COLORS)
    dataset_list = []
    for path in args.paths:
        idx = path.find('CMIP6')
        dataset_id = path[idx:].replace(os.sep, '.')
        ds = xr.open_dataset(path)
        decomp = sm.tsa.seasonal_decompose(ds[variable].to_pandas(), model='additive', period=12)
        decomp.trend.to_xarray().plot.line(hue=variable, x='time')
        ds.close()

    plt.savefig(f'{variable}.png')
    return 0

if __name__ == "__main__":
    sys.exit(main())