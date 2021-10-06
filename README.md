![form-builder-logo]

![swift](https://img.shields.io/badge/Swift-5.0-orange) ![target](https://img.shields.io/badge/Target-iOS%2013-brightgreen) ![platform](https://img.shields.io/badge/Platform-iOS%20%7C%20padOS-blue)  

# Introduzione

SwiftFormBuilder è un framework ad uso interno Vetrya per la creazione di form dinamici. Questi form, utilizzati soprattutto nelle fasi di registrazione delle app, sono altamente personalizzabili

SwiftFormBuilder permette di:
- Creare da codice dinamicamente un form per l'inserimento dei dati;
- Validare i campi e gestire a video gli errori;
- Gestire l'obbligatorietà dei campi;

Di seguito nella documentazione troverete tutte le informazioni necessarie all'utilizzo della libreria.

# Cosa trovo nel progetto

Il progetto contiene due target:
- SwiftFormBuilder
- FormBuilderSample

## SwiftFormBuilder
È il modulo che contiene il codice che gestisce la creazione del form dinamico. È la libreria vera e propria.

## FormBuilderSample 
È una semplice applicazione demo grazie alla quale si può vedere come sfruttare ed utilizzare la libreria. Viene costruito un form di esempio con tutti gli items disponibili.

# Generare XCFramework

Per poter utilizzare il framework nel proprio progetto, dopo aver fatto il *clone* del repository è necessario generare un **XCFramework** e per farlo bisogna eseguire una serie di passaggi senza i quali sarà impossibile utilizzare la libreriaa. 

## Primo step
Aprire il terminale e posizionarsi nella cartella del framework. Copiare il comando segunte e incollarlo nel terminale

```
xcodebuild archive \
 -scheme VTRFormBuilder \
 -archivePath ~/Desktop/VTRFormBuilder-iphonesimulator.xcarchive \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO
```

Questo comando farà un build del progetto e genererà un file xcarchive contenente il framework per simulatore. Il file sarà salvato sul desktop.

## Secondo step

Rimanendo nella cartella del framework, copiare il comando seguente ed incollarlo nel terminale.

```
xcodebuild archive \
 -scheme VTRFormBuilder \
 -archivePath ~/Desktop/VTRFormBuilder-iphoneos.xcarchive \
 -sdk iphoneos \
 SKIP_INSTALL=NO
```

Questo comando farà un build del progetto e genererà un file xcarchive contenente il framework per dispositivi fisici. Il file sarà salvato sul desktop.
  
Dalla cartella del framework digitare il seguente comando per generare XCFramework

## Ultimo step

Rimanendo nella cartella del framework, copiare il comando seguente ed incollarlo nel terminale.

```
xcodebuild -create-xcframework \
 -framework ~/Desktop/VTRFormBuilder-iphonesimulator.xcarchive/Products/Library/Frameworks/VTRFormBuilder.framework \
 -framework ~/Desktop/VTRFormBuilder-iphoneos.xcarchive/Products/Library/Frameworks/VTRFormBuilder.framework \
 -output ~/Desktop/VTRFormBuilder.xcframework
 ```

 Questo comando prenderà i due file generati in precedenza e li unirà in un unico contenitore con estensione **xcframework** che sarà il framework vero e proprio che andremo ad importare nel nostro progetto. Il file verrà salvato sul desktop, ma cambiando la destinazione nello script, si potrà salvare il file in un'altra directory a nostra scelta.

# Importare framework nel progetto

Per poter utilizzare il framework, è necessario importarlo nel nostro progetto e l'operazione è estremamente semplice.  
Sulla destra, nel *project navigator* selezionare il nostro progetto e successivamente, sulla destra, selezionamo il target sul quale vogliamo aggiungere il file.   
Nel tab *General*, scorrere fino a *Frameworks, Libraries, and Embedded Content* e trascinare il file xcframework generato in in questa sezione. In automatico verrà selezionato il corretto valore nella sezione Embed, che dovrà essere *Embed & Sign*

![framework-embed]

# Creare un form

Per creare un form, sarà sufficiente inserire nel nostro view controller una table view, l'elemento sul quale sono costruiti gli item, e instanziare un oggetto di tipo FormBuilder. A questo va passato l'array di items che deve essere visualizzato e successivamente avviare il load dei campi. Di seguito un esempio della costruzione di un form con un solo campo.

```Swift
import VTRFormBuilder

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    private var formBuilder = FormBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBuilder()
    }
    
    private func loadBuilder() {
        let items = loadSampleItems()
        formBuilder.set(items: items)
        formBuilder.loadData(on: table)
    }
    
    fileprivate func loadSampleItems() -> [FormItem] {
        var items = [FormItem]()
        let textItem = FormItem(named: "username", valueType: .firstname)
            .title("Nome utente")
            .placeholder("Inserisci il tuo nome")
            .isMandatory(true)
            .uiProperties(
                FormItemUIProperties(itemType: .textfield)
                    .keyboardType(.default)
                    .textFieldPropertie(
                        FormItemTextFieldProperty()
                            .cornerRadius(CGFloat(4))
                            .border(color: .white, width: .thin)
                            .leftPaggind(.large)
                        
                    )
            )
        items.append( firstnameItem )

        return items
    }
}
```

# Esploriamo VetryaFormBuilder

La libreria permette di generare vari tipi di form item, e per ognuno di essi c'è la possibilità di personalizzare il comportamento e l'aspetto. Questi sono gli items che si possono creare:

- [TextField Item](###1.-TextField-Item)
- [Date Picker Field Item](###2.-Date-Picker-Field-Item)
- [Values Picker Field Item](###3-Values-Picker-Field-Item)
- [Link Field Item](###4-Link-Field-Item)
- [Labelled Field Item](###5-Labelled-Field-Item)
- [Checkbox Field Item](###6-Checkbox-Field-Item)
- [Separator](###7.-Separator)
- [Button Field Item](###8-Button-Field-Item)

### 1. TextField Item
Item di tipo TextField, e come dice il nome stesso genera un elemento composto da un textfield, una label superiore come nome dell'elemento e una label di errore che viene mostrata se, in fase di validazione, si verificano degli errori. È possibile inserire liberamente del testo.

```Swift
FormItem(named: "nome", valueType: .firstname)
    .title("Nome utente")
    .placeholder("Inserisci il tuo nome")
    .isMandatory(true)
    .uiProperties(
        FormItemUIProperties(itemType: .textfield)
            .keyboardType(.default)
            .textFieldPropertie(
                FormItemTextFieldProperty()
                    .cornerRadius(CGFloat(4))
                    .border(color: .white, width: .thin)
                    .leftPaggind(.large)
                
            )
    )
```

### 2. Date Picker Field Item

Item per la selezione di una data composto da un textfield che quando viene selezionato apre un date picker. La data può essere customizzata impostando dei range custom o abilitare o meno date precedenti a 18 anni prima del momento in cui si apre il picker (ad esempio per non permettere l'inserimento di anni di nascita inferiori alla maggiore età).

```Swift
FormItem(named: "dateItem", valueType: .date)
    .title("Seleziona la data")
    .placeholder("Data di nascita")
    .isMandatory(true)
    .uiProperties(
        FormItemUIProperties(itemType: .datePicker)
            .textFieldPropertie(
                FormItemTextFieldProperty()
                    .cornerRadius(CGFloat(4))
                    .border(color: .white, width: .thin)
                    .leftPaggind(.large)   
            )
    )
    .pickerProperties(
        FormItemPickerProperties(doneButtonTitle: "Seleziona", cancelButtonTitle: "Annulla")
            .avoidLegalAge(true)
    )
```
### 3. Values Picker Field Item

Item di tipo picker con valori definiti. Non è possibile inserire testo liberamente ma solo selezionando il valore da un picker, i cui elementi sono specificati nell'array **pickerValues**

```Swift
let pickerItem = FormItem(named: "pickerWithValues", valueType: .text)
    .title("Primi piatti romani")
    .placeholder("Scegli un piatto")
    .uiProperties(
        FormItemUIProperties(itemType: .valuePicker)
            .keyboardType(.default)
            .textFieldPropertie(
                FormItemTextFieldProperty()
                    .cornerRadius(CGFloat(4))
                    .border(color: .white, width: .thin)
                    .leftPaggind(.large)
                
            )
    )
    .pickerProperties(
        FormItemPickerProperties(doneButtonTitle: "Seleziona", cancelButtonTitle: "Annulla")
    )
    .pickerValues(values:[
        PickerValue(title: "Carbonara", value: "1"),
        PickerValue(title: "Amatriciana", value: "2"),
        PickerValue(title: "Gricia", value: "3")
    ])
```
### 4. Link Field Item
```Swift
// This is only for demo porpouse. This object should be recovered by API call
var policy = PolicyModel()
policy.id = "id"
policy.isAccepted = false
policy.isRequired = true

let linkItem = FormItem(named: "linkItem", valueType: .checkbox)
    .title("Collegati su vetrya web site", underlined: "vetrya web site")
    .link( URL(string: "https://www.vetrya.com/it") )
    .isMandatory(policy.isRequired)
    .policy(policy)
    .uiProperties(
        FormItemUIProperties(itemType: .link)
            .textColor(.white)
            .underlinedColor(.yellow)
    )
```
### 5. Labelled Field Item
Un item contenente solo testo, senza azioni o operazione alcuna. Serve per inserire messaggi per l'utente. Può essere customizzato come gli altri campi. Su questo item la proprietà title viene ignorata e al suo posto va usata **value**.

```Swift
FormItem(named: "labelItem", valueType: .discardable)
    .value("Questo è un campo di solo testo. Usato per inserire una descrizione, un messaggio o una informazione particolare a cui non corrisponde nessuna azione.")
    .uiProperties(
        FormItemUIProperties(itemType: .text)
            .textColor(.white)
            .fontSize(CGFloat(17))
            .alignment(.center)
    )
```
### 6. Checkbox Field Item
Attualmente il checkbox field item è molto simile al tipo link field con la differenza che il tipo checkbox non prevede l'apertura di un link al click della label. Viene usato come flag. Si possono agganciare delle azioni da compiere a seguito dell'operazione di check o uncheck.

```Swift
FormItem(named: "checkboxItem", valueType: .checkbox)
    .title("Questo è un campo checkbox")
    .uiProperties(
        FormItemUIProperties(itemType: .checkbox)
            .textColor(.white)
    )
```
### 7. Separator

Semplice elemento di separazione composto da una linea orizzontale. Può essere colorata con un colore personalizzato. il tipo **.discardable** fa si che l'item venga ignorato in fase di validazione.

```Swift
FormItem(named: "separator", valueType: .discardable)
    .uiProperties(
        FormItemUIProperties(itemType: .separator)
            .elementColor(.lightGray)
    )
```

### 8. Button Field Item

Crea una cella con un bottone. Quando viene selezionato il bottone, viene avviata la validazione del form. Se questa fallisce, vengono evidenziati i campi con errori con altrettanti messaggi di errore. Se la validazione va a buon fine, viene propagato il metodo **formItemsValidationSuccess**

```Swift
FormItem(named: "button", valueType: .discardable)
    .title("SAVE")
    .uiProperties(
        FormItemUIProperties(itemType: .button)
    )
```

# Il FormItem

FormItem è l'oggetto principale, il form builder prevede un array di FormItem come parametro e che, manipolati a seconda delle loro impostazioni, daranno vita al form. Esso, così come tutti gli elementi che compongono il form builder, è costrutio seguendo il [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern). L'oggetto FormItem ha un numero elevato di proprietà che rende il settaggio di queste un lavoro molto lungo, ma grazie a questo design pattern il setting delle proprietà è facilitato, in più, si possono creare nuovi oggetti partendo da quelli esistenti modificando solo alcune proprietà senza dover generare un nuovo oggetto da zero.

## Creare un FormItem

Il FormItem viene creato richiamando il suo costruttore (ne ha uno soltanto)
```Swift
FormItem(named: "username", valueType: .firstname)
```
a cui vanno passati due parametri fondamentali:
- named: di tipo **String**, è il nome che viene assegnato all'elemento. Necessario in fase di recupero dei dati a seguito della validazione. Per evitare problemi di validazione, è importante che questo nome sia univoco.
- valueType: oggetto [ValueItemType](#I-tipi-di-ValueItemType) indica il tipo di valore che sarà contenuto nel campo di testo. Questo parametro sarà molto importante soprattutto in fase di validazione perchè ne deciderà le regole della validazione stessa.

## Le proprietà

Per ogni form item, si possono settare varie proprietà e ognuna di esse ha uno scopo ben perciso. Alcune possono essere omesse, altre sono necessarie alla corretta visualizzazione dell'elemento.

### Title

**title** è di tipo String. Ogni elemento è composto da una label superiore che indica il nome del campo. Il valore che viene visualizzato, è preso dalla proprietà title. Nell'esempio sopra, il textfield generato, avrà una label superiore con scritto **Nome utente**

```Swift
.title("Nome utente")
```

In caso di item con link, è possibile impostare la variabile titolo e parte del testo che dovrà essere sottolineata.

```Swift
.title("Questo sarà sottolineato", underlined: "sottolineato")
```
Se l'item di tipo link viene instanziato con solo la proprietà title, questa sarà tutta sottolineata

### Value

**value** è di tipo Any ed è optional e rappresenta il valore del campo. Se, ad esempio, costruendo un form di tipo textfield volessimo impostare un valore di default, basterebbe valorizzare la proprietà **value**. In fase di validazione, il valore impostato di **ValueItemType** ne definisce il comportamento e il casting al suo tipo reale. Quando un elemento viene valorizzato, value ne prende il valore e lo mantiene in memoria.

```Swift
.value("Alessandro")
```

### Placeholder

**placeholder** è di tipo String ed è optional. È il valore che viene visualizzato come placeholder nei textfield. Questo valore non è obbligatorio e se specificato per elementi che non prevedono placeholder (campi testuali o checkbox ad esempio), esso viene ignorato. Nell'esempio sopra, il textfield generato, avrà un placeholder con scritto **Inserisci il tuo nome**

```Swift
.placeholder("Inserisci il tuo nome")
```

### isMandatory

**isMandatory** è di tipo Bool e il valore di default è false. Specifica se un elemento è obbligatorio o meno. In caso di elemento obbligatorio, un asterisco viene posto sul nome del campo. Influenza il comportamento in fase di validazione dove, a seconda del suo valore, viene effetuato un controllo sulla presenza o meno della proprietà **value**. 

```Swift
.isMandatory(true)
```

## Le proprietà grafiche

È possibile personalizzare gli item anche dal punto di vista grafico personalizzando aspetto, colori, forma e altro e andando a modificare la proprietà **FormItemUIProperties**.

### L'oggetto FormItemUIProperties
La customizzazione grafica si realizza configurando la proprietà **uiProperties** che richiede l'oggetto **FormItemUIProperties** che va instanziato con il suo costruttore.
```Swift
.uiProperties(
    FormItemUIProperties(itemType: .textfield)
)
```
dove itemType è un oggetto di tipo [FormItemCellType](#-Il-FormItemCellType). Questa proprietà indica il tipo di cella che sarà visualizzata. Di seguito altre proprietà dell'oggetto.

### ErrorColor

**errorColor** di tipo UIColor è la proprietà che indica il colore degli elementi di errore quando, dopo la validazione, si verificano degli errori che devono essere mostrati all'utente. Il valore di default è **UIColor.red**

```Swift
.errorColor(.red)
```

### KeyboardType

**keyboardType** di tipo UIKeyboardType è la proprietà che indica il tipo di tastiera che dovrà essere visualizzata quando il textfield viene selezionato. Se non specificato, viene mostrata la tastiera di default. Per tutti gli item dove non è previsto che la tastiera venga mostrata a vidoe, anche se impostata questa proprietà sarà ignorata.

```Swift
.keyboardType(.default)
```

### Font

**font** impostazione di un font personalizzato per tutte le comoponenti testuali dell'item.

```Swift
.font(UIFont(name: "Arial", size: CGFloat(15))
```

### FontSize

**fontSize** impostare la grandezza del font mantenendo quello di default degli item.

```Swift
.fontSize(CGFloat(15))
```

### TextAlignment

**textAlignment** di tipo NSTextAlignment specifica l'allineamento del testo.

```Swift
.alignment(.left)
```

# Le regole del campo password

Per i campi di tipo password è possibile definire delle regole di validazione per il campo. Queste possono essere definite impostando la proprietà **FormItemPasswordProperty**. La proprietà fa parte del FormItem e se configurata su altri elementi, queste verranno ignorate.

```Swift
.passwordRules(FormItemPasswordProperty())
```

### Lunghezza minima consentita

È possibile specificare una lunghezza minima per la password. Di default è 8 caratteri e non può essere impostata inferiore a 3 o superiore alla lunghezza massima

```Swift
.minLength(3)
```

### Lunghezza massima consentita

È possibile specificare una lunghezza massima per la password. Di default è 40 caratteri e non può essere impostata inferiore alla lunghezza minima

```Swift
.maxLength(35)
```
### Lettere maiuscole

È possibile specificare se la password deve contenere almeno una lettera maiuscola. Di default è impostato su **false**

```Swift
.needUppercasedLetters(true)
```

### Lettere minuscole

È possibile specificare se la password deve contenere almeno una lettera minuscola. Di default è impostato su **true**

```Swift
.needLowercasedLetter(false)
```

### Numeri

È possibile specificare se la password deve contenere almeno un numero. Di default è impostato su **false**

```Swift
.needNumber(true)
```

### Caratteri speciali

È possibile specificare se la password deve contenere almeno un carattere speciale. Di default è impostato su **false**. I caratteri speciali sono uno tra:
- \# (cancelletto)
- ? (punto interrogativo)
- ! (punto esclamativo)
- @ (chiocciola)
- $ (dollaro)
- % (percentuale)
- ^ (...)
- & (e commerciale)
- \* (asterisco)
- £ (segno della sterlina)
- | (pipe)
- ) (parentesi tonda chiusa)
- ( (parentesi tonda aperta)
- \- (trattino)
- _ (underscore)
- ; (punto e virgola)
- , (virgola)
- = (uguale)

```Swift
.needSpecialChar(true)
```

# Checkbox actions

Ai campi di tipo checkbox, possono essere agganciate delle azioni da compiere a seguito del check o uncheck del flag. Il FormItem ha come proprietà, un array di **ActionItem** che rappresenta le operazioni da eseguire.

## ActionItem

L'ActionItem è un oggetto con 2 proprietà:

- itemName: di tipo Stringa che è il nome dell'item su cui effettuare l'operazione;
- action: di tipo **ActionType**, un enum di operazioni disponibili.

## ActionType

Enumeratore che specifica le azioni possibili a seguito di una determinata operazione compiuta su un campo. Le operazioni al momento sono:

```Swift
public enum ActionType {
    case editing
    case visibility
}
````

### editing
Se l'azione specificata è di tipo **editing** a seguito di una determinata operazione (click del checkbox) il o gli items specificati verrano attivati o disattivati. Ad esempio un campo di testo verrà attivato in modo che l'utente possa inserire del testo.

### visibility
Se l'azione specificata è di tipo **visibility** a seguito di una determinata operazione (click del checkbox) il o gli items specificati verrano visualizzati o nascosti. Ad esempio un campo di testo verrà mostrato in modo che l'utente possa inserire del testo.


# Il ValueItemType

Ogni item può contenere un tipo di dato e questo, deve essere specificato in fase di inizializzazione del FormItem. Nota speciale per il tipo **discardable** che permette di ignorare l'elemento in fase di validazione. Gli items di tipo discardable, non solo vengono ignorati in fase di validazione, ma non vengono restituiti tra gli items validati. In sostanza, l'elemento verrà disegnato nel form ma completamente ignorato in ogni altra fase.

```Swift
public enum ValueItemType {
    // item with free text entry
    case text
    // First nama field
    case firstname
    // Lastname field
    case lastname
    // Username field
    case username
    // Email field
    case email
    // Password field
    case password
    // Password field
    case confirmPassword
    // Date field
    case date
    // Phone number field
    case phonenumber
    // Fiscal code field
    case fiscalCode
    // Checkbox field
    case checkbox
    // Field to be discarded during validation
    case discardable
}
```

# Il FormItemCellType

Ogni item può essere renderizzato in base alle nostre necessità e per fare ciò, bisogna specificare il tipo di cella di cui abbiamo bisogno. Nel caso in cui, nessuna tipologia viene specificata, viene creato una cella di tipo textfield.

```Swift
public enum FormItemCellType {
    /// Textfield cell
    case textfield
    /// Date picker textfield
    case datePicker
    /// Picker with custom values
    case valuePicker
    /// Checkbox item
    case checkbox
    /// Cell with tappable link
    case link
    /// Cell with text (label)
    case text
    /// Cell with button (validate)
    case button
}
```

# VetryaFormBuilder messaggi di errore

Quando un form item viene marcato come obbligatorio, in automatico si avvia la gestione dei messaggi di errore che possono essere visualizzati in fase di validazione del form. Il builder prevede dei messaggi standard ma questi possono essere personalizzati con dei messaggi custom.

## VTRMessage

È la classe che gestisce i messaggi di errore visualizzati in fase di validazione non andata a buon fine. Sono visualizzati sotto i vari item come una stringa rossa. I messaggi gestiti sono:

- [Campo obbligatorio](###Campo-obbligatorio)
- [Valore diverso da Stringa](###Valore-diverso-da-Stringa)
- [Dependency item vuoto](###Dependency-item-vuoto)
- [Dependency item valore diverso](###Dependency-item-valore-diverso)
- [Dependency item indefinito](###Dependency-item-indefinito)
- [Controllo valore inserito](###Controllo-valore-inserito)
- [E-mail non valida](###E-mail-non-valida)
- [Password non valida](###Password-non-valida)
- [Unmatched password](###Unmatched-password)
- [Codice fiscale non valido](###Codice-fiscale-non-valido)
- [Telefono non valido](###Telefono-non-valido)

### Campo obbligatorio

Un form item obbligatorio (isMandatory) se non valorizzato in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **Il campo è obbligatorio**. Per customizzare:

```Swift
VTRMessage.mandatoryError = "Il mio messaggio custom"
```

### Valore diverso da Stringa

Un form item in cui si è associato un valore di tipo stringa ma che viene valorizzato con un tipo di valore diverso, in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **Il valore deve essere una stringa**. Per customizzare:

```Swift
VTRMessage.stringValueNotFoundError = "Il mio messaggio custom"
```

### Dependency item vuoto

Un form item che ha una dipendenza di tipo **fill** con un secondo secondo form item che non viene valorizzato, in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **Il campo \(FIELD_NAME) deve essere valorizzato** (dove FIELD_NAME viene sostituito con il valore **title** dell'item dipendente). Per customizzare:

```Swift
VTRMessage.dependecyUnfilledError = "Il mio messaggio custom"
```

### Dependency item valore diverso

Un form item che ha una dipendenza di tipo **equal** con un secondo secondo form item che non viene valorizzato o che viene valorizzato con un valore diverso, in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **Il valore non coincide con \(FIELD_NAME)** (dove FIELD_NAME viene sostituito con il valore **title** dell'item dipendente). Per customizzare:

```Swift
VTRMessage.dependecyUnmatchError = "Il mio messaggio custom"
```

### Dependency item indefinito

Un form item che ha una dipendenza di tipo indefinito (per errore durante la creazione del form) con un secondo secondo form item, in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **Il campo ha una dipendenza ma di tipo indefinito**. Per customizzare:

```Swift
VTRMessage.undefinedDependecyError = "Il mio messaggio custom"
```

### Controllo valore inserito

Un form item che ha un valore errato, o comunque diverso da quello che ci si aspetta di trovare, in fase di validazione genera un errore. Un esempio, potrebbe essere che in un campo di tipo **firstname** siano stati inseriti solo numeri. Il messaggio di default che viene visualizzato è **Controlla il valore inserito**. Per customizzare:

```Swift
VTRMessage.checkValueError = "Il mio messaggio custom"
```

### E-mail non valida

Un form item di tipo e-mail che contiene un valore errato (una mail non completa sintatticamente), in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è **E-mail non valida**. Per customizzare:

```Swift
VTRMessage.invalidMailError = "Il mio messaggio custom"
```

### Password non valida

Un form item di tipo password che contiene un valore non conforme alle regole stabilite numero minimo e massimo di caratteri, presenza o meno di lettere maiuscole e minuscole, numeri, caratteri e speciali, in fase di validazione genera un errore. Il messaggio di default che viene visualizzato è composto dalle regole attive o meno specificate. Per customizzare:

```Swift
VTRMessage.invalidPasswordError = "Il mio messaggio custom"
```

### Unmatched password

Un form item di tipo conferma password che contiene un valore non uguale a quello del campo password, in fase di validazione genera un messaggio di errore. Il messaggio di default che viene visualizzato è **Le password non coincidono**. Per customizzare:

```Swift
VTRMessage.unmatchPasswordError = "Il mio messaggio custom"
```

### Codice fiscale non valido

Un form item di tipo codice fiscale che contiene un valore errato (errore di tipo sintattico), in fase di validazione genera un messaggio di errore. Il messaggio di default che viene visualizzato è **Codice fiscale non valido**. Per customizzare:

```Swift
VTRMessage.invalidFiscalCodeError = "Il mio messaggio custom"
```

### Telefono non valido

Un form item di tipo phone number che contiene un valore errato (errore di tipo sintattico), in fase di validazione genera un messaggio di errore. Il messaggio di default che viene visualizzato è **Numero di telefono non valido**. Per customizzare:

```Swift
VTRMessage.invalidPhoneNumberError = "Il mio messaggio custom"
```

# VetryaFormBuilder console logging
VetryaFormBuilder genera dei log in console per decodificare le operazioni fatte. I livelli di log sono 2:
- verbose
- warning  

Di default la modalità predefinita è **verbose** che stampa tutti i log sulla console ma questa può essere modificata impostando il tipo **warning** in modo che vengano stampate solo le informazioni in caso di errore. Per cambiare il livello di warning, aggiungere la seguente riga nel AppDelegate

```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    VetryaConf.logLevel = .verbose
    return true
}
````

[form-builder-logo]:
[framework-embed]:./img/frameworks_embed.png "Frameworks, Libraries, and Embedded Content"