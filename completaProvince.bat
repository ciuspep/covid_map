@echo 
@echo lo script deve essere invocato passando una data valida nel formato YYYYMMDD

set currdir=D:\progetti\leaftletjs
set homeDir=D:\progetti\covid19-italia\covid2\dati-province\
set homeDirRegioni=D:\progetti\covid19-italia\covid2\dati-regioni\
set filePrefix=dpc-covid19-ita-province-
set fileRegioni=dpc-covid19-ita-regioni-latest.csv

set percorsoFileCompleto=%homeDir%%filePrefix%
set percorsoFileCompletoRegioni=%homeDirRegioni%%fileRegioni%


rem **** elaborazione province ****

set dataCorrente=%1

del %percorsoFileCompleto%curr.csv

copy %percorsoFileCompleto%%dataCorrente%.csv %percorsoFileCompleto%curr.csv

python calcolaDiff.py %homeDir% %dataCorrente% 

gawk -f %currdir%\completaGeoJson.awk %currdir%\province.GeoJSon.js > %currdir%\province.dati.GeoJSonDiff.js

rem **** fine elaborazione province ****

rem **** elaborazione regioni ****

gawk -f %currdir%\completaGeoJsonRegioni.awk %currdir%\regioni.GeoJSon.js > %currdir%\regioni.dati.GeoJSon.js

rem **** fine elaborazione regioni ****

pause
