-- Admin systemu
-- 1.Dodanie nowego połączenia lotniczego (lot)
INSERT INTO lot(originID,destinationID,pilotID,samolotID,dephour,arrhours)
VALUES(10,13,22,3,16:00:00,18:00:00) 
-- 2.Zatrudnienie nowego pilota
INSERT INTO pilot (imie,nazwisko,wiek)
VALUES ("Mikołaj","Powrózek",21);
-- 3.Zatwierdzenie biletu(po wykonaniu platnosci)
UPDATE bilet
SET confirmed=1
WHERE biletID=1
-- 4.Zakup nowego samolotu
INSERT INTO samolot (model,rocznik,pojemnosc)
VALUES ("Airbus A320",2019,100);
-- 5.Zwolnienie pilota
DELETE FROM pilot WHERE imie LIKE "Virgina" and nazwisko LIKE "Hellyar";
-- 6. Zmiana pilota mającego odbyć dany lot 
UPDATE lot
SET pilotID=1
WHERE lotID=1
--7. Wypisz wszystkich wolnych pilotów sortując od najmłodszego
SELECT * from pilot
WHERE pilotID IN (SELECT pilotID from pilot EXCEPT SELECT pilotID from lot)
ORDER BY wiek;
-- 8.Wypisz wszystkie wolne samoloty
SELECT * from samolot
WHERE samolotID IN (SELECT samolotID from samolot EXCEPT SELECT samolotID from lot)
-- Użytkownik
-- 9.Sprawdzenie, czy pasażer znajduje się w bazie pasażerów
SELECT COUNT(pasazerID)
FROM pasazer;
WHERE imie LIKE ("Ado") AND nazwisko LIKE "Meletti" AND haslo LIKE passwd;

-- 10.Dodanie pasażera do bazy
INSERT INTO pasazer (imie,nazwisko,haslo)
VALUES ("Michał","Pastuszko","maslo");
-- 11.Zakup biletu
SELECT pasazerID
FROM pasazer
WHERE imie LIKE "Michał" AND nazwisko LIKE "Pastuszko" AND haslo LIKE "maslo"";


INSERT INTO bilet (pasazerID, lotID, confirmed)
VALUES (51, 2, 0);
-- 12. Zwrot biletu
SELECT pasazerID
FROM pasazer
WHERE imie LIKE "Michał" AND nazwisko LIKE "Pastuszko" AND haslo LIKE "maslo"";

DELETE FROM bilet WHERE pasazerID LIKE "1" and biletID LIKE "5";
-- 13. Wypisanie wszystkich połączeń lotniczych
SELECT lot.lotID,lot.dephour,lot.arrhour,origin.miasto,destination.miasto from lot 
INNER JOIN miasto AS origin on lot.originID=origin.miastoID 
INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID 
-- 14. Wypisanie szczegółowych informacji o locie.
SELECT lot.lotID,lot.dephour,lot.arrhour,origin.miasto,destination.miasto,pilot.imie,pilot.nazwisko,samolot.model from lot 
INNER JOIN miasto AS origin on lot.originID=origin.miastoID 
INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID 
INNER JOIN pilot on lot.pilotID=pilot.pilotID 
INNER JOIN samolot on lot.samolotID=samolot.samolotID where lot.lotID=1;
-- 15. Sprawdzenie wszystkich swoich biletów
SELECT bilet.biletID,lot.lotID,lot.dephour,lot.arrhour FROM bilet  INNER JOIN lot on lot.lotID=bilet.lotID where bilet.pasazerID=252

SELECT origin.miasto,destination.miasto from lot INNER JOIN miasto AS origin on lot.originID=origin.miastoID INNER JOIN miasto AS destination on lot.destinationID=destination.miastoID WHERE lot.lotID=1