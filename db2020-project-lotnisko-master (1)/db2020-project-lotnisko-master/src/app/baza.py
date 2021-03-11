import pymysql

def showLoty():
    connection = pymysql.connect("localhost","root","","lotnisko")
    cursor=connection.cursor()
    query="SELECT lot.lotID,lot.dephour,lot.arrhour,origin.miasto,destination.miasto from lot INNER JOIN miasto AS origin on lot.originID=origin.miastoID INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID"
    try:
        cursor.execute(query);
        for r in cursor.fetchall():
            print("ID lotu",r[0], "Godzina odlotu", r[1],"Godzina przylotu",r[2],"Z",r[3],"do",r[4])

    except Exception as e:
        print("Exception:",e)
    connection.close();
def showJedenLot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query="SELECT lot.lotID,lot.dephour,lot.arrhour,origin.miasto,destination.miasto,pilot.imie,pilot.nazwisko,samolot.model from lot INNER JOIN miasto AS origin on lot.originID=origin.miastoID INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID INNER JOIN pilot on lot.pilotID=pilot.pilotID INNER JOIN samolot on lot.samolotID=samolot.samolotID where lot.lotID=%s;"
    showLoty()
    print("Wpisz id lotu, na temat którego chcesz mieć szczegółowe informacje")
    wybor = int(input())
    try:
        cursor.execute(query,wybor);
        for r in cursor.fetchall():
            print("ID lotu",r[0], "Godzina odlotu", r[1],"Godzina przylotu",r[2],"Z",r[3],"do",r[4],"Pilot",r[5],r[6],"Samolot",r[7])

    except Exception as e:
        print("Exception:",e)
    connection.close();

def showloty():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query = "SELECT lot.lotID,lot.dephour,lot.arrhour,origin.miasto,destination.miasto,pilot.imie,pilot.nazwisko,samolot.model from lot INNER JOIN miasto AS origin on lot.originID=origin.miastoID INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID INNER JOIN pilot on lot.pilotID=pilot.pilotID INNER JOIN samolot on lot.samolotID=samolot.samolotID;"
    cursor.execute(query);
    for r in cursor.fetchall():
        print("ID lotu", r[0], " Godzina odlotu ", r[1], " | Godzina przylotu", r[2], " | Z", r[3], "DO", r[4], " | Pilot - ", r[5],
              r[6], " | Samolot - ", r[7])

def dodajPasazera(imie,nazwisko,haslo):
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query="INSERT INTO pasazer (imie,nazwisko,haslo) VALUES (%s,%s,%s);"
    arg=(imie,nazwisko,haslo)
    try:
        cursor.execute(query, arg)
        connection.commit()
        connection.close()
    except Exception as e:
        print("Exception:",e)


def czyPasazerWBazie():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query="SELECT COUNT(pasazerID) FROM pasazer WHERE imie LIKE %s AND nazwisko LIKE %s AND haslo LIKE %s"
    print("Wpisz swoje imie")
    imie=input()
    print("Wpisz swoje nazwisko")
    nazwisko=input()
    print("Wpisz swoje haslo")
    haslo=input()
    arg=(imie,nazwisko,haslo)
    try:
       cursor.execute(query,arg)
       licznik=cursor.fetchone()
       #print("Liczba osób o podanych danych w bazie:",licznik[0])

       if licznik[0]==0:
           print("Nie ma cię w bazie pasażerów")
           print("Czy chciałbyś się w niej znaleźć? T/N")
           wybor=input()
           wybordokonany=0
           while wybordokonany==0:
            if wybor=="T":
               connection.close()
               dodajPasazera(imie,nazwisko,haslo)
               wybordokonany=1
            elif wybor=="N":
                connection.close()
                wybordokonany = 1
                return 0
            else:
                print("Dokonaj prawidłowego wyboru!!!")
                wybor = input()
       else:
           print("Już znajdujesz się w bazie")
           connection.close()
    except Exception as e:
        print("Exception:",e)

def kupBilet():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query="SELECT pasazerID FROM pasazer WHERE imie LIKE %s AND nazwisko LIKE %s AND haslo LIKE %s"
    print("Wpisz swoje imie")
    imie = input()
    print("Wpisz swoje nazwisko")
    nazwisko = input()
    print("Wpisz swoje haslo")
    haslo = input()

    arg = (imie, nazwisko,haslo)
    try:
       cursor.execute(query,arg)
       pasazerID=cursor.fetchone()
       pasazerID=pasazerID[0]
       print("Czy chcesz zobaczyc listę wszystkich lotów? T/N")
       wybor = input()
       wybordokonany = 0
       while wybordokonany == 0:
           if wybor == "T":
               showLoty()
               wybordokonany = 1
           elif wybor == "N":
               wybordokonany = 1
       print("Wpisz ID lotu, na który chcesz kupić bilet")
       lotID=input()
       arg=(pasazerID,lotID)
       query="INSERT INTO bilet (pasazerID, lotID, confirmed) VALUES (%s, %s, 0);"
       cursor.execute(query,arg)
       connection.commit()
       connection.close()

    except Exception as e:
        print("Exception:", e)


def pomocpilot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT imie, nazwisko FROM pilot;")
    i=1
    for row in cursor.fetchall():
        print("pilot nr ", i, " ", row[0], " ", row[1])
        i += 1
    connection.close()


def dodpilot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query = "INSERT INTO pilot (imie,nazwisko,wiek) VALUES (%s,%s,%s)"
    print("Podaj imie pilota")
    pimie = str(input())
    print("Podaj nazwisko pilota")
    pnazwisko = str(input())
    print("Podaj wiek pilota")
    pwiek = str(input())
    cursor.execute(query,(pimie, pnazwisko, pwiek))
    connection.commit()
    pomocpilot()
    connection.close()


def dodpolaczenie():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query = "INSERT INTO lot (originID,destinationID,pilotID,samolotID,dephour,arrhour) VALUES(%s,%s,%s,%s,%s,%s)"
    print()
    showomiasto()
    print("Podaj ID miasta z ktorego samolot wylatuje")
    pori = int(input())
    print("Podaj ID miasta do ktorego samolot przylatuje")
    pdes = int(input())
    while pori == pdes:
        print("wybrano to samo miasto docelowe!, prosze wybrac ponownie miejsce docelowe")
        pdes = int(input())
    print("podaj id pilota")
    ppil = int(input())
    print("podaj id samolotu")
    psam = int(input())
    print("podaj godzine wyloty (format 00:00:00)")
    pdep = str(input())
    print("podaj godzine przylotu (format 00:00:00)")
    parr = str(input())
    arg = (pori, pdes, ppil, psam, pdep, parr)
    cursor.execute(query, arg)
    connection.commit()
    #showJedenLot()
    connection.close()


def showomiasto():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT miasto, panstwo FROM miasto;")
    i=1
    for row in cursor.fetchall():
        print(i, " ", row[0], " ", row[1])
        i += 1
    connection.close()

def dodsamolot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query="INSERT INTO samolot (model,rocznik,pojemnosc) VALUES (%s,%s,%s)"
    print("Podaj model nowego samolotu")
    nmodel=str(input())
    print("Podaj rocznik nowego samolotu")
    nrocznik=str(input())
    print("Podaj liczbe miejsc w samolocie")
    npojemnosc=str(input())
    poj = (nmodel, nrocznik, npojemnosc)
    cursor.execute(query, poj)
    connection.commit()
    print("Wypisac wszystkie samoloty? (T/N)")
    x=input()
    if x == "T":
        showsamoloty()
    connection.close()

def showsamoloty():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM samolot")
    i = 1
    for row in cursor.fetchall():
        print("ID samolotu", " ",row[0], " ",row[1], " ", row[2], "Pojemnosc", row[3])
        i += 1
    connection.close()

def delpilot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query=" DELETE FROM pilot WHERE imie LIKE %s and nazwisko LIKE %s"
    showfreepilots()
    print("Podaj Imie pilota którego chcesz zwolnić")
    dimie=input()
    print("Podaj nazwisko pilota którego chcesz zwolnić")
    dnaziwsko=input()
    dana=(dimie, dnaziwsko)
    cursor.execute(query, dana)
    connection.commit()
    print("Wyświetlić liste pilotów? (T/N)")
    y=input()
    if y=="T":
        showpilot()
    connection.close()



def showpilot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM pilot")
    i = 1
    for row in cursor.fetchall():
        print("ID pilota", " ", row[0], "  ", row[1], " ", row[2], "wiek: ", row[3])
        i += 1
    connection.close()

def showfreesamolot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT * from samolot WHERE samolotID IN (SELECT samolotID from samolot EXCEPT SELECT samolotID from lot)")
    i = 1
    for row in cursor.fetchall():
        print("ID samolotu", " ", row[0], "  ", row[1], " ", row[2], "pojemnosc: ", row[3])
        i += 1
    connection.close()

def showfreepilots():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT * from pilot WHERE pilotID IN (SELECT pilotID from pilot EXCEPT SELECT pilotID from lot) ORDER BY wiek;")
    i = 1
    for row in cursor.fetchall():
        print("ID pilota", " ", row[0], "  ", row[1], " ", row[2], "wiek: ", row[3])
        i += 1
    connection.close()


def changepilot():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query= "UPDATE lot SET pilotID=%s  WHERE lotID=%s"
    print("Wolni piloci")
    showfreepilots()
    print("Podaj ID pilota ktory ma odbyc lot")
    xlot=input()
    showloty()
    print("Podaj ID lotu który dany pilot ma zastąpić")
    ylot=input()
    sarg=(xlot, ylot)
    cursor.execute(query,sarg)
    connection.commit()
    showloty()
    connection.close()

def zatbilet():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query= "UPDATE bilet SET confirmed=1 WHERE biletID=%s"
    showbilety()
    print("Podaj nr ID biletu którego chcesz zatwierdzić")
    rst=input()
    cursor.execute(query, rst)
    connection.commit()
    showbilety()
    connection.close()


def showbilety():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM bilet")
    i=1
    print("(1-tak / 0-nie)")
    for row in cursor.fetchall():
        print("ID biletu ", row[0], " | ID pasazera ", row[1]," | IDlotu", row[2], " | potwierdzenie: ", row[3])
        i += 1
    connection.close()


def showBilety():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query = "SELECT pasazerID FROM pasazer WHERE imie LIKE %s AND nazwisko LIKE %s AND haslo LIKE %s"
    print("Wpisz swoje imie")
    imie = input()
    print("Wpisz swoje nazwisko")
    nazwisko = input()
    print("Wpisz swoje haslo")
    haslo = input()
    arg=(imie,nazwisko,haslo)
    try:
       cursor.execute(query,arg)
       pasazerID=cursor.fetchone()
       pasazerID=pasazerID[0]
       query="SELECT bilet.biletID,lot.lotID,lot.dephour,lot.arrhour FROM bilet INNER JOIN pasazer on pasazer.pasazerID=bilet.pasazerID INNER JOIN lot on lot.lotID=bilet.lotID where bilet.pasazerID=%s"
       cursor.execute(query, pasazerID)
       bilety=cursor.fetchall()
       for r in bilety:
           print("ID biletu",r[0],"ID lotu",r[1],"Godzina odlotu",r[2],"Godzina przylotu",r[3])
           lotID=r[1]
           query="SELECT origin.miasto,destination.miasto from lot INNER JOIN miasto AS origin on lot.originID=origin.miastoID INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID WHERE lot.lotID=%s"
           cursor.execute(query,lotID)
           loty=cursor.fetchall()
           for r in loty:
               print("Z",r[0],"Do",r[1])




    except Exception as e:
        print("Exception:", e)
    finally:
        connection.close()

def zwrocBilet():
    connection = pymysql.connect("localhost", "root", "", "lotnisko")
    cursor = connection.cursor()
    query = "SELECT pasazerID FROM pasazer WHERE imie LIKE %s AND nazwisko LIKE %s AND haslo LIKE %s"
    print("Wpisz swoje imie")
    imie = input()
    print("Wpisz swoje nazwisko")
    nazwisko = input()
    print("Wpisz swoje haslo")
    haslo = input()
    arg = (imie, nazwisko, haslo)
    try:
        cursor.execute(query, arg)
        pasazerID = cursor.fetchone()
        pasazerID = pasazerID[0]
        query="SELECT biletID from bilet WHERE pasazerID=%s"
        cursor.execute(query,pasazerID)
        biletID=[]
        for r in cursor.fetchall():
            biletID.append(r[0])
        query="DELETE FROM bilet WHERE pasazerID LIKE %s and biletID LIKE %s"
        print("Podaj ID biletu, który chcialbys anulowac")
        id=int(input())
        poprawnywybor=0
        while poprawnywybor !=1:
            if id in biletID:
                poprawnywybor=1
                print("Bilet o podanym ID usunięty")
            else:
                print("Bilet o podanym ID nie należy do Ciebie! Wpisz ID jeszcze raz")
                id = int(input())
        arg=(pasazerID,id)
        cursor.execute(query,arg)
        connection.commit()
        connection.close()



    except Exception as e:
        print("Exception:", e)