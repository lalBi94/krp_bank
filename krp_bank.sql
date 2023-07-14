-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 04 juil. 2023 à 03:09
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `esxlegacy_984b87`
--

-- --------------------------------------------------------

--
-- Structure de la table `krp_bank`
--

DROP TABLE IF EXISTS `krp_bank`;
CREATE TABLE IF NOT EXISTS `krp_bank` (
  `identifier` text NOT NULL,
  `naccount` text NOT NULL,
  `pendingTransfer` int(11) NOT NULL DEFAULT '0',
  `emmiter` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `krp_bank`
--

INSERT INTO `krp_bank` (`identifier`, `naccount`, `pendingTransfer`, `emmiter`) VALUES
('blabla:fsefsefsefe', 'FFFF-FFFF-FFFF', 0, NULL),
('char1:2527f6b091061f639113ecbdbb4c0e590290a2d4', 'IVJY-8P6A-7V2U-FINA', 0, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
