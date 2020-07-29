import pandas as pd
import sys
import datetime
from datetime import timedelta


def diffData(aStringDay):
    if aStringDay == "":
        lastDay = datetime.datetime.now().strftime('%Y%m%d')
        print(f"lastDay:{lastDay}")
    else:
        lastDay = aStringDay

    date_time_obj = datetime.datetime.strptime(lastDay, '%Y%m%d')
    previousDay = (date_time_obj.date() - timedelta(days=1)).strftime("%Y%m%d")

    covid2 = pd.read_csv(
        base_dir + f"dpc-covid19-ita-province-{lastDay}.csv", index_col="codice_provincia")
    covid1 = pd.read_csv(
        base_dir + f"dpc-covid19-ita-province-{previousDay}.csv", index_col="codice_provincia")

    del covid2['note']
    covid2['diff'] = 0


    for index in covid2.index:
        if index < 200:
            diff = covid2.loc[index, 'totale_casi'] - \
                covid1.loc[index, 'totale_casi']
            covid2.loc[index, 'diff'] = diff  # if diff > 0 else 0
            if diff < 0:
                print(covid2.loc[index, 'denominazione_provincia'],
                      covid2.loc[index, 'diff'])

    covid2.to_csv(base_dir + 'dpc-covid19-ita-province-diff.csv',
                  index=True, header=True)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        base_dir = sys.argv[1]
        diffData("")
    else:
        base_dir = sys.argv[1]
        diffData(sys.argv[2])
