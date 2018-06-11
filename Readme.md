# Slides

La cartella "Slides" contiene i files della presentazione nei 3 formati (Keynote per Mac, PowerPoint e PDF)

**NB**: Le slides sono state create con Keynote su Mac, gli altri due formati sono frutto di esportazione per cui potrebbero non essere perfette, soprattutto la versione PowerPoint potrebbe apparire leggermente disallineata, con font, animazioni, transizioni, sostituiti.


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

Una serie di esempi (divisi in step di evoluzione) che mostra come un'architettura divisa a strati (in questo caso: ui, persistenza e modello) permette di aggiungere funzionalità al programma senza modificare il codice esistente.

**NB**: La cartella "MicroGestBad" contiene una versione da considerarsi come esempio negativo (in pratica come NON fare)
 
**NB**: Il primo demo (MicroGest1) crea anche il database, gli altri step mostrano l'evolversi passo/passo della stessa applicazione.

**NB**: La cartella "Database" contiene una copia dei due database, un DB SQLite (che cmq viene creato anche automaticamente dallo step 1) che deve trovarsi nella cartella "Documenti", l'altro un DB Firebird che deve trovarsi nella cartella "c:\ProgramData".

**NB**: La cartella "StepByStep" contiene due cartelle delle quali una (MicroGest) è il punto di partenza corrispondente allo step 1 per dimostrare, dal vivo, l'evoluzione del progetto attraverso gli step successivi aggiungendo man mano le unit corrispondenti (le unit sono già presenti nella cartella, basta aggiungerle al progetto e adattare le factories).

**NB**: La cartella "FullStepByStep" è come la "StepByStep" ma senza le unit mancanti nella cartella, in pratica le unit mancanti vanno create da zero manualmente. 

**NB**: Il file "MicroGest.PDF" contiene una descrizione dei singoli step di evoluzione dell'appplicazione.


## Licenza

Il software è rilasciato nei termini della MIT license. In breve: fatene quello che volete ma se qualcosa non funziona non è colpa nostra :-)