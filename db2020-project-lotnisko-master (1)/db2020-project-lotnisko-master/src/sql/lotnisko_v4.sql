-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 12 Cze 2020, 20:36
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.3

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `lotnisko`
--
CREATE DATABASE IF NOT EXISTS `lotnisko` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lotnisko`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilet`
--

CREATE TABLE IF NOT EXISTS `bilet` (
  `biletID` int(11) NOT NULL AUTO_INCREMENT,
  `pasazerID` int(11) NOT NULL,
  `lotID` int(11) NOT NULL,
  `confirmed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`biletID`),
  KEY `pasazerID` (`pasazerID`) USING BTREE,
  KEY `lotID` (`lotID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `bilet`
--

INSERT INTO `bilet` (`biletID`, `pasazerID`, `lotID`, `confirmed`) VALUES
(1, 3, 1, 1),
(2, 27, 2, 1),
(3, 1, 1, 1),
(4, 39, 2, 0),
(5, 1, 2, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lot`
--

CREATE TABLE IF NOT EXISTS `lot` (
  `lotID` int(11) NOT NULL AUTO_INCREMENT,
  `originID` int(11) NOT NULL,
  `destinationID` int(11) NOT NULL,
  `pilotID` int(11) NOT NULL,
  `samolotID` int(11) NOT NULL,
  `dephour` varchar(255) NOT NULL,
  `arrhour` varchar(255) NOT NULL,
  PRIMARY KEY (`lotID`),
  UNIQUE KEY `pilotID_2` (`pilotID`),
  UNIQUE KEY `samolotID` (`samolotID`),
  KEY `pilotID` (`pilotID`) USING BTREE,
  KEY `originID` (`originID`,`destinationID`) USING BTREE,
  KEY `destinationID` (`destinationID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `lot`
--

INSERT INTO `lot` (`lotID`, `originID`, `destinationID`, `pilotID`, `samolotID`, `dephour`, `arrhour`) VALUES
(1, 5, 4, 1, 2, '04:55:00', '17:02:00'),
(2, 49, 12, 13, 1, '02:00:00', '06:00:00'),
(3, 1, 2, 3, 4, '13:20:00', '22:00:00'),
(8, 48, 49, 23, 3, '22:37:00', '12:15:00'),
(9, 48, 50, 16, 6, '12:10:00', '17:20:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miasto`
--

CREATE TABLE IF NOT EXISTS `miasto` (
  `miastoID` int(11) NOT NULL AUTO_INCREMENT,
  `miasto` varchar(255) NOT NULL,
  `panstwo` varchar(255) NOT NULL,
  PRIMARY KEY (`miastoID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `miasto`
--

INSERT INTO `miasto` (`miastoID`, `miasto`, `panstwo`) VALUES
(1, 'Buarcos', 'Portugal'),
(2, 'Ikaalinen', 'Finland'),
(3, 'Capatárida', 'Venezuela'),
(4, 'Stamboliyski', 'Bulgaria'),
(5, 'Energodar', 'Ukraine'),
(6, 'San Carlos de Bariloche', 'Argentina'),
(7, 'Murom', 'Russia'),
(8, 'Wassa-Akropong', 'Ghana'),
(9, 'Angoulême', 'France'),
(10, 'Mengdong', 'China'),
(11, 'Pereira Barreto', 'Brazil'),
(12, 'Bouças', 'Portugal'),
(13, 'Wonotirto', 'Indonesia'),
(14, 'Vysokogornyy', 'Russia'),
(15, 'Wenxi', 'China'),
(16, 'Chipyela', 'Malawi'),
(17, 'Sundsvall', 'Sweden'),
(18, 'Waenenda', 'Indonesia'),
(19, 'Timiryazevskiy', 'Russia'),
(20, 'Rožna Dolina', 'Slovenia'),
(21, 'Maraial', 'Brazil'),
(22, 'Chkalov', 'Tajikistan'),
(23, 'Cafe', 'Philippines'),
(24, 'Salvaleón de Higüey', 'Dominican Republic'),
(25, 'Bagiktinggang', 'Indonesia'),
(26, 'Ribeira Grande', 'Portugal'),
(27, 'Denver', 'United States'),
(28, 'Lodoyo', 'Indonesia'),
(29, 'Mawlamyine', 'Myanmar'),
(30, 'Zgornje Bitnje', 'Slovenia'),
(31, 'Oklahoma City', 'United States'),
(32, 'Dowsk', 'Belarus'),
(33, 'Mabai', 'China'),
(34, 'Čačak', 'Serbia'),
(35, 'Gersikputih Tengah', 'Indonesia'),
(36, 'Castelo', 'Portugal'),
(37, 'Negara', 'Indonesia'),
(38, 'Néa Karváli', 'Greece'),
(39, 'Malešići', 'Bosnia and Herzegovina'),
(40, 'Domsjö', 'Sweden'),
(41, 'Igrim', 'Russia'),
(42, 'Пласница', 'Macedonia'),
(43, 'Wangping', 'China'),
(44, 'Az̧ Z̧a‘āyin', 'Qatar'),
(45, 'Qorovulbozor Shahri', 'Uzbekistan'),
(46, 'Nanjing', 'China'),
(47, 'Bagong Pagasa', 'Philippines'),
(48, 'Yokohama', 'Japan'),
(49, 'Bledzew', 'Poland'),
(50, 'Cafayate', 'Argentina');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pasazer`
--

CREATE TABLE IF NOT EXISTS `pasazer` (
  `pasazerID` int(11) NOT NULL AUTO_INCREMENT,
  `imie` varchar(255) NOT NULL,
  `nazwisko` varchar(255) NOT NULL,
  `haslo` varchar(255) NOT NULL,
  PRIMARY KEY (`pasazerID`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pasazer`
--

INSERT INTO `pasazer` (`pasazerID`, `imie`, `nazwisko`, `haslo`) VALUES
(1, 'jan', 'kowalski', '123'),
(2, 'kan', 'jowalski', '321'),
(3, 'Wilbur', 'Oxberry', '231'),
(4, 'Zechariah', 'Yoskowitz', '4321'),
(5, 'Mahmud', 'Korlat', '1234'),
(6, 'Alexandre', 'Pocock', '2431'),
(7, 'Dominica', 'D\'Ambrosio', '2314'),
(8, 'Bunny', 'Thairs', '4123'),
(9, 'Deedee', 'Pacquet', '567'),
(10, 'Gwenette', 'Manby', '678'),
(11, 'Erwin', 'Pitkins', '890'),
(12, 'Any', 'Aguirrezabal', '876'),
(13, 'Ado', 'Meletti', '345'),
(14, 'Ogdan', 'Keaveny', '143'),
(15, 'Elijah', 'Finlator', '156'),
(16, 'Sarena', 'Godspeede', '157'),
(17, 'Lefty', 'Hugueville', '158'),
(18, 'Frasquito', 'Tabner', '159'),
(19, 'Starr', 'Kleyn', '160'),
(20, 'Ivor', 'Libbie', '161'),
(21, 'Betsey', 'Niess', '162'),
(22, 'Hewitt', 'Coonan', '163'),
(23, 'Evangeline', 'Enden', '164'),
(24, 'Bianka', 'Spiaggia', '165'),
(25, 'Justin', 'Flippelli', '166'),
(26, 'Ashlin', 'Grimmolby', ''),
(27, 'Jenda', 'Caustick', ''),
(28, 'Asia', 'Roseman', ''),
(29, 'Brenda', 'Tassell', ''),
(30, 'Ashia', 'Camel', ''),
(31, 'Henry', 'Brien', ''),
(32, 'Lisa', 'Windsor', ''),
(33, 'Aubrette', 'Dudbridge', ''),
(34, 'Marleen', 'Lanfere', ''),
(35, 'Casi', 'Morgen', ''),
(36, 'Roxy', 'Billes', ''),
(37, 'Webster', 'Robbe', ''),
(38, 'Trev', 'Heardman', ''),
(39, 'Currie', 'Jenik', ''),
(40, 'Rustin', 'Darling', ''),
(41, 'Romain', 'Fust', ''),
(42, 'Vicky', 'Lundberg', ''),
(43, 'Aubrey', 'Rebbeck', ''),
(44, 'Delmore', 'Hurrion', ''),
(45, 'Aindrea', 'Chance', ''),
(46, 'Giusto', 'Mower', ''),
(47, 'Micaela', 'Condell', ''),
(48, 'Brenden', 'Isitt', ''),
(49, 'Isabelle', 'Forson', ''),
(50, 'Lodovico', 'Blakeman', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pilot`
--

CREATE TABLE IF NOT EXISTS `pilot` (
  `pilotID` int(11) NOT NULL AUTO_INCREMENT,
  `imie` varchar(255) NOT NULL,
  `nazwisko` varchar(255) NOT NULL,
  `wiek` int(11) NOT NULL,
  PRIMARY KEY (`pilotID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pilot`
--

INSERT INTO `pilot` (`pilotID`, `imie`, `nazwisko`, `wiek`) VALUES
(1, 'Bale', 'Feldstern', 56),
(2, 'Martie', 'Wicklen', 46),
(3, 'Karel', 'Roycroft', 50),
(4, 'Urban', 'Rebeiro', 48),
(5, 'Abigail', 'Caisley', 49),
(6, 'Atalanta', 'Davison', 33),
(7, 'Bax', 'McKyrrelly', 23),
(8, 'Baxie', 'Edland', 44),
(9, 'Babita', 'Heeley', 49),
(10, 'Esra', 'Blasgen', 21),
(11, 'Grete', 'Melwall', 28),
(12, 'Ephrem', 'Shelmerdine', 38),
(13, 'Vilhelmina', 'Noirel', 49),
(14, 'Thatch', 'Brocking', 54),
(15, 'Brianna', 'Matlock', 59),
(16, 'Berny', 'Cleever', 35),
(17, 'Karylin', 'Mazillius', 34),
(18, 'Fanni', 'Chicken', 50),
(19, 'Brand', 'Lahrs', 57),
(20, 'Dina', 'Laight', 26),
(21, 'Vivia', 'Peters', 23),
(22, 'Valerie', 'Bullivent', 53),
(23, 'Virgina', 'Hellyar', 44),
(24, 'Elwyn', 'Howling', 26),
(25, 'Laney', 'Dakhov', 21),
(26, 'Mikołaj', 'Powrózek', 21),
(28, 'Kuba', 'Malize', 67),
(29, 'Jimmy', 'Vessel', 19);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `samolot`
--

CREATE TABLE IF NOT EXISTS `samolot` (
  `samolotID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `rocznik` year(4) NOT NULL,
  `pojemnosc` int(11) NOT NULL,
  PRIMARY KEY (`samolotID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `samolot`
--

INSERT INTO `samolot` (`samolotID`, `model`, `rocznik`, `pojemnosc`) VALUES
(1, 'Airbus A220', 2004, 107),
(2, 'Boeing 747', 2013, 83),
(3, 'Airbus A380', 2012, 94),
(4, 'Boeing 767', 2007, 77),
(5, 'Airbus A320', 2019, 100),
(6, 'Airbus A220', 2004, 98),
(7, 'Boeing 747', 2019, 105);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `bilet`
--
ALTER TABLE `bilet`
  ADD CONSTRAINT `bilet_ibfk_1` FOREIGN KEY (`lotID`) REFERENCES `lot` (`lotID`),
  ADD CONSTRAINT `bilet_ibfk_2` FOREIGN KEY (`pasazerID`) REFERENCES `pasazer` (`pasazerID`);

--
-- Ograniczenia dla tabeli `lot`
--
ALTER TABLE `lot`
  ADD CONSTRAINT `lot_ibfk_1` FOREIGN KEY (`originID`) REFERENCES `miasto` (`miastoID`),
  ADD CONSTRAINT `lot_ibfk_2` FOREIGN KEY (`destinationID`) REFERENCES `miasto` (`miastoID`),
  ADD CONSTRAINT `lot_ibfk_3` FOREIGN KEY (`pilotID`) REFERENCES `pilot` (`pilotID`),
  ADD CONSTRAINT `lot_ibfk_4` FOREIGN KEY (`samolotID`) REFERENCES `samolot` (`samolotID`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
