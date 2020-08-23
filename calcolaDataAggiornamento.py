# calcolaDataAggionamento baseDir, globFileFormat, regexp, annoMeseGiorno
import sys
import os
import fnmatch
import re
import datetime


anno = None
mese = None
giorno = None

def getData(baseDir, globFileFormat, regexp, annoMeseGiorno):
    maxDate = datetime.date(2000 , 1, 1)
    for file_name in os.listdir(f"{baseDir}/"):
        if fnmatch.fnmatch(file_name, globFileFormat):

            m = re.match(r"{}".format(regexp), file_name)
            if m != None:
                #print(m.groups())
                annoMeseGiornoList = annoMeseGiorno.split(':')
                anno = int(m.group(int(annoMeseGiornoList[0])))
                mese = int(m.group(int(annoMeseGiornoList[1])))
                giorno = int(m.group(int(annoMeseGiornoList[2])))

                currDate = datetime.date(anno,mese, giorno)
                if currDate > maxDate:
                    maxDate = currDate
    
    return maxDate.strftime('%d/%m/%Y')


if __name__ == '__main__':
    if len(sys.argv) == 5:
        baseDir = sys.argv[1]
        globFileFormat = sys.argv[2]
        regexp = sys.argv[3]   
        annoMeseGiorno = sys.argv[4]
        print(getData(baseDir, globFileFormat, regexp, annoMeseGiorno))  
    else:
        print(f"il formato del file deve essere: {sys.argv[0]} baseDir, globFileFormat, regexp, annoMeseGiorno")
