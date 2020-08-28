# Corona Help App

Einleitung
==========

Seit Ende 2019, mit der Coronavirus-Pandemie, erlebt die Welt eine der
schwersten Gesundheitskrisen seit dem Ende des Zweiten Weltkriegs. Die
Länder arbeiten daran, die Ausbreitung des Virus zu verlangsamen, indem
sie Patienten testen und behandeln, Kontakte und Reisen einschränken,
Bürger unter Quarantäne stellen und große Versammlungen wie
Sportveranstaltungen, Konzerte und Schulen absagen. Diese verschiedenen
Maßnahmen machen vielen Menschen das Leben schwer, insbesondere
gefährdeten Bevölkerungsgruppen, die gezwungen sind, in Quarantäne zu
bleiben und nicht mehr in der Lage sind, selbst einzukaufen.  
Das Ziel dieser Arbeit wird es sein, eine Anwendung zu entwickeln, die
es dem Benutzer ermöglicht, anderen Benutzern Dienste kostenlos
anzubieten und anzufordern.

Anforderungen
=============

Anwendungsfälle (Use Cases)
---------------------------

Im Folgenden werden die Szenarien dargestellt, die sich bei der
Verwendung der grundsätzlichen Funktionen der Corona-Help-App ergeben.
Die Abbildung
<a href="#fig:use_case_diagramm_Corona-Hep-App" data-reference-type="ref" data-reference="fig:use_case_diagramm_Corona-Hep-App">1</a>
stellt die möglichen Anwendungsfälle für die dar.

<figure>
<img src="images/map/use_case_diagramm_Corona-Hep-App.png" id="fig:use_case_diagramm_Corona-Hep-App" style="width:12.6cm" alt="Use Case Diagramm - . " /><figcaption aria-hidden="true">Use Case Diagramm - . </figcaption>
</figure>

### Erstellung, Änderung oder Löschung von Hilfsanträge

Es muss die Möglichkeit bestehen, Hilfsanträge hinzuzufügen, zu
verändern und zu löschen. Diese Funktionalitäten setzen eine voraus. Die
Szenarien dazu sind in Abschnitt
<a href="#sec:user_management" data-reference-type="ref" data-reference="sec:user_management">[sec:user_management]</a>
aufgeführt. Es wird notwendig, dass Hilfsanträge verändert werden
können. Der Grund dafür liegt in fehlerhaften Daten, die korrigiert oder
sogar gelöscht werden müssen. Zusammengefasst handelt es sich um <span
acronym-label="CRUD" acronym-form="singular+short">CRUD</span> Aktionen,
die auf Hilfsanträge angewandt werden können:

-   Der Benutzer möchte einen Hilfsantrag eintragen.

-   Der Benutzer möchte einen Hilfsantrag verändern.

-   Der Benutzer möchte einen falschen Hilfsantrag löschen.

### Erstellung, Änderung oder Löschung von Hilfsangebote

Es muss auch die Möglichkeit bestehen, Hilfsangebote hinzuzufügen, zu
verändern und zu löschen (Voraussetzung: ). Die Szenarien dazu sind in
Abschnitt
<a href="#sec:user_management" data-reference-type="ref" data-reference="sec:user_management">[sec:user_management]</a>
aufgeführt. Es wird notwendig, dass Hilfsangebote verändert werden
können. Der Grund dafür liegt in fehlerhaften Daten, die korrigiert oder
sogar gelöscht werden müssen. Zusammengefasst handelt es sich um <span
acronym-label="CRUD" acronym-form="singular+short">CRUD</span> Aktionen,
die auf Hilfsangebote angewandt werden können:

-   Der Benutzer möchte ein Hilfsangebot eintragen.

-   Der Benutzer möchte ein Hilfsangebot verändern.

-   Der Benutzer möchte ein Hilfsangebot löschen.

### Suche nach Hilfsanträge

Eine Funktion der Applikation ist die Suche nach Hilfsanträge. Es können
einzelne Anträge oder eine Liste von Anträge gesucht werden. Diese
Szenarien setzen sich auf Applikationsseite durch die folgenden
Unterpunkte zusammen:

-   Der Benutzer möchte die Liste aller Anträge in seiner Stadt sehen.

-   Der Benutzer möchte die Liste der Anträge nach Kategorien filtern.

### Suche nach Hilfsangebote

Eine Funktion der Applikation ist die Suche nach Hilfsangebote. Es
können einzelne Hilfsangebote oder eine Liste von Hilfsangebote gesucht
werden. Diese Szenarien setzen sich auf Applikationsseite durch die
folgenden Unterpunkte zusammen:

-   Der Benutzer möchte die Liste aller Hilfsangebote in seiner Stadt
    sehen.

-   Der Benutzer möchte die Liste der Hilfsangebote nach Kategorien
    filtern.

### Authentifizierung und Benutzerverwaltung

Ein sehr wichtiger Punkt in dieser Arbeit ist die Sicherheit und
Datenschutz. Aus diesem Grund muss sich jeder Benutzer, der die
Anwendung benutzt, authentifizieren. Somit wird sichergestellt, dass
ausschließlich berechtigte Benutzer Ressourcen suchen, erstellen,
verändern oder löschen dürfen. Die folgenden Szenarien werden definiert:

-   Der Benutzer möchte ein neues Konto anlegen.

-   Der Benutzer möchte seine Kontoinformationen einsehen und ändern.

-   Der Benutzer möchte ein Konto löschen.

-   Ein Benutzer möchte sich an seinem Konto an- oder abmelden.

Diese Szenarien bilden die Grundlage für eine typische
Benutzerverwaltung und können als <span acronym-label="CRUD"
acronym-form="singular+abbrv">CRUD</span>-Vorgänge für die
Benutzerressource angesehen werden.

Funktionale Anforderungen
-------------------------

Aus den in Abbildung
<a href="#fig:use_case_diagramm_Corona-Hep-App" data-reference-type="ref" data-reference="fig:use_case_diagramm_Corona-Hep-App">[fig:use_case_diagramm_Corona-Hep-App]</a>
erarbeiteten Anwendungsfällen können nun die funktionalen Anforderungen
abgeleitet werden. Aus den Benutzer-Szenarien bezüglich der
Funktionalität ergeben sich folgende Anforderungen:
1.  Als **User** möchte ich, dass der **Zugriff auf die App** über eine
    **Login-Prozedur** mit einem **Benutzernamen** und einem
    **Passwort** geschützt wird, damit meine **persönliche Daten
    vertraulich bleiben** und **nicht von dritten manipuliert** werden.

2.  Als **User** möchte ich die Möglichkeit haben, mein
    **Benutzerkonto** zu **erstellen**, Benutzerdaten **anzupassen** und
    mein Konto zu **löschen**.

3.  Als **User** möchte ich die Möglichkeit haben, eine **Liste aller
    Hilfsanträge bzw. Hilfsangebote** abzufragen, damit ich über die
    verschiedenen Anträge scrollen kann.

4.  Als **User** möchte ich die Möglichkeit haben, einen **einzelnen
    Hilfsantrag** bzw. ein **einzelnes Hilfsangebot** abzufragen, damit
    ich die **Details von diesem Hilfsantrag** bzw. **Hilfsangebot
    sehen** kann.

5.  Als **User** möchte ich die Möglichkeit haben, **neue Hilfsanträge
    bzw. Hilfsangebote hinzuzufügen**.

6.  Als **User** möchte ich die Möglichkeit haben, meine **Hilfsanträge
    bzw. Hilfsangebote** zu **verändern**, damit ich falsche Einträge
    korrigieren kann.

7.  Als **User** möchte ich die Möglichkeit haben, meine **Hilfsanträge
    bzw. Hilfsangebote** zu **löschen**, damit ich falsche Einträge
    komplett entfernen kann.

8.  Als **User** möchte ich, dass eine **eindeutige Farbe** für allen
    Einträge einer **bestimmten Kategorie** definiert wird.

9.  Als **User** möchte ich, dass das Farben-Thema der App entsprechend
    der **Dark-Mode-Einstellung** meines Handys angepasst wird.

Nicht-funktionale Anforderungen
-------------------------------

Damit die App in akzeptabler Weise verwendet werden kann, muss die App
bestimmte Kriterien erfüllen:
1.  **Installierbarkeit**: Die App soll auf Android und iOS Plattformen
    laufen.

2.  **Kompatibilität**: Die App soll mit Android 7.1.1 (Nougat) und
    höhere Versionen kompatibel sein.

3.  **Zeitverhalten**: Die App muss innerhalb von einer Sekunde auf
    Anfragen einzelner Ressourcen antworten. Bei Listenanfragen mit
    einer großen Anzahl von Ressourcen darf die Ausführung einer Anfrage
    maximal 3 Sekunden dauern.

4.  **Sicherheit**: Die Verbindung zwischen der App und der Server soll
    verschlüsselt werden.

5.  **Einfachheit**: Die App soll für den Benutzer möglichst
    verständlich sein. Dies wird durch eine logische Struktur und die
    Verwendung von bekannten und gut dokumentierten Techniken für die
    Implementierungen (Usability, Design, etc...) erreicht.

Entwurf und Architektur
=======================

System Architektur
------------------

Datenbankschema
---------------

Der Anwendung werden die folgenden Entitäten zugeordnet:

1.  **Die Benutzer (*USER*)**: Jeder Benutzer kann ein Konto erstellen,
    ändern oder löschen. Jeder Benutzer hat einen Benutzernamen , eine
    Rolle (Hilfeanbieter oder Hilfesuchender), einen Vor- und Nachnamen,
    eine E-Mail-Adresse sowie eine Beschreibung und einen Standort.

2.  **Die Servicekategorien (*CATEGORY*)**: Um Filterfunktionen
    implementieren zu können, ist es notwendig, die Dienste in
    Kategorien zu klassifizieren, was die Suche erleichtert. Eine
    Kategorie hat einen Namen und eine Beschreibung. Mehrere Leistungen
    können zur gleichen Kategorie gehören.

3.  **Die Services (*SERVICE*)**: Ein Service hat einen Hilfeanbieter,
    einen Hilfesuchender, eine Kategorie, einen Status, eine
    Beschreibung und ein Datum.

<figure>
<img src="images/map/database_schema_Corona-Help-App.png" id="fig:database_schema_Corona-Help-App" style="width:15cm" alt="Datenbankschema - Corona-Help-App. " /><figcaption aria-hidden="true">Datenbankschema - Corona-Help-App. </figcaption>
</figure>

Implementierung
===============

Entwicklungsumgebung und Tools
------------------------------

Für die Implementierung der App wird die Entwicklungsumgebung **Android
Studio** Version **4.0.1** verwendet. Zusätzlich werden **Flutter-** und
**Dart-SDKs** installiert.

Navigation
----------

eine **BottomNavigationBa**r wurde für die Navigation in der Anwendung
verwendet. alle Routen sind in der Tabelle **\_routes** enthalten.

    [language=Java,
    % linebackgroundcolor={%
    %         \ifnum\value{lstnumber}>1
    %             \ifnum\value{lstnumber}<4
    %                 \color{green!35}
    %             \fi
    %         \fi}
    ]
      static List<Widget> _routes = [
        HomePage(),
        CreateServicesPage(),
        ListMyServicesPage(),
        ProfilePage(),
        ConfigPage(),
      ];
        // ...
        
      Scaffold(
                body: _routes[_selectedIndex],
                bottomNavigationBar: BottomNavigationBar(),
        // ...

Light- und Dart-Modus
---------------------

Da die Anwendung auf die Änderungen der Systemhelligkeit reagieren soll,
wird der Parameter **darkTheme: DarkTheme()** in der **MaterialApp**
instanziiert. Die Themen hängen mit dem Modus des Parameters brightness
zusammen. Die Instanz von DarkTheme wird mit der parameter **brightness:
Brightness.Dark** initialisiert.

    class MyApp extends StatelessWidget {
      // ...
      
      static Color defaultPrimaryColor = Colors.orange;
      // ...
      
       child: MaterialApp(
                  title: 'Corona Help App',
                  theme: ThemeData(
                    primarySwatch: defaultPrimaryColor,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: defaultPrimaryColor,
                  ),
                  home: MyBottomNavigationBar(),
                ),
                // ...

Um herauszufinden, Welchen Wert die aktuelle System-Helligkeit hat, wird
die statische Methode **isDark()** geschrieben. Diese Methode verwendet
die Klasse **MediaQuery** auf dem Kontext. Wenn **platformBrightness**
gleich **Brightness.dark** ist, bedeutet dies, dass der Dunkelmodus
ausgewählt ist.

    class MyApp extends StatelessWidget {
      // ...
      static bool isDark(BuildContext context) {
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
      }
      // ...

User und Authentifizierung
--------------------------

### Input Validation

Die Klasse **ValidationService** wird zur Validierung von
Eingabeparametern bei der **Anmeldung** oder **Registrierung**
verwendet.

### AuthService

Für die Authentifizierung wird dem Package **firebase\_auth** in
**pubspeck.yaml** hinzugefügt. Zusätzliche Benutzerinformationen werden
mithilfe des **cloud\_firestore**-Pakets gespeichert.

    dependencies:
    # ...
      firebase_auth: ^0.16.1
      cloud_firestore: ^0.13.7
    # ... 

Die Klasse **AuthService** bildet die Schnittstelle zwischen der App und
Firebase. Hier werden die für die **Anmeldung**, **Registrierung**,
**Abmeldung** und **Konto-Löschung** definiert.

    // ...
    // ... 

### Test-User Generator

### Profile

Kategorien und Services
-----------------------

### Kategorien

### Services

#### Service erstellen

#### Service bearbeiten

#### Service löschen

#### Liste eigener Services

#### Liste der Services

Alternative Technologie
-----------------------
