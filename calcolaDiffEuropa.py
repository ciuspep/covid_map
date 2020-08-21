import pandas as pd
import numpy as np
import sys
import datetime
from datetime import timedelta

def diffData(aStringDay):
    if aStringDay == "":
        lastDay = datetime.datetime.now().strftime('%m-%d-%Y')
        print(f"lastDay:{lastDay}")
    else:
        lastDay = aStringDay

    date_time_obj = datetime.datetime.strptime(lastDay,  '%Y%m%d')
    previousDay = (date_time_obj.date() - timedelta(days=1)).strftime("%m-%d-%Y")

    lastDayFormatted = date_time_obj.strftime("%m-%d-%Y")

    #remoteHomeDir = "D:/progetti/covid19-world/covid/csse_covid_19_data/csse_covid_19_daily_reports/"
    #homeDir = "D:/progetti/leaftletjs/"

    covid2 = pd.read_csv(remoteHomeDir +f"{lastDayFormatted}.csv", index_col="Country_Region")
    covid1 = pd.read_csv(remoteHomeDir +f"{previousDay}.csv", index_col="Country_Region")

    # legge la lista degli stati europei
    listaStati = pd.read_csv(homeDir+ "listaStati.txt", names =['Country_Region'] , header=None)
    listaStati.set_index('Country_Region')

    # esegue l'inner join per filtrare solo gli stati europei
    covid2_filt = pd.merge(covid2, listaStati, on='Country_Region', how='inner')
    covid2_filt.set_index('Country_Region')

    covid1_filt = pd.merge(covid1, listaStati, on='Country_Region', how='inner')
    covid1_filt.set_index('Country_Region')

    # Series
    # somma per nazione
    covid2_filtSum = covid2_filt.groupby(['Country_Region'])['Active'].sum()
    covid1_filtSum = covid1_filt.groupby(['Country_Region'])['Active'].sum()

    # Series (diff)
    covidDiff = covid2_filtSum - covid1_filtSum

    covid_eur = pd.concat([covid2_filtSum, covidDiff] , axis = 1)
    covid_eur.columns = ['totale_positivi', 'variazione_totale_positivi']
    covid_eur['totale_positivi'] = np.int32(covid_eur['totale_positivi'])
    covid_eur['variazione_totale_positivi'] = np.int32(covid_eur['variazione_totale_positivi'])

    # scrive nella directory locale il file risultato
    covid_eur.to_csv(homeDir+ "covid_eur_diff.csv", index = True, header=True)

if __name__ == '__main__':
    if len(sys.argv) != 4:
        remoteHomeDir = sys.argv[1]
        homeDir = sys.argv[2]
        diffData("")
    else:
        remoteHomeDir = sys.argv[1]
        homeDir = sys.argv[2]
        diffData(sys.argv[3])