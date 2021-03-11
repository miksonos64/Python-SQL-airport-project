from src.app.baza import *

def main():
    print("Witaj w programie obsługującym lotnisko")
    rola=0
    cond=0
    while (rola != 1) and  (rola != 2):
      print("Wybierz swoją rolę w systemie")
      print("1.Administrator systemu")
      print("2.Pasażer")
      rola=int(input("Wybierz 1 albo 2\n"))
    if rola==1:
        print("Witaj w panelu administratora systemu")
        while cond != 1:
            print("Wybierz jedną z poniższych opcji")
            print("1. Dodaj nowe połączenie lotnicze")
            print("2. Zatrudnij nowego pilota")
            print("3. Wprowadz nowo zakupiony samolot do bazy")
            print("4. Zwolnij pilota")
            print("5. Sprawdz wolne samoloty")
            print("6. Pokaż wszystkich wolnych pilotów")
            print("7. Zmień pilota mającego odbyć dany lot")
            print("8. Zatwierdź bilet")
            print("9. Wyłącz")
            wyborx = int(input())
            if wyborx == 1:
                dodpolaczenie()
                showloty()
                print()
            elif wyborx == 2:
                dodpilot()
                print()
            elif wyborx == 3:
                dodsamolot()
                print()
            elif wyborx == 4:
                delpilot()
                print()
            elif wyborx == 5:
                showfreesamolot()
                print()
            elif wyborx == 6:
                showfreepilots()
                print()
            elif wyborx == 7:
                changepilot()
                print()
            elif wyborx == 8:
                zatbilet()
                print()
            elif wyborx == 9:
                cond=1
            else:
                print("Dokonaj prawidłowego wyboru!!!")


    elif rola==2:

        print("Witamy w panelu dla pasażerów")
        while cond != 1:
            print("Wybierz z poniższych opcji")
            print("1. Sprawdź czy jesteś w bazie pasażerów")
            print("2. Pokaż wszystkie dostępne połączenia lotnicze")
            print("3. Wyświetl szczegółowe informacje o jednym locie")
            print("4. Kup bilet")
            print("5. Wyświetl moje bilety")
            print("6. Zwróć bilet")
            print("7. Wyłącz")
            wybor = int(input())
            if wybor == 1:
                czyPasazerWBazie()
            elif wybor == 2:
                showLoty()
            elif wybor == 3:
                showJedenLot()
            elif wybor == 4:
                kupBilet()
            elif wybor == 5:
                showBilety()
            elif wybor==6:
               zwrocBilet()
            elif wybor == 7:
                cond = 1
            else:
                print("Dokonaj prawidłowego wyboru!!!")



main()
