-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 03. Sep 2019 um 13:47
-- Server-Version: 10.3.16-MariaDB
-- PHP-Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `hospital`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `admision`
--

CREATE TABLE `admision` (
  `AdmisionID` int(11) NOT NULL,
  `fk_SocialSecurityNumber` int(11) DEFAULT NULL,
  `AdmisionDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `admision`
--

INSERT INTO `admision` (`AdmisionID`, `fk_SocialSecurityNumber`, `AdmisionDate`) VALUES
(1, 12345, '2019-09-03'),
(2, 1231231, '2019-09-01');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `doctor`
--

CREATE TABLE `doctor` (
  `DoctorID` int(11) NOT NULL,
  `FirstName` varchar(55) NOT NULL,
  `LastName` varchar(55) NOT NULL,
  `Speciality` enum('Cardiologist','Dermatologist','Endocrinologist','Gastroenterologist','Internist','Neurologist','Radiogolist','Pulmonologist') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `doctor`
--

INSERT INTO `doctor` (`DoctorID`, `FirstName`, `LastName`, `Speciality`) VALUES
(1, 'Anja', 'Kuhar', 'Cardiologist'),
(2, 'Karriane', 'Dramal', 'Pulmonologist');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `patient`
--

CREATE TABLE `patient` (
  `SocialSecurityNumber` int(11) NOT NULL,
  `FirstName` varchar(55) NOT NULL,
  `LastName` varchar(55) NOT NULL,
  `BirthDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `patient`
--

INSERT INTO `patient` (`SocialSecurityNumber`, `FirstName`, `LastName`, `BirthDate`) VALUES
(12345, 'Darko', 'Kolak', '1472-01-01'),
(123456, 'Hristina', 'Dakic', '2000-01-12'),
(1231231, 'Darko', 'Idiot', '1756-01-12'),
(1234567, 'Goran', 'Stevic', '0000-00-00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `patienthistory`
--

CREATE TABLE `patienthistory` (
  `PatientHistoryID` int(11) NOT NULL,
  `fk_AdmisionID` int(11) NOT NULL,
  `fk_releasenoteID` int(11) NOT NULL,
  `fk_treatmentID` int(11) NOT NULL,
  `fk_SocialSecurityNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `patienthistory`
--

INSERT INTO `patienthistory` (`PatientHistoryID`, `fk_AdmisionID`, `fk_releasenoteID`, `fk_treatmentID`, `fk_SocialSecurityNumber`) VALUES
(1, 1, 1, 2, 1234567),
(2, 1, 1, 1, 1234567);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `releasenote`
--

CREATE TABLE `releasenote` (
  `ReleaseID` int(11) NOT NULL,
  `ReleaseNote` varchar(500) DEFAULT NULL,
  `LivingStatus` enum('Dead','Alive') DEFAULT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `fk_AdmisionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `releasenote`
--

INSERT INTO `releasenote` (`ReleaseID`, `ReleaseNote`, `LivingStatus`, `ReleaseDate`, `fk_AdmisionID`) VALUES
(1, 'live to tell the story', 'Alive', '2019-09-04', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `treatment`
--

CREATE TABLE `treatment` (
  `TreatmentID` int(11) NOT NULL,
  `fk_SocialSecurityNumber` int(11) DEFAULT NULL,
  `fk_DoctorID` int(11) DEFAULT NULL,
  `TreatmentDate` date NOT NULL,
  `Symptom` text NOT NULL,
  `Perscription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `treatment`
--

INSERT INTO `treatment` (`TreatmentID`, `fk_SocialSecurityNumber`, `fk_DoctorID`, `TreatmentDate`, `Symptom`, `Perscription`) VALUES
(1, 123456, 1, '2019-09-01', 'Seeing things', 'Vacation'),
(2, 1231231, 2, '2019-09-01', 'Crazy', 'Hard medication');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `admision`
--
ALTER TABLE `admision`
  ADD PRIMARY KEY (`AdmisionID`),
  ADD KEY `fk_SocialSecurityNumber` (`fk_SocialSecurityNumber`);

--
-- Indizes für die Tabelle `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indizes für die Tabelle `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`SocialSecurityNumber`);

--
-- Indizes für die Tabelle `patienthistory`
--
ALTER TABLE `patienthistory`
  ADD PRIMARY KEY (`PatientHistoryID`),
  ADD KEY `fk_SocialSecurityNumber` (`fk_SocialSecurityNumber`),
  ADD KEY `fk_AdmisionID` (`fk_AdmisionID`),
  ADD KEY `fk_releasenoteID` (`fk_releasenoteID`),
  ADD KEY `fk_treatmentID` (`fk_treatmentID`);

--
-- Indizes für die Tabelle `releasenote`
--
ALTER TABLE `releasenote`
  ADD PRIMARY KEY (`ReleaseID`),
  ADD KEY `fk_AdmisionID` (`fk_AdmisionID`);

--
-- Indizes für die Tabelle `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`TreatmentID`),
  ADD KEY `fk_SocialSecurityNumber` (`fk_SocialSecurityNumber`),
  ADD KEY `fk_DoctorID` (`fk_DoctorID`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `admision`
--
ALTER TABLE `admision`
  ADD CONSTRAINT `admision_ibfk_1` FOREIGN KEY (`fk_SocialSecurityNumber`) REFERENCES `patient` (`SocialSecurityNumber`);

--
-- Constraints der Tabelle `patienthistory`
--
ALTER TABLE `patienthistory`
  ADD CONSTRAINT `patienthistory_ibfk_1` FOREIGN KEY (`fk_SocialSecurityNumber`) REFERENCES `patient` (`SocialSecurityNumber`),
  ADD CONSTRAINT `patienthistory_ibfk_2` FOREIGN KEY (`fk_AdmisionID`) REFERENCES `admision` (`AdmisionID`),
  ADD CONSTRAINT `patienthistory_ibfk_3` FOREIGN KEY (`fk_releasenoteID`) REFERENCES `releasenote` (`ReleaseID`),
  ADD CONSTRAINT `patienthistory_ibfk_4` FOREIGN KEY (`fk_treatmentID`) REFERENCES `treatment` (`TreatmentID`);

--
-- Constraints der Tabelle `releasenote`
--
ALTER TABLE `releasenote`
  ADD CONSTRAINT `fk_AdmisionID` FOREIGN KEY (`fk_AdmisionID`) REFERENCES `admision` (`AdmisionID`);

--
-- Constraints der Tabelle `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`fk_SocialSecurityNumber`) REFERENCES `patient` (`SocialSecurityNumber`),
  ADD CONSTRAINT `treatment_ibfk_2` FOREIGN KEY (`fk_DoctorID`) REFERENCES `doctor` (`DoctorID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
