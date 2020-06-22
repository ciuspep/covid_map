@echo 
@echo lo script deve essere invocato passando una data valida nel formato YYYYMMDD

set currdir=D:\progetti\leaftletjs
set homeDir=D:\progetti\covid19-italia\covid2\dati-province\
set filePrefix=dpc-covid19-ita-province-

set percorsoFileCompleto=%homeDir%%filePrefix%

set dataCorrente=%1
if ""%1"" == """" (
	set dataCorrente=latest
)

if not exist %percorsoFileCompleto%%dataCorrente%.csv (
	set dataCorrente=latest
)

del %percorsoFileCompleto%curr.csv

copy %percorsoFileCompleto%%dataCorrente%.csv %percorsoFileCompleto%curr.csv

python calcolaDiff.py %dataCorrente% %homeDir%

gawk -f %currdir%\completaGeoJson.awk %currdir%\province.GeoJSon.js > %currdir%\province.dati.GeoJSonDiff.js

pause
