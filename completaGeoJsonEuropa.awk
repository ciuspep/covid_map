function casiPerStato(nomeStato) {
    if(nomeStato in a) 
	   return  a[nomeStato]
	else
       return 0
}

function diffCasiPerStato(nomeStato) {
    if(nomeStato in d) 
	   return  d[nomeStato]
	else
       return 0
}


BEGIN {
    homeDir = "./covid_eur_diff.csv"
    FS = ","

#    print "file name = ", homeDir 
    while ((getline  < (homeDir) ) > 0) { 
        a[$1] = $2 
        d[$1] = $3
    }

#    for (x in d)
#      print x, "=", d[x]

    FS = "\""
}

/"properties"/ {
    insertString = " , \"diff_casi\": " casiPerStato($10) ", \"diff_casi_per_regioni\":" diffCasiPerStato($10)  " }, "
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

!/"properties"/ {
    print $0
}

END {
#	print "fine"
}
