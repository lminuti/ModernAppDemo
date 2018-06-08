# ModernAppDemo

Demo per il seminario "*Architetture modulari e moderne con Delphi*".
[DelphiDay 2018](https://www.delphiday.it/seminari.html)

## Anonymizer
Applicazione a linea di comando che permette di anonimazzare una base dati. La sintassi è la seguente:

```
ANONYMIZER [/H] [/V] [/A ][/P password] [/F nomefile]

/V        Mostra Versione
/H        Questo help
/F        Configurazione del file
nomefile  Il file di configurazione
/P        Password
password  La passoword del database
```

Il file di configurazione deve essere strutturato sul modello dei due di esempio.

## BasicGuiDemo

Semplice esempio di applicazione GUI che mostra come evitare di introdurre dipendeze tra form pur matenendo possibile una comunicazione bidirezionale tra le stesse.

## MicroGest

Una serie di esempi che mostra come un'architettura divisa a strati (in questo caso: ui, persistenza e modello) permette di aggiungere funzionalità al programma senza modificare il codice esistente.

