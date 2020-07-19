function casiPerRegione(nomeRegione) {
    if(nomeRegione in a) 
	   return  a[nomeRegione]
	else
       return 0
}

function diffCasiPerRegione(nomeRegione) {
    if(nomeRegione in d) 
	   return  d[nomeRegione]
	else
       return 0
}


BEGIN {
    homeDir = "../covid19-italia/covid2/dati-regioni/dpc-covid19-ita-regioni-latest.csv"
    FS = ","

#    print "file name = ", homeDir 
    while ((getline  < (homeDir) ) > 0) { 
        a[$4] = $11
        d[$4] = $12
    }

#    for (x in d)
#      print x, "=", d[x]

    FS = "\""
}

/"properties": { "NOME_REG"/ {
    insertString = " , \"diff_casi\": " casiPerRegione($10) ", \"diff_casi_per_regioni\":" diffCasiPerRegione($10)  " }, "
	#print $10, insertString

    # concateno i primi 10 token
	for (i = 1 ; i <= 10 ; i++) 
	   printf "%s\"" , $i
    
    # inserisco la stringa con il totale dei casi
    printf "%s\"" , insertString

    # finisco i rimanenti token
    for (i = 12; i < NF ; i++)
       printf "%s\"" , $i

    # l'ultimo token non deve contenere il carattere "
    printf "%s\n" , $NF
       
}

!/"properties": { "NOME_REG"/ {
    print $0
}

END {
#	print "fine"
}
