import re
import urllib.request
import sys
import sqlite3
#MENU GŁÓWNE
#1 - Wyświetl listę produktow
#2 - Dodaj produkt
#3 - Modyfikuj dane
#4 - Usuń produkt
#0 - Wyjscie
#------------------------------
#Co chcesz zrobic:
i=0
conn = sqlite3.connect('test3.db')
#///////////////////////////////
cur=conn.cursor()

#tabela produktow
cur.execute('''CREATE TABLE IF NOT EXISTS produkty  
(IMIE   TEXT   PRIMARY KEY  NOT NULL,
KALORYCZNOSC    FLOAT    NOT NULL,
BIALKO          FLOAT    NOT NULL,
TLUSZCZ         FLOAT    NOT NULL,
WEGLOWODANY     FLOAT    NOT NULL,
KALORYCZNOSCmasa    FLOAT    NOT NULL,
BIALKOmasa          FLOAT    NOT NULL,
TLUSZCZmasa         FLOAT    NOT NULL,
WEGLOWODANYmasa     FLOAT    NOT NULL);''')

def menu():   #menu główne
    while i==0:
        
        wybor=int(input("\n\nMENU GŁÓWNE\n 1 - Wyświetl listę produktow\n 2 - Dodaj produkt\n 3 - Modyfikuj dane\n 4 - Usuń dane\n 0 - Wyjscie\n ------------------------------\n Co chcesz zrobic: "))
        if wybor==1:
            lista()
        elif wybor==2:
            dodawanie()
        elif wybor==3:
            modyfikuj()
        elif wybor==4:
            usun()
        elif wybor==0:
            sys.exit(0)
        else:
            print("Błąd")


def id():   # funkcja sprawdzajaca ile jest wprowadzonych produktow, sprawdza jakie jest biezace id
    numer=0
    conn = sqlite3.connect('test3.db') 

    cursor = conn.execute("SELECT imie, kalorycznosc, bialko, tluszcz, weglowodany,kalorycznoscmasa,bialkomasa,tluszczmasa,weglowodanymasa from produkty") 

    for row in cursor:
        numer=numer+1

    return numer

def lista():  #wyswietla zawartosc tabeli

    cursor = conn.execute("SELECT imie, kalorycznosc, bialko, tluszcz, weglowodany,kalorycznoscmasa,bialkomasa,tluszczmasa,weglowodanymasa from produkty")  

    for row in cursor:
        print (row[0],", ",row[1],", ",row[2],", ",row[3],", ",row[4],", ",row[5],", ",row[6],", ",row[7],", ",row[8])

    

def modyfikuj():    # aktualizacja danych

    im=str(input("Wprowadz nazwe produktu: "))
    im = str.capitalize(im)
    cur.execute('SELECT kalorycznosc FROM produkty WHERE imie = ?', (im,))  #pobieranie podst danych o produkcie o danym id dla masy 100g
    kal=float(cur.fetchone()[0])

    cur.execute('SELECT bialko FROM produkty WHERE imie = ?', (im,))
    bial= cur.fetchone()[0]

    cur.execute('SELECT tluszcz FROM produkty WHERE imie = ?', (im,))
    tl= cur.fetchone()[0]

    cur.execute('SELECT weglowodany FROM produkty WHERE imie = ?', (im,))
    weg=cur.fetchone()[0]
    
    masa=float(input("Podaj mase produktu (w gramach): "))
    masa=masa/100              # obliczanie wartosci odzywczej dla zadanej masy
    kal=round(kal*masa,2)
    bial=round(bial*masa,2)
    tl=round(tl*masa,2)
    weg=round(weg*masa,2)
    cur.execute("UPDATE produkty set kalorycznoscmasa =?,bialkomasa=?,tluszczmasa=?,weglowodanymasa=? where imie = ?",(kal,bial,tl,weg,im)) # aktualizacja
    
    conn.commit()
    print ("Rekord zmieniony" )
    #print (conn.total_changes )

    

def dodawanie():  # dodawanie produktu do bazy

    dane=[]  # pojemnik na wartosci odzywcze ze strony
    
    produkt = input("Wpisz nazwe produktu: ")
    imiona=[]  #pojemnik na nazwy produktow potrzebny do sprawdzania czy wprowadzanego produktu nie ma juz w bazie
    
    produkt = str.capitalize(produkt)

    
    if id()>=1:     #sprawdzanie czy produkt juz jest w bazie
        cursor = conn.execute("SELECT imie, kalorycznosc, bialko, tluszcz, weglowodany,kalorycznoscmasa,bialkomasa,tluszczmasa,weglowodanymasa from produkty")  
        for row in cursor:
            imiona.append(row[0])
        if produkt in imiona:   #sprawdzanie czy produkt juz jest w bazie
            print("Produkt został już wprowadzony")
        else:
            szukanie(produkt,dane)   #wywolanie funkcji sciagajacej dane ze strony internetowej
            if info==False:
                print("Nie ma takiego produktu")
            else:
                masa=float(input("Podaj mase produktu (w gramach): "))
                masa=masa/100
                kalorycznosc=round(dane[0]*masa,2) # obliczanie wartosci odżyw dla zadanej masy , z zaokraglaniem
                bialko=round(dane[1]*masa,2)
                tluszcz=round(dane[2]*masa,2)
                weglo=round(dane[3]*masa,2)
        
                cur.execute("INSERT INTO produkty VALUES(?,?,?,?,?,?,?,?,?)", \
                (produkt,dane[0],dane[1],dane[2],dane[3],kalorycznosc,bialko,tluszcz,weglo),); #wprowadzanie krotki do tabeli
                conn.commit() 

                print ("Rekord dodany" )
    else:  #jesli baza jest pusta
        szukanie(produkt,dane)
        if info==False:
            print("Nie ma takiego produktu")
        else:
            masa=float(input("Podaj mase produktu (w gramach): "))
            masa=masa/100
            kalorycznosc=round(dane[0]*masa,2) 
            bialko=round(dane[1]*masa,2)
            tluszcz=round(dane[2]*masa,2)
            weglo=round(dane[3]*masa,2)
        
            cur.execute("INSERT INTO produkty VALUES(?,?,?,?,?,?,?,?,?)", \
            (produkt,dane[0],dane[1],dane[2],dane[3],kalorycznosc,bialko,tluszcz,weglo),);  
            conn.commit() 

            print ("Rekord dodany" )
    
def usun():
    ident = str(input("Wpisz nazwe produktu ktorego chcesz usunac: "))
    ident = str.capitalize(ident)
    cur.execute('DELETE FROM produkty WHERE imie=?', (ident,))
    conn.commit()
    print ("Rekord usuniety" )
        

URL1 = "https://www.czasnatrenera.pl/czytelnia/tabela-wartosci-odzywczych.html"

def doRequest(url):
    #funkcja pomocnicza,łaczy sie z zadanycm adresem URL
    return urllib.request.urlopen(url).read().decode()

def wartosci_prod(pattern,zrodlo_strony,dane):
    global info  #flaga potrzebna aby okreslic czy szukany produkt jest na stronie internetwej
    info=True   
    wartosc = str(pattern.findall(zrodlo_strony))
    
    if wartosc == '[]':  # jesli nie znaleziono wzoru
        info=False
        
        
    else:
        pattern2= re.compile(r'a">.+?(?=<)')
        wartosc = str(pattern2.findall(wartosc))
        if wartosc == '[]':  # niektore produkty nie sa dostepne na stronie w wersji light, wiec kolejne sprawdzanie
            info=False
        else:
            wartosc=wartosc.split('>')
            nowy=wartosc[len(wartosc)-1]
            nowy=nowy.split('\'')
            nowy=nowy[0]
            nowy=nowy.replace(',','.')
            dane.append(float(nowy))
    return info

def szukanie(produkt,dane):
    print('-------------------------------------------------')

    zrodlo_strony = doRequest(URL1)
    #print(zrodlo_strony)

    #wyszukiwanie kalorycznosci ,bialka , tluszczow, weglowodanow danego produkt za pomoca wyrazen regularnych
    pattern = re.compile(r'<td class="pr">'+produkt+'</td>.+\n.+')
    wartosci_prod(pattern,zrodlo_strony,dane)

    pattern = re.compile(r'<td class="pr">'+produkt+'</td>.+\n.+\n.+')
    wartosci_prod(pattern,zrodlo_strony,dane)

    pattern = re.compile(r'<td class="pr">'+produkt+'</td>.+\n.+\n.+\n.+')
    wartosci_prod(pattern,zrodlo_strony,dane)

    pattern = re.compile(r'<td class="pr">'+produkt+'</td>.+\n.+\n.+\n.+\n.+')
    wartosci_prod(pattern,zrodlo_strony,dane)

    print (dane)

menu()
conn.close()
