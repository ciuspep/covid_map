function casiPerProvincia(nomeProvincia) {
    if(nomeProvincia in a) 
	   return  a[nomeProvincia]
	else
       return 0
}

function diffCasiPerProvincia(nomeProvincia) {
    if(nomeProvincia in d) 
	   return  d[nomeProvincia]
	else
       return 0
}


BEGIN {
    homeDir = "../covid19-italia/covid2/dati-province/dpc-covid19-ita-province-diff.csv"
    FS = ","

#    print "file name = ", homeDir 
    while ((getline  < (homeDir) ) > 0) { 
        a[$6] = $10
        d[$6] = $11  #d[$6] = $12
    }

#    for (x in d)
#      print x, "=", d[x]

    FS = "\""
}

/"properties": { "NOME_PRO"/ {
    insertString = " , \"totale_casi\": " casiPerProvincia($10) ", \"diff_casi\":" diffCasiPerProvincia($10)  " }, "
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

!/"properties": { "NOME_PRO"/ {
    print $0
}

END {
#	print "fine"
}
