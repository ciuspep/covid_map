@echo 
@echo lo script deve essere invocato passando una data valida nel formato YYYYMMDD

set currdir=D:\progetti\leaftletjs
set homeDir=D:\progetti\covid19-italia\covid2\dati-province\
set homeDirRegioni=D:\progetti\covid19-italia\covid2\dati-regioni\
set homeDirEuropa=D:\progetti\covid19-world\covid\csse_covid_19_data\csse_covid_19_daily_reports\

set filePrefix=dpc-covid19-ita-province-
set fileRegioni=dpc-covid19-ita-regioni-latest.csv
set fileEuropa=covid_eur_diff.csv

set percorsoFileCompleto=%homeDir%%filePrefix%
set percorsoFileCompletoRegioni=%homeDirRegioni%%fileRegioni%


rem **** elaborazione province ****

set dataCorrente=%1

@echo off
For /f "tokens=1,2,3 delims=/ " %%a in ('date /t') do (set mydate=%%c%%b%%a)

echo %mydate%

if "%dataCorrente%" == "" set dataCorrente=%mydate%

del %percorsoFileCompleto%curr.csv

copy %percorsoFileCompleto%%dataCorrente%.csv %percorsoFileCompleto%curr.csv

python calcolaDiff.py %homeDir% %dataCorrente% 
gawk -f %currdir%\completaGeoJson.awk %currdir%\province.GeoJSon.js > %currdir%\province.dati.GeoJSonDiff.js

rem **** fine elaborazione province ****

rem **** elaborazione regioni ****

gawk -f %currdir%\completaGeoJsonRegioni.awk %currdir%\europe.geojson.js > %currdir%\europe.dati.geojson.js

rem **** fine elaborazione regioni ****


rem **** elaborazione europa ****

python calcolaDiffEuropa.py %homeDirEuropa% %currdir%\ %dataCorrente% 
gawk -f %currdir%\completaGeoJsonEuropa.awk %currdir%\regioni.GeoJSon.js > %currdir%\regioni.dati.GeoJSon.js

rem **** fine elaborazione europa ****

pause
