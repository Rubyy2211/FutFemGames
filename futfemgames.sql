-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-02-2026 a las 03:18:51
-- Versión del servidor: 12.0.2-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `futfemgames`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo-trofeo`
--

CREATE TABLE `equipo-trofeo` (
  `id` int(11) NOT NULL,
  `equipo` int(11) NOT NULL,
  `trofeo` int(11) NOT NULL,
  `temporada` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipo-trofeo`
--

INSERT INTO `equipo-trofeo` (`id`, `equipo`, `trofeo`, `temporada`) VALUES
(1, 1, 1, '2020-2021'),
(2, 1, 6, '2011-2012'),
(3, 1, 6, '2012-2013'),
(4, 1, 6, '2013-2014'),
(5, 1, 6, '2014-2015'),
(6, 1, 6, '2019-2020'),
(7, 1, 6, '2020-2021'),
(8, 1, 6, '2021-2022'),
(9, 1, 6, '2022-2023'),
(10, 1, 6, '2023-2024'),
(11, 1, 6, '2024-2025'),
(12, 1, 1, '2022-2023'),
(13, 1, 1, '2023-2024'),
(14, 1, 7, '1993-1994'),
(15, 1, 7, '2010-2011'),
(16, 1, 7, '2012-2013'),
(17, 1, 7, '2013-2014'),
(18, 1, 7, '2016-2017'),
(19, 1, 7, '2017-2018'),
(20, 1, 7, '2019-2020'),
(21, 1, 7, '2020-2021'),
(22, 1, 7, '2021-2022'),
(23, 1, 7, '2023-2024'),
(24, 1, 7, '2024-2025'),
(25, 1, 8, '2019-2020'),
(26, 1, 8, '2021-2022'),
(27, 1, 8, '2022-2023'),
(28, 1, 8, '2023-2024'),
(29, 1, 8, '2024-2025'),
(30, 1, 8, '2025-2026');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL,
  `liga` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `escudo` text DEFAULT NULL,
  `color` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id_equipo`, `liga`, `nombre`, `escudo`, `color`) VALUES
(1, 1, 'Fc Barcelona', 'media/ES/clubes/FCBarcelona.png', '#a50044'),
(2, 1, 'Levante UD', 'media/ES/clubes/Levante.png', '#b4053f'),
(3, 4, 'PSG', 'media/FR/clubes/Paris_Saint-Germain_FC.png', '#004170'),
(4, 4, 'OL Lyon', 'media/FR/clubes/Olympique_Lyonnais.png', ''),
(5, 3, 'Wolfsburg', 'media/DE/clubes/VfL_Wolfsburg.png', '#65B32E'),
(6, 1, 'Atlético', 'media/ES/clubes/Atletico_Madrid.png', '#CB3524'),
(7, 1, 'Real Madrid', 'media/ES/clubes/Real_Madrid.png', '#FEBE10'),
(8, 1, 'Real Sociedad', 'media/ES/clubes/Real_Sociedad.png', '#0067b1'),
(9, 1, 'Madrid cff', 'media/ES/clubes/Madridcff.png', '#fc03df'),
(10, 1, 'Athletic', 'media/ES/clubes/Athletic_Bilbao.png', '#ee2523'),
(11, 7, 'Valencia cf', 'media/ES/clubes/Valenciacf.png', '#d18816'),
(12, 1, 'Sevilla', 'media/ES/clubes/Sevilla_FC.png', '#f43333'),
(13, 7, 'Real Betis', 'media/ES/clubes/Real_betis.png', '#0BB363'),
(14, 3, 'FC Bayern', 'media/DE/clubes/FC_Bayern_München.png', '#0066b2'),
(15, 3, 'Eintracht', 'media/DE/clubes/Eintracht_Frankfurt.png', '#E1000F'),
(16, 3, 'Leverkusen', 'media/DE/clubes/Bayer_04_Leverkusen.png', '#E32221'),
(17, 4, 'Paris Fc', 'media/FR/clubes/Paris_FC.png', ''),
(18, 5, 'Arsenal', 'media/ENG/clubes/Arsenal.png', '#EF0107'),
(19, 5, 'Aston Villa', 'media/ENG/clubes/Aston_Villa.png', '#95bfe5'),
(20, 5, 'Chelsea', 'media/ENG/clubes/Chelsea_FC.png', '#034694'),
(21, 5, 'Man City', 'media/ENG/clubes/Manchester_City_FC.png', '#6CABDD'),
(22, 5, 'Man United', 'media/ENG/clubes/Manchester_United_FC.png', '#DA291C'),
(23, 6, 'Ajax', 'media/NL/clubes/Ajax_Amsterdam.png', '#ffffff'),
(24, 6, 'PSV Eindhoven', 'media/NL/clubes/PSV_Eindhoven.png', '#ED1C23'),
(25, 6, 'Fc Twente', 'media/NL/clubes/FC_Twente.png', '#FF0000'),
(26, 1, 'RCD Espanyol de Barcelona', 'media/ES/clubes/RCD_Espanyol.png', '#007fc8'),
(27, 7, 'Villareal', 'media/ES/clubes/Villarreal_CF.png', '#ffe667'),
(28, 21, 'Sporting Gijón', 'media/ES/clubes/Sporting_Gijon.png', '#FF0000'),
(29, 8, 'Fc Rosengård', 'media/SE/clubes/FC_Rosengård.png', ''),
(30, 16, 'Kopparbergs/Göteborg FC', 'media/SE/clubes/goteborg.avif', ''),
(31, 16, 'FCR 2001 Duisburg', 'media/DE/clubes/old/duisburg.png', ''),
(32, 9, 'Standard Liege', 'media/BE/clubes/Royal_Standard_Liege.png', ''),
(33, 16, 'VVV Venlo', 'media/NL/clubes/VVV Venlo.png', '#FFEA00'),
(34, 6, 'SC Heerenveen', 'media/NL/clubes/SC_Heerenveen.png', '#0000CC'),
(35, 16, 'UD Collerense', 'media/ES/clubes/collerense_ud.png', '#000080'),
(36, 7, 'Fc Barcelona B', 'media/ES/clubes/barça b.png', '#A60042'),
(37, 10, 'LSK Kvinner FK\r\n', 'media/NO/clubes/Lillestrøm_SK.png', ''),
(38, 10, 'SK Trondheims', 'media/NO/clubes/old/sk-trondheims-orn.png', ''),
(39, 11, 'Medyk Konin\r\n', 'media/PL/clubes/Medyk.png', ''),
(40, 16, 'Tyresö FF\r\n', 'media/SE/clubes/Tyresö_FF.png', ''),
(41, 10, 'Stabæk Kvinner', 'media/NO/clubes/Stabaek_IF.png', ''),
(42, 8, 'Linköpings F. C.', 'media/SE/clubes/Linköpings_HC.png', ''),
(43, 8, 'Jitex BK', 'media/SE/clubes/Jitex_BK.webp', ''),
(44, 21, 'Zaragoza CFF', 'media/ES/clubes/zaragoza_cff.png', '#0055A0'),
(45, 12, 'SL Benfica', 'media/PT/clubes/Benfica.png', ''),
(46, 8, 'Eskilstuna United DFF', 'media/SE/clubes/Eskilstuna_United_DFF.png', ''),
(47, 8, 'IK Uppsala Fotboll', 'media/SE/clubes/uppsala k.png', ''),
(48, 8, 'Hammarby IF Fotbollförening', 'media/SE/clubes/Hammarby_IF.png', '#1A7812'),
(49, 8, 'IK Sirius', 'media/SE/clubes/IK_Sirius.png', ''),
(50, 8, 'Vaksala SK', 'media/SE/clubes/Vaksala.png', ''),
(51, 8, 'Gamla Upsala SK', 'media/SE/clubes/Gamla_Upsala_SK.png', ''),
(52, 21, 'CD Sporting de Huelva', 'media/ES/clubes/sporting-huelva.png', '#042FBF'),
(53, 16, 'Real de Jaén', 'media/ES/clubes/jaen.png', '#9900CC'),
(54, 16, 'Cádiz CF', 'media/ES/clubes/Cadiz_cf.png', '#FFFF00'),
(55, 1, 'Levante de Badalona', 'media/ES/clubes/levante badalona.png', '#8F8F8F'),
(56, 4, 'En Avant de Guingamp', 'media/FR/clubes/EA_Guingamp.png', ''),
(57, 4, 'ASJ Soyaux Charente', 'media/FR/clubes/ASJ_Soyaux-Charente.png', ''),
(58, 16, 'Reading FC', 'media/ENG/clubes/Reading_FC.png', ''),
(59, 21, 'Rayo Vallecano', 'media/ES/clubes/Rayo_Vallecano.png', '#FFFFFF'),
(60, 21, 'Málaga CF', 'media/ES/clubes/Málaga_CF.png', '#3399FF'),
(61, 2, 'Penn State', 'media/US/clubes/penn_state_football.png', ''),
(62, 1, 'Alhama ELPOZO CF', 'media/ES/clubes/Alhama.png', '#2662BC'),
(63, 16, 'SMX Athletic Club de Murcia', 'media/ES/clubes/SMX.png', '#067500'),
(64, 13, 'SP Corinthians', 'media/BR/clubes/corinthians.png', ''),
(65, 7, 'CF Cacereño Femenino', 'media/ES/clubes/Cacereño.png', '#009900'),
(66, 14, 'Millonarios FC', 'media/CO/clubes/Millonarios.png', ''),
(67, 14, 'Independiente de Santa Fe', 'media/CO/clubes/Independiente_Santa_Fe.png', ''),
(68, 14, 'Atlético Huila', 'media/CO/clubes/Atlético_Huila.png', ''),
(69, 14, 'Club Deportivo La Equidad', 'media/CO/clubes/Equidad.png', ''),
(70, 6, 'FC Utrecht Vrouwen', 'media/NL/clubes/FC_Utrecht.png', '#FF0000'),
(71, 2, 'San Diego Wave FC', 'media/US/clubes/San Diego.png', ''),
(72, 2, 'Orlando Pride', 'media/US/clubes/Orlando_Pride.png', ''),
(73, 5, 'Tottenham Hotspur', 'media/ENG/clubes/Tottenham_Hotspur.png', '#132257'),
(74, 2, 'Portland Thorns FC', 'media/US/clubes/Portland_Thorns.png', ''),
(75, 16, 'Seattle Sounders Women', 'media/US/clubes/old/Sounders-Women.png', ''),
(76, 16, 'Western New York Flash', 'media/US/clubes/old/Western_New_York_Flash.png', ''),
(77, 16, 'LA Blues', 'media/US/clubes/old/LA_BLUES.png', ''),
(78, 1, 'Deportivo Abanca', 'media/ES/clubes/depor.png', '#57175e'),
(79, 1, 'Granada CF', 'media/ES/clubes/Granada.png', '#FF0000'),
(80, 1, 'SD Eibar', 'media/ES/clubes/SD_Eibar.png', '#E01212'),
(81, 1, 'Costa Adeje Tenerife\r\n', 'media/ES/clubes/costa adeje.png', '#0000FF'),
(82, 16, 'FFC Frankfurt', 'media/DE/clubes/Eintracht_Frankfurt.png', ''),
(83, 15, 'Leyendas', NULL, ''),
(84, 15, 'Heroinas', NULL, ''),
(85, 17, 'Roma', NULL, ''),
(86, 17, 'Inter de Milán', NULL, ''),
(87, 17, 'Fiorentina', NULL, ''),
(88, 16, 'Milan', NULL, ''),
(89, 17, 'Napoles', NULL, ''),
(90, 5, 'Brighton', 'media/ENG/clubes/brighton.png', '#0057B8'),
(91, 5, 'Everton', 'media/ENG/clubes/everton.png', '#003399'),
(92, 17, 'Juventus', NULL, ''),
(93, 18, 'FFC Turbine Potsdam', NULL, '#0057B8'),
(94, 10, 'Kolbotn I. L', NULL, ''),
(95, 18, 'MSV Duisburgo', NULL, ''),
(96, 19, 'Club America', NULL, ''),
(97, 2, 'Gotham FC', NULL, ''),
(98, 20, 'Colo Colo', NULL, ''),
(99, 17, 'FC Como', NULL, ''),
(100, 17, 'Lazio', NULL, ''),
(101, 19, 'Pachuca', NULL, ''),
(102, 2, 'Houston Dash', NULL, ''),
(103, 2, 'Utah Royals', NULL, ''),
(104, 2, 'Seattle Reign', NULL, ''),
(105, 2, 'Washington Spirit', NULL, ''),
(106, 19, 'Monterrey', NULL, ''),
(107, 1, 'DUX Logroño', 'media/ES/clubes/logronyo.png', '#660000'),
(108, 4, 'Montpellier', NULL, ''),
(109, 5, 'London City Lionesses', 'media/ENG/clubes/london-city.png', '#00b0c7'),
(110, 5, 'West Ham', 'media/ENG/clubes/west-ham.png', '#7A263A'),
(111, 5, 'Liverpool', 'media/ENG/clubes/liverpool.png', '#c8102E'),
(112, 19, 'Tigres de la UANL', NULL, ''),
(113, 19, 'Pumas', NULL, ''),
(114, 19, 'Pumas', NULL, ''),
(115, 7, 'Osasuna', 'media/ES/clubes/osasuna.png', '#d91a21'),
(116, 7, 'Alavés', 'media/ES/clubes/alaves.png', '#048FD9'),
(117, 7, 'Fundación Albacete', 'media/ES/clubes/alba.png', '#FFFFFF'),
(118, 7, 'AEM SE Lleida', 'media/ES/clubes/aem.png', '#0000FF'),
(119, 7, 'Real Oviedo Femenino', 'media/ES/clubes/oviedo.png', '#0066FF'),
(120, 7, 'CE Europa', 'media/ES/clubes/europa.png', '#0000FF'),
(121, 21, 'Bizkerre', NULL, ''),
(122, 22, 'Añorga', NULL, ''),
(123, 21, 'Racing Féminas', NULL, ''),
(124, 5, 'Leicester', 'media/ENG/clubes/leicester.png', '#0053A0'),
(125, 23, 'Charlton Athletic', 'media/ENG/clubes/charlton.png', '#D6011D'),
(126, 23, 'Birmingham City', 'media/ENG/clubes/birmingham.png', '#0000FF'),
(127, 23, 'Bristol City', 'media/ENG/clubes/bristol.png', '#E21A23'),
(128, 23, 'Crystal Palace', 'media/ENG/clubes/crystal.png', '#1B458F'),
(129, 23, 'Southampton', 'media/ENG/clubes/southampton.png', '#FF0033'),
(130, 23, 'Newcastle United', 'media/ENG/clubes/newcastle.png', '#000000'),
(131, 23, 'Nottingham Forest', 'media/ENG/clubes/forest.png', '#C8102E'),
(132, 23, 'Sunderland', 'media/ENG/clubes/sunderland.png', '#EB172C'),
(133, 23, 'Durham', 'media/ENG/clubes/durham.png', '#2154CB'),
(134, 23, 'Sheffield United', 'media/ENG/clubes/sheffield.png', '#EC2227'),
(135, 23, 'Portsmouth', 'media/ENG/clubes/portsmouth.png', '#0754ED'),
(136, 23, 'Ipswich Town', 'media/ENG/clubes/ipswich.png', '#212B61'),
(137, 7, 'Atlético B', 'media/ES/clubes/Atletico_Madrid.png', '#CB3524'),
(138, 7, 'Real Madrid B', 'media/ES/clubes/Real_Madrid.png', '#FEBE10'),
(139, 7, 'Costa Adeje Tenerife B\r\n', 'media/ES/clubes/costa adeje.png', '#0000FF'),
(140, 6, 'Ado den Haag', 'media/NL/clubes/ado.png', '#006600'),
(141, 6, 'AZ Alkmaar', 'media/NL/clubes/az.png', '#FF0000'),
(142, 6, 'Excelsior', 'media/NL/clubes/excelsior.png', '#000000'),
(143, 6, 'Feyenoord', 'media/NL/clubes/feyenoord.png', '#FF0808'),
(144, 6, 'Hera United', 'media/NL/clubes/hera.png', '#033685'),
(145, 6, 'NAC Breda', 'media/NL/clubes/nac.png', '#F7EA36'),
(146, 6, 'PEC Zwolle', 'media/NL/clubes/pec.png', '#2D2DD4'),
(147, 3, 'Werder Bremen', 'media/DE/clubes/bremen.png', '#00924A'),
(148, 3, 'Hoffenheim', 'media/DE/clubes/hoffenheim.png', '#0033CC'),
(149, 3, 'Freiburg', 'media/DE/clubes/freiburg.png', '#FF0000'),
(150, 3, 'FC Koln', 'media/DE/clubes/koln.png', '#ED1C23'),
(151, 3, 'Union Berlin', 'media/DE/clubes/union.png', '#E40019'),
(152, 3, 'Nurnberg', 'media/DE/clubes/nurnberg.png', '#990000'),
(153, 3, 'RB Leizpig', 'media/DE/clubes/leipzig.png', '#D50031'),
(154, 3, 'Hamburg', 'media/DE/clubes/hamburg.png', '#014495'),
(157, 3, 'Essen', 'media/DE/clubes/essen.png', '#660066'),
(158, 3, 'Jena', 'media/DE/clubes/jena.png', '#0F59FA'),
(159, 18, 'Wolfsburg II', 'media/DE/clubes/VfL_Wolfsburg.png', '#65B32E'),
(160, 18, 'FC Bayern II', 'media/DE/clubes/FC_Bayern_München.png', '#0066b2'),
(161, 18, 'Eintracht II', 'media/DE/clubes/Eintracht_Frankfurt.png', '#E1000F');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juegos`
--

CREATE TABLE `juegos` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `juegos`
--

INSERT INTO `juegos` (`id`, `nombre`, `slug`) VALUES
(1, 'Gues Trayectoria', ''),
(2, 'Wordle', '2'),
(3, 'Guess Jugadora', '3'),
(4, 'Futfem Grid', '4'),
(5, 'Futfem Mates', '5'),
(6, 'Futfem Bingo', '6');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadora-trofeo`
--

CREATE TABLE `jugadora-trofeo` (
  `id` int(11) NOT NULL,
  `jugadora` int(11) NOT NULL,
  `trofeo` int(11) NOT NULL,
  `temporada` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jugadora-trofeo`
--

INSERT INTO `jugadora-trofeo` (`id`, `jugadora`, `trofeo`, `temporada`) VALUES
(1, 1, 3, '2017'),
(2, 1, 4, '2017');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadoras`
--

CREATE TABLE `jugadoras` (
  `id_jugadora` int(11) NOT NULL,
  `Nombre` text NOT NULL,
  `Apellidos` text NOT NULL,
  `Apodo` text NOT NULL,
  `Nacimiento` date NOT NULL,
  `Nacionalidad` int(11) NOT NULL,
  `Posicion` int(2) NOT NULL DEFAULT 13,
  `imagen` text DEFAULT NULL,
  `retiro` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jugadoras`
--

INSERT INTO `jugadoras` (`id_jugadora`, `Nombre`, `Apellidos`, `Apodo`, `Nacimiento`, `Nacionalidad`, `Posicion`, `imagen`, `retiro`) VALUES
(1, 'Lieke Elisabeth Petronella', 'Martens', 'Lieke', '1992-12-16', 7, 11, 'media/NL/jugadoras/likitaaa.png', '2025'),
(2, 'Ellie', 'Roebuck', 'Ellie', '1999-09-23', 2, 1, 'media/ENG/jugadoras/ellieee.png', NULL),
(3, 'Cata', 'Thomas Coll Lluch', 'Cata', '2001-04-23', 1, 1, 'media/ES/jugadoras/cata.png', NULL),
(4, 'Gemma', 'Font Oliveras', 'Gemma', '1999-11-07', 1, 1, 'media/ES/jugadoras/gemma.png', NULL),
(5, 'Irene', 'Paredes Hernández', 'Irene', '1991-07-04', 1, 3, 'media/ES/jugadoras/paredes.png', NULL),
(6, 'Marta', 'Torrejón Moya', 'Torre', '1990-02-27', 1, 2, 'media/ES/jugadoras/torrejon.png', NULL),
(7, 'Mapi', 'León Cebrián', 'Mapi', '1995-06-13', 1, 3, 'media/ES/jugadoras/mapi.png', NULL),
(8, 'Ona', 'Batlle Pascual', 'Ona', '1999-06-10', 1, 2, 'media/ES/jugadoras/ona.png', NULL),
(9, 'Jana', 'Fernández Velasco', 'Jana', '2002-02-18', 1, 3, 'media/ES/jugadoras/jana.png', NULL),
(10, 'Martina', 'Fernández Vila', 'Martina', '2004-10-01', 1, 3, 'media/ES/jugadoras/martina.png', NULL),
(11, 'Alexia', 'Putellas Segura', 'Alexia', '1994-02-04', 1, 5, 'media/ES/jugadoras/alexia.png', NULL),
(12, 'Patricia', 'Guijarro Gutiérrez', 'Patri', '1998-05-17', 1, 6, 'media/ES/jugadoras/patri.png', NULL),
(13, 'Aitana', 'Bonmatí Conca', 'Aitana', '1998-01-18', 1, 5, 'media/ES/jugadoras/aitana.png', NULL),
(14, 'Ingrid Syrstad', 'Engen', 'Engen', '1998-04-29', 3, 6, 'media/NO/jugadoras/ingrid.png', NULL),
(15, 'Keira', 'Walsh', 'Keira', '1997-04-08', 2, 6, 'media/ENG/jugadoras/keira.png', NULL),
(16, 'Victoria', 'López Serrano Felix', 'Vicky', '2006-07-26', 1, 7, 'media/ES/jugadoras/vicky lopez.png', NULL),
(17, 'Ewa', 'Pajor', 'Pajor', '1996-12-03', 14, 10, 'media/PL/jugadoras/Ewa Pajor.png', NULL),
(18, 'Caroline', 'Graham Hansen', 'Hansen', '1995-02-18', 3, 12, 'media/NO/jugadoras/hansen.png', NULL),
(19, 'Fridolina', 'Rolfö', 'Frido', '1993-11-24', 16, 4, 'media/SE/jugadoras/frido.png', NULL),
(20, 'Claudia', 'Pina Medina', 'Pina', '2001-08-12', 1, 7, 'media/ES/jugadoras/pina.png', NULL),
(21, 'Salma Celeste', 'Paralluelo Ayingono', 'Salma', '2003-11-13', 1, 11, 'media/ES/jugadoras/salma.png', NULL),
(22, 'Kika', 'Ramos Ribeiro Nazareth Sousa', 'Kika', '2002-11-17', 41, 7, 'media/PT/jugadoras/kika.png', NULL),
(23, 'Érika', 'González Lombídez', 'Érika ', '2004-08-31', 1, 7, 'media/ES/jugadoras/eriii.png', NULL),
(24, 'Esmee', 'Brugts', 'Esmee', '2003-07-28', 7, 12, 'media/NL/jugadoras/esmeeee.png', NULL),
(25, 'Emma Ida Emilia', 'Holmgren', 'Emma', '1997-05-13', 16, 1, 'media/SE/jugadoras/emmaaa.png', NULL),
(26, 'Andrea', 'Tarazona Brisa', 'Tarazona', '2004-03-21', 1, 1, 'media/ES/jugadoras/taraa.png', NULL),
(27, 'María De Alharilla', 'Casado Morente', 'Alharilla', '1990-11-13', 1, 2, 'media/ES/jugadoras/alhaa.png', NULL),
(28, 'María', 'Molina Molero', 'Moli', '2000-05-09', 1, 3, 'media/ES/jugadoras/moli.png', NULL),
(29, 'Teresa', 'Mérida Cañete', 'Tere', '2002-07-17', 1, 3, 'media/ES/jugadoras/tere merida.png', NULL),
(30, 'Estela', 'Carbonell Núñez', 'Estela', '2004-10-18', 1, 4, 'media/ES/jugadoras/estelita.png', NULL),
(31, 'Raiderlin Nazareth', 'Carrasco Vargas', 'Rai', '2002-06-11', 22, 4, 'media/VE/jugadoras/raii.png', NULL),
(32, 'Nuria', 'Escoms García', 'Escoms', '2006-08-15', 1, 5, 'media/ES/jugadoras/escoms.png', NULL),
(33, 'María', 'Gabaldón Romero', 'Gabal', '2003-11-11', 1, 3, 'media/ES/jugadoras/gabal.png', NULL),
(34, 'Ángela', 'Sosa Martín', 'Sosa', '1993-01-16', 1, 7, 'media/ES/jugadoras/sosaa.png', NULL),
(35, 'Anissa', 'Lahmari', 'Lahmari', '1997-02-17', 30, 5, 'media/MA/jugadoras/anissa.png', NULL),
(36, 'Paula', 'Fernández Jiménez', 'Paufer', '1999-07-01', 1, 5, 'media/ES/jugadoras/paufer.png', NULL),
(37, 'Anna', 'Torrodá Ricart', 'Torro', '2000-01-21', 1, 6, 'media/ES/jugadoras/torro.png', NULL),
(38, 'Ainhoa', 'Estévez Bascuñán', 'Bascu', '2004-02-23', 1, 5, 'media/ES/jugadoras/bascu.png', NULL),
(39, 'Eva', 'Alonso González', 'Eva', '2002-07-23', 1, 6, 'media/ES/jugadoras/evaa.png', NULL),
(40, 'Daniela', 'Arques Lázaro', 'Dani', '2006-03-21', 1, 5, 'media/ES/jugadoras/daniela.png', NULL),
(41, 'Gabriela', 'Nunes Da Silva', 'Gabi Nunes', '1997-03-10', 27, 10, 'media/BR/jugadoras/gabi.png', NULL),
(42, 'Ana', 'Franco', 'Ana Franco', '1999-06-06', 1, 8, 'media/ES/jugadoras/ana franco.png', NULL),
(43, 'Ivonne', 'Chacón', 'Chacón', '1997-10-12', 26, 10, 'media/CO/jugadoras/ivonne.png', NULL),
(44, 'Sari', 'van Veenendaal', 'Sari', '1990-04-03', 7, 1, 'media/NL/jugadoras/sari.png', '2022'),
(45, 'Alexandra Patricia', 'Morgan', 'Morgan', '1989-07-02', 18, 10, 'media/US/jugadoras/alex-morgan.png', '2024'),
(46, 'Dolores', 'Gallardo Núñez', 'Lola', '1993-06-10', 1, 1, 'media/ES/jugadoras/lola.png', NULL),
(47, 'Patricia', 'Larqué Juste', 'Patri Larqué', '1992-05-02', 1, 1, 'media/ES/jugadoras/Patri Larqué.png', NULL),
(48, 'Ainhoa', 'Vicente Moraza', 'Moraza', '1995-08-20', 1, 2, 'media/ES/jugadoras/moraza.png', NULL),
(49, 'Carmen', 'Menayo Montero', 'Carmen Menayo', '1998-04-14', 1, 3, 'media/ES/jugadoras/MENAYO.png', NULL),
(50, 'Rosa María', 'Otermín Abella', 'Rosa Otermín', '2000-10-02', 1, 4, 'media/ES/jugadoras/otermín.png', NULL),
(51, 'Lauren Eduarda', 'Leal Costa', 'Lauren Leal', '2002-09-13', 27, 3, 'media/BR/jugadoras/lauren.png', NULL),
(52, 'Silvia', 'Lloris Nicolás', 'Silvi', '2004-05-15', 1, 3, 'media/ES/jugadoras/silvi.png', NULL),
(53, 'Xènia', 'Pérez Almiñana', 'Xènia', '2001-10-28', 1, 3, 'media/ES/jugadoras/Xènia.png', NULL),
(54, 'Andrea', 'Medina Martin', 'Andrea', '2004-05-11', 1, 4, 'media/ES/jugadoras/medina.png', NULL),
(55, 'Tatiana Vanessa', 'Ferreira Pinto', 'Tati', '1994-03-28', 41, 5, 'media/PT/jugadoras/tati.png', NULL),
(56, 'Merle', 'Barth', 'Merle', '1994-04-21', 15, 3, 'media/DE/jugadoras/merle.png', NULL),
(57, 'Vilde', 'Bøe Risa', 'Vilde', '1995-07-13', 3, 5, 'media/NO/jugadoras/boe risa.png', NULL),
(58, 'Ana Vitória', 'Angélica Kliemaschewsk De Araújo', 'Ana Vitória', '2000-03-06', 27, 7, 'media/BR/jugadoras/ana vitoria.png', NULL),
(59, 'Gabriela Antonia', 'García Segura', 'Gaby García', '1997-04-02', 22, 6, 'media/VE/jugadoras/gaby.png', NULL),
(60, 'Fiamma', 'Benítez Iannuzzi', 'Fiamma', '2004-06-19', 1, 7, 'media/ES/jugadoras/fiamma.png', NULL),
(61, 'Marta', 'Cardona De Miguel', 'Marta Cardona', '1995-05-26', 1, 12, 'media/ES/jugadoras/cardona.png', NULL),
(62, 'Sheila', 'Guijarro Gómez', 'Shei', '1996-09-26', 1, 10, 'media/ES/jugadoras/sheila.png', NULL),
(63, 'Synne', 'Jensen', 'Synne', '1996-02-15', 3, 10, 'media/NO/jugadoras/jensen.png', NULL),
(64, 'Rasheedat', 'Ajibade', 'Ajibade', '1999-12-08', 36, 11, 'media/NG/jugadoras/ajibade.png', NULL),
(65, 'Giovana', 'Queiroz Costa', 'Gio', '2003-06-21', 27, 10, 'media/BR/jugadoras/gio.png', NULL),
(66, 'Luany Vitória', 'Da Silva Rosa', 'Luany', '2003-02-03', 27, 10, 'media/BR/jugadoras/luany.png', NULL),
(67, 'Mari Paz', 'Vilas Dono', 'Vilas', '1988-02-01', 1, 10, 'media/ES/jugadoras/mapigol.png', '2023'),
(68, 'Enith', 'Salón Marcuello', 'Enith', '2001-09-24', 1, 1, 'media/ES/jugadoras/enith.png', NULL),
(69, 'Antonia Ignacia', 'Canales Pacheco', 'Canales', '2002-10-16', 25, 1, 'media/CL/jugadoras/canales.png', NULL),
(70, 'Hanane', 'Ait El Haj', 'H. Ait El Haj', '1994-11-02', 30, 2, 'media/MA/jugadoras/hanae.png', NULL),
(71, 'Emma', 'Tovar', 'E. Tovar', '2003-12-04', 18, 4, 'media/US/jugadoras/tovar.png', NULL),
(72, 'Clara', 'Capdevila López', 'Clara', '2006-04-08', 1, 13, NULL, NULL),
(73, 'Kerlly Lizeth', 'Real Carranza', 'Kerlly R.', '1998-11-07', 51, 2, 'media/EC/jugadoras/kerlly.png', NULL),
(74, 'Claudia', 'Florentino Vivó', 'Florentino', '1998-03-10', 1, 3, 'media/ES/jugadoras/florentino.png', NULL),
(75, 'Yasmin Katie', 'Mrabet Slack', 'Yasmin', '1999-08-08', 30, 5, 'media/ES/jugadoras/mrabet.png', NULL),
(76, 'Alice', 'Marques', 'Marques', '2005-05-04', 4, 3, 'media/FR/jugadoras/alice.png', NULL),
(77, 'Sara', 'Tamarit Verdeguer', 'Tamarit', '2005-11-11', 1, 2, 'media/ES/jugadoras/tamarit.png', NULL),
(78, 'Marta', 'Carro Nolasco', 'M. Carro', '1991-01-06', 1, 6, 'media/ES/jugadoras/carro.png', NULL),
(79, 'Alicja', 'Materek', 'Materek', '2001-11-07', 14, 7, 'media/PL/jugadoras/alicja.png', NULL),
(80, 'Sofia Maria', 'Cerqueira Goncalves Silva', 'Sofia S.', '2002-08-07', 41, 13, 'media/PT/jugadoras/gonzalves.png', NULL),
(81, 'Aida', 'Esteve Quintero', 'Aida', '2001-03-12', 1, 5, 'media/ES/jugadoras/esteve.png', NULL),
(82, 'Malena', 'Ortiz Cruz', 'M. Ortiz', '1997-07-16', 1, 5, 'media/ES/jugadoras/malena.png', NULL),
(83, 'Ainhoa', 'Alguacil Amores', 'Ainhoa', '2006-01-08', 1, 5, 'media/ES/jugadoras/alguacil.png', NULL),
(84, 'Olga', 'San Nicolás Rolando', 'San Nicolás', '2003-11-11', 1, 5, 'media/ES/jugadoras/san nicolas.png', NULL),
(85, 'Marina', 'Martí Serna', 'M. Martí', '1996-08-24', 1, 5, 'media/ES/jugadoras/marina marti.png', NULL),
(86, 'Paula', 'Sancho González', 'Pauleta', '1998-06-12', 1, 5, 'media/ES/jugadoras/pauleta sancho.png', NULL),
(87, 'Ana', 'Marcos Moral', 'Anita', '2000-07-09', 1, 10, 'media/ES/jugadoras/anita.png', NULL),
(88, 'Ascensión', 'Martínez Salinas', 'Asun', '2002-02-20', 1, 12, 'media/ES/jugadoras/asun.png', NULL),
(89, 'Phoenetia Maiya Lureen', 'Browne', 'Browne', '1994-04-22', 1, 10, 'media/KN/jugadoras/browne.png', NULL),
(90, 'Vitoria', 'Silva De Almeida', 'V. Almeida', '1999-08-26', 27, 10, 'media/BR/jugadoras/almeida.png', NULL),
(91, 'María Asunción', 'Quiñones Goikoetxea', 'Quiñones', '1996-10-29', 1, 1, 'media/ES/jugadoras/quiñones.png', NULL),
(92, 'Adriana', 'Nanclares Romero', 'A. Nanclares', '2002-05-09', 1, 1, 'media/ES/jugadoras/nanclares.png', NULL),
(93, 'Maddi', 'Torre Larrañaga', 'Maddi', '1996-03-30', 1, 3, 'media/ES/jugadoras/maddi.png', NULL),
(94, 'Bibiane', 'Schulze-Solano', 'Bibi', '1998-11-12', 15, 3, 'media/ES/jugadoras/bibi.png', NULL),
(95, 'Nerea', 'Nevado Gómez', 'Nerea Nevado', '2001-04-27', 1, 4, 'media/ES/jugadoras/nevado.png', NULL),
(96, 'Ane', 'Elexpuru Añorga', 'Elexpuru', '2003-05-02', 1, 2, 'media/ES/jugadoras/elexpuru.png', NULL),
(97, 'Naia', 'Landaluze Marquínez', 'Landaluze', '2000-09-25', 1, 3, 'media/ES/jugadoras/landaluze.png', NULL),
(98, 'Garazi', 'Facila Giralte', 'Gara', '1999-10-25', 1, 3, 'media/ES/jugadoras/gara.png', NULL),
(99, 'Itsaso', 'Miranda Aldasoro', 'Miranda', '2000-05-13', 1, 9, 'media/ES/jugadoras/mirandda.png', NULL),
(100, 'Marta', 'Unzué Urdaniz', 'M. Unzué', '1988-07-04', 1, 6, 'media/ES/jugadoras/unzue.png', '2025'),
(101, 'Itxaso', 'Uriarte Santamaría', 'Itxaso', '1991-09-01', 1, 5, 'media/ES/jugadoras/itxaso.png', NULL),
(102, 'Leire', 'Baños Indakoetxea', 'L. Baños', '1996-11-29', 1, 6, 'media/ES/jugadoras/leire.png', NULL),
(103, 'Mariana', 'Cerro Galán', 'Mariana', '2000-05-22', 1, 6, 'media/ES/jugadoras/mariana.png', NULL),
(104, 'Maite', 'Zubieta Arambarri', 'M. Zubieta', '2004-05-28', 1, 6, 'media/ES/jugadoras/zubieta.png', NULL),
(105, 'Irene', 'Oguiza Martínez', 'Oguiza', '2000-01-05', 1, 5, 'media/ES/jugadoras/oguiza.png', NULL),
(106, 'Clara', 'Pinedo Castresana', 'Pinedo', '2003-09-09', 1, 7, 'media/ES/jugadoras/pinedo.png', NULL),
(107, 'Maite', 'Valero Elia', 'Valero', '2003-10-05', 1, 5, 'media/ES/jugadoras/valero.png', NULL),
(108, 'Nahikari', 'García Pérez', 'Nahikari', '1997-03-10', 1, 10, 'media/ES/jugadoras/nahikari.png', NULL),
(109, 'Ainize', 'Barea Núñez', 'Peke', '1992-01-25', 1, 10, 'media/ES/jugadoras/peke.png', '2025'),
(110, 'Patricia', 'Zugasti Oses', 'P. Zugasti', '2000-08-07', 1, 10, 'media/ES/jugadoras/zugasti.png', NULL),
(111, 'Ane', 'Azkona Fuente', 'Azkona', '1998-07-15', 1, 9, 'media/ES/jugadoras/azkona.png', NULL),
(112, 'Jone', 'Amezaga Martínez', 'J. Amezaga', '2005-01-02', 1, 8, 'media/ES/jugadoras/amezaga.png', NULL),
(113, 'Marta', 'San Adrián Rocandio', 'Sanadri', '2000-02-22', 1, 10, 'media/ES/jugadoras/sanadri.png', NULL),
(114, 'Sara', 'Ortega Ruiz', 'S. Ortega', '2005-02-20', 1, 9, 'media/ES/jugadoras/ortega.png', NULL),
(115, 'Romane', 'Salvador', 'Romane Salvador', '1998-05-09', 4, 1, 'media/FR/jugadoras/romane salvador.png', NULL),
(116, 'Mar', 'Segarra Casanova', 'Mar Segarra Casanova', '2001-07-05', 1, 1, 'media/ES/jugadoras/mar segarra.png', NULL),
(117, 'Paula P. R.', 'Paula Perea Ramírez', 'Perea', '1996-06-19', 1, 4, 'media/ES/jugadoras/paula perea.png', NULL),
(118, 'Daniela', 'Caracas González', 'Daniela Caracas González', '1997-04-25', 26, 2, 'media/CO/jugadoras/caracas.png', NULL),
(119, 'Laia', 'Balleste Sciora', 'Laia Balleste Sciora', '1999-02-22', 1, 3, 'media/SUI/jugadoras/laia balleste.png', NULL),
(120, 'Arola A.', 'Arola Aparicio Gili', 'Arola Aparicio Gili', '1997-09-24', 1, 9, 'media/ES/jugadoras/arola aparicio.png', NULL),
(121, 'Júlia', 'Guerra Peiró', 'Júlia Guerra Peiró', '2002-01-23', 1, 3, 'media/ES/jugadoras/guerra.png', NULL),
(122, 'Lucía', 'Vallejo Blázquez', 'Lucía Vallejo Blázquez', '2003-07-10', 1, 4, 'media/ES/jugadoras/vallejo.png', NULL),
(123, 'Amaia', 'Martínez De La Peña', 'Amaia Martínez De La Peña', '2004-06-29', 1, 2, 'media/ES/jugadoras/amaia_martinez.png', NULL),
(124, 'Estefanía', 'Botero Granda', 'Estefanía Botero Granda', '2000-11-11', 26, 3, 'media/CO/jugadoras/simona.png', NULL),
(125, 'Ylenia', 'Estrella Gil', 'Ylenia Estrella Gil', '2004-11-11', 1, 7, NULL, NULL),
(126, 'Ana Belén', 'Hernández Rodríguez', 'Ana Belén Hernández Rodríguez', '1990-09-23', 1, 5, 'media/ES/jugadoras/ana hdez.png', NULL),
(127, 'Ainoa', 'Campo Franco', 'Ainoa Campo Franco', '1996-06-17', 1, 5, 'media/ES/jugadoras/ainoa.png', NULL),
(128, 'Carolina', 'Marín De La Fuente', 'Marín', '1996-11-27', 1, 5, 'media/ES/jugadoras/carol.png', NULL),
(129, 'Judit', 'Pablos Garrido', 'Judit Pablos Garrido', '1997-12-07', 1, 12, 'media/ES/jugadoras/pablos.png', NULL),
(130, 'Mar', 'Torrás De Fortuny', 'Mar Torrás De Fortuny', '1996-04-06', 1, 5, 'media/ES/jugadoras/mar t.png', NULL),
(131, 'Amanda', 'Mbadi', 'Amanda Mbadi', '1999-01-04', 36, 6, 'media/NG/jugadoras/mbadi.png', NULL),
(132, 'Ángeles', 'Del Álamo Sánchez', 'Álamo', '1998-06-23', 1, 10, 'media/ES/jugadoras/del alamo.png', NULL),
(133, 'Lice Fabiana', 'Chamorro Gómez', 'Lice Fabiana Chamorro Gómez', '1998-12-22', 19, 10, 'media/PY/jugadoras/chamorro.png', NULL),
(134, 'Trudi Sudan', 'Carter', 'Trudi Sudan Carter', '1994-11-18', 42, 12, 'media/JM/jugadoras/carter.png', NULL),
(135, 'Natalia', 'Montilla Martínez', 'Natalia Montilla Martínez', '1998-10-18', 1, 9, 'media/ES/jugadoras/montilla.png', NULL),
(136, 'Iara', 'Lacosta Sanchez', 'Iara Lacosta Sanchez', '2001-11-08', 1, 11, 'media/ES/jugadoras/iara.png', NULL),
(137, 'Mylene', 'Chavas', 'Chavas', '1998-01-07', 4, 1, 'media/FR/jugadoras/chavas.png', NULL),
(138, 'María Isabel', 'Rodríguez Rivero', 'Misa', '1999-07-22', 1, 1, 'media/ES/jugadoras/misa.png', NULL),
(139, 'Rocío', 'Gálvez Luna', 'Rocío', '1997-04-15', 1, 3, 'media/ES/jugadoras/rocio.png', NULL),
(140, 'Oihane', 'Hernández Zurbano', 'Oihane', '2000-05-04', 1, 2, 'media/ES/jugadoras/oihane.png', NULL),
(141, 'Maëlle Ourida Louisette', 'Lakrar', 'Lakrar', '2000-05-27', 4, 3, 'media/FR/jugadoras/lakrar.png', NULL),
(142, 'Sheila', 'García Gómez', 'Shei', '1997-03-15', 1, 2, 'media/ES/jugadoras/shei.png', NULL),
(143, 'Olga', 'Carmona García', 'Olga', '2000-06-12', 1, 4, 'media/ES/jugadoras/olga.png', NULL),
(144, 'Antônia Ronnycleide', 'Da Costa Silva', 'Antônia S.', '1994-04-26', 27, 2, 'media/BR/jugadoras/antonia.png', NULL),
(145, 'María', 'Méndez Fernández', 'Mery', '2001-04-10', 1, 3, 'media/ES/jugadoras/mery.png', NULL),
(146, 'Melanie', 'Leupolz', 'Leupolz', '1994-04-14', 15, 6, 'media/DE/jugadoras/leupolz.png', NULL),
(147, 'Caroline Elspeth Lillias', 'Weir', 'Weir', '1995-06-20', 43, 7, 'media/SS/jugadoras/weir.png', NULL),
(148, 'Maite', 'Oroz Areta', 'M. Oroz', '1998-03-25', 1, 5, 'media/ES/jugadoras/oroz.png', NULL),
(149, 'Sandie Rose', 'Toletti', 'Toletti', '1995-07-13', 4, 5, 'media/FR/jugadoras/toletti.png', NULL),
(150, 'Ingrid Filippa', 'Angeldahl', 'Angeldal', '1997-07-14', 16, 5, 'media/SE/jugadoras/angeldal.png', NULL),
(151, 'Teresa', 'Abelleira Dueñas', 'Teresa', '2000-01-09', 1, 6, 'media/ES/jugadoras/tere.png', NULL),
(152, 'Alba María', 'Redondo Ferrer', 'Redondo', '1996-08-27', 1, 10, 'media/ES/jugadoras/albi.png', NULL),
(153, 'Caroline-Sophie', 'Moller Hansen', 'Møller', '1998-12-19', 17, 10, 'media/DK/jugadoras/moller.png', NULL),
(154, 'Eva María', 'Navarro García', 'Eva Navarro', '2001-01-27', 1, 12, 'media/ES/jugadoras/eva navarro.png', NULL),
(155, 'Signe Kallesøe', 'Bruun', 'Bruun', '1998-04-06', 17, 10, 'media/DK/jugadoras/bruun.png', NULL),
(156, 'Naomie Noëlle', 'Feller', 'Feller', '2001-11-06', 4, 10, 'media/FR/jugadoras/feller.png', NULL),
(157, 'Athenea', 'Del Castillo Beivide', 'Athenea', '2000-10-24', 1, 12, 'media/ES/jugadoras/athenea.png', NULL),
(158, 'Linda Lizeth', 'Caicedo Alegria', 'Linda C.', '2005-02-22', 26, 11, 'media/CO/jugadoras/linda.png', NULL),
(159, 'Carla', 'Camacho Carrillo', 'C. Camacho', '2005-05-02', 1, 10, 'media/ES/jugadoras/camacho.png', NULL),
(160, 'Amor', 'Leigh Martín Esteban', 'Amor Leigh', '2007-12-16', 1, 13, NULL, NULL),
(161, 'Esther', 'Sullastres Ayuso', 'Sullastres', '1993-03-20', 1, 1, 'media/ES/jugadoras/sullastres.png', NULL),
(162, 'Yolanda', 'Aguirre Gutiérrez', 'Y. Aguirre', '1998-10-23', 1, 1, 'media/ES/jugadoras/yolanda a.png', NULL),
(163, 'Alba', 'López Pérez', 'Alba López', '2005-03-08', 1, 2, 'media/ES/jugadoras/alba lopez.png', NULL),
(164, 'Andrea', 'Gálvez', 'A. Gálvez', '2008-09-02', 1, 13, NULL, NULL),
(165, 'Débora', 'García Mateo', 'Débora G.', '1989-10-17', 1, 2, 'media/ES/jugadoras/debora.png', NULL),
(166, 'Eva', 'Llamas Hernández', 'Eva Llamas', '1992-05-29', 1, 3, 'media/ES/jugadoras/eva llamas.png', NULL),
(167, 'Diana Catarina Ribeiro', 'Gomes', 'Diana G.', '1998-07-26', 41, 3, 'media/PT/jugadoras/diana gomes.png', NULL),
(168, 'Raquel', 'Morcillo Aparicio', 'Raquel', '1999-04-08', 1, 4, 'media/ES/jugadoras/raquel morcillo.png', NULL),
(169, 'Nazareth', 'Martín Vázquez', 'Nazareth', '2004-02-26', 1, 3, 'media/ES/jugadoras/nazareth.png', NULL),
(170, 'Julia', 'Torres', 'J. Torres', '0000-00-00', 1, 13, NULL, NULL),
(171, 'Gemma', 'Gili Giner', 'Gemma', '1994-05-21', 1, 5, 'media/ES/jugadoras/gemma gili.png', NULL),
(172, 'Iris', 'Arnaiz Gil', 'I. Arnaiz', '1994-05-18', 1, 6, 'media/ES/jugadoras/iris arnaiz.png', NULL),
(173, 'Cinthia Pamela', 'González Medina', 'P. González', '1995-09-28', 20, 13, NULL, NULL),
(174, 'Alicia', 'Redondo González', 'Alicia', '2001-11-02', 1, 6, 'media/ES/jugadoras/alicia.png', NULL),
(175, 'Millaray Scarleth', 'Cortés Espinoza', 'Cortés', '2004-06-30', 25, 7, NULL, NULL),
(176, 'Fatoumata', 'Kanteh Cham', 'Kanteh', '1997-07-02', 1, 10, 'media/ES/jugadoras/kanteh.png', NULL),
(177, 'Natalia Alessandra', 'Padilla Bidas', 'Padilla Bidas', '2002-11-06', 14, 12, 'media/PL/jugadoras/padilla.png', NULL),
(178, 'Fatima Zahra', 'Tagnaout', 'Tagnaout', '1999-01-20', 30, 11, 'media/MA/jugadoras/tagnaout.png', NULL),
(179, 'Paula', 'Partido Durán', 'P. Partido', '2005-03-02', 1, 10, 'media/ES/jugadoras/partido.png', NULL),
(180, 'Lucia', 'Corrales Álvarez', 'L. Corrales', '2005-11-24', 1, 11, 'media/ES/jugadoras/corrales.png', NULL),
(181, 'Lucía', 'Moral Ruiz', 'Wifi', '2004-02-11', 1, 10, 'media/ES/jugadoras/wifi.png', NULL),
(182, 'Inês', 'Teixeira Pereira', 'Inês Pereira', '1999-05-26', 41, 1, 'media/PT/jugadoras/ines pereira.png', NULL),
(183, 'Yohana', 'Gómez Camino', 'Yohana', '1994-01-20', 1, 1, 'media/ES/jugadoras/yohana.png', NULL),
(184, 'Francisca Alejandra', 'Lara Lara', 'F. Lara', '1990-07-29', 25, 4, 'media/CL/jugadoras/lara.png', NULL),
(185, 'Raquel', 'García Yagüe', 'Raquel G.', '1997-04-22', 1, 3, 'media/ES/jugadoras/raquel.png', NULL),
(186, 'Cristina', 'Martínez Gutiérrez', 'Cris M.', '1993-06-26', 1, 2, 'media/ES/jugadoras/cris m.png', NULL),
(187, 'Samara', 'Ortiz Cruz', 'S. Ortiz', '1997-07-16', 1, 4, 'media/ES/jugadoras/Samara.png', NULL),
(188, 'Vera', 'Martínez Viota', 'Vera', '1999-09-13', 1, 3, 'media/ES/jugadoras/vera.png', NULL),
(189, 'Marina', 'Artero Moreno', 'M. Artero', '2005-10-14', 1, 3, 'media/ES/jugadoras/artero.png', NULL),
(190, 'Lucía', 'Martínez González', 'Lucía', '2001-11-27', 1, 6, 'media/ES/jugadoras/lucia.png', NULL),
(191, 'Bárbara', 'Latorre Viñals', 'Bárbara', '1993-03-14', 1, 11, 'media/ES/jugadoras/barbi.png', NULL),
(192, 'Patrícia', 'Hmírová', 'Hmírová', '1993-11-30', 44, 12, 'media/SK/jugadoras/hmirová.png', NULL),
(193, 'Paula', 'Gutiérrez Caballero', 'Paula G.', '2001-03-02', 1, 5, 'media/ES/jugadoras/paula g.png', NULL),
(194, 'Carlota', 'Sánchez Sánchez', 'Carlota', '2002-01-21', 1, 5, 'media/ES/jugadoras/carlota.png', NULL),
(195, 'Henar', 'Muiña Asla', 'Henar', '1999-10-20', 1, 5, 'media/ES/jugadoras/henar.png', NULL),
(196, 'Eva', 'Dios Nieto', 'Eva Dios', '2002-03-04', 1, 5, 'media/ES/jugadoras/eva dios.png', NULL),
(197, 'Olaya', 'Enrique Rodríguez', 'Olaya', '2005-05-10', 1, 7, 'media/ES/jugadoras/olaya.png', NULL),
(198, 'Oriana Yoselyn', 'Altuve Mancilla', 'Altuve', '1992-10-03', 22, 10, 'media/VE/jugadoras/altuve.png', NULL),
(199, 'Ainhoa', 'Marín Martín', 'Ainhoa M.', '2001-03-21', 1, 12, 'media/ES/jugadoras/ainhoa.png', NULL),
(200, 'Ana Lucía', 'De Teresa Romero', 'ADT', '2001-11-05', 1, 10, 'media/ES/jugadoras/adt.png', NULL),
(201, 'Millene', 'Cabral Vieira', 'Millene', '1997-11-29', 27, 10, 'media/BR/jugadoras/millene.png', NULL),
(202, 'Noelia', 'Gil Pérez', 'Noelia Gil', '1994-05-23', 1, 1, NULL, NULL),
(203, 'Paula', 'Vizoso Prieto', 'P. Vizoso', '2000-02-17', 1, 1, NULL, NULL),
(204, 'Nuria', 'Ligero Fernández', 'Nana', '1991-09-04', 1, 2, NULL, NULL),
(205, 'Erika', 'Santoro', 'Santoro', '1999-09-03', 6, 2, NULL, NULL),
(206, 'Dorine Nina', 'Chuigoue', 'Dorine', '1988-11-28', 32, 3, 'media/CM/jugadoras/dorine.png', NULL),
(207, 'María', 'Jiménez Gutiérrez', 'M. Jiménez', '2000-09-17', 1, 3, NULL, NULL),
(208, 'Esther', 'Martín-Pozuelo Aranda', 'Esther', '1998-10-08', 1, 4, NULL, NULL),
(209, 'Blanca', 'Muñoz García', 'Blanca Muñoz', '1999-11-11', 1, 2, NULL, NULL),
(210, 'Carla', 'Santaliestra Alonso', 'Carla Santaliestra', '2003-08-12', 1, 10, NULL, NULL),
(211, 'Marina', 'Sánchez Romero', 'Marina Sánchez', '2000-11-11', 1, 5, NULL, NULL),
(212, 'Alba', 'Rodao Alonso', 'A. Rodao', '2006-01-28', 1, 10, NULL, NULL),
(213, 'Rhiannon Beth', 'Roberts', 'Roberts', '1990-08-30', 2, 3, 'media/WAL/jugadoras/roberts.png', NULL),
(214, 'Estela', 'Fernández Pablos', 'Estela', '1991-05-09', 1, 5, 'media/ES/jugadoras/estella.png', NULL),
(215, 'Naima', 'García Aguilar', 'Naima', '1998-06-24', 1, 12, NULL, NULL),
(216, 'Rosa', 'Márquez Baena', 'Rosa M.', '2000-12-22', 1, 5, NULL, NULL),
(217, 'María', 'Ruiz Gámez', 'María Ruiz', '2001-01-11', 1, 10, NULL, NULL),
(218, 'Gema', 'Soliveres Cholbi', 'Gema', '2000-11-03', 1, 5, NULL, NULL),
(219, 'Carla', 'Armengol Joaniquet', 'Carla', '1998-04-02', 1, 11, NULL, NULL),
(220, 'Carolina', 'Férez Méndez', 'Carol', '1991-06-26', 1, 7, NULL, NULL),
(221, 'Tiffany Devonna', 'Cameron', 'T. Cameron', '1991-10-16', 42, 10, 'media/JM/jugadoras/cameron.png', NULL),
(222, 'Júlia', 'Aguado Fernández', 'Júlia', '2000-05-02', 1, 10, NULL, NULL),
(223, 'Carmen', 'Álvarez Sánchez', 'Carmen Á.', '2003-02-24', 1, 10, NULL, NULL),
(224, 'Yasmine', 'Zouhir', 'Zouhir', '2005-07-16', 30, 10, 'media/FR/jugadoras/zouhir.png', NULL),
(225, 'Elene', 'Lete Para', 'Elene', '2002-05-07', 1, 1, 'media/ES/jugadoras/elene lete.png', NULL),
(226, 'Olatz', 'Santana Amado', 'Olatz', '1997-05-08', 1, 1, 'media/ES/jugadoras/olatz.png', NULL),
(227, 'Lucía María', 'Rodríguez Herrero', 'Lucia', '1999-05-24', 1, 4, 'media/ES/jugadoras/lucia_perez.png', NULL),
(228, 'Ane', 'Etxezarreta Aierbe', 'Etxezarreta ', '1995-08-24', 1, 3, 'media/ES/jugadoras/ane.png', NULL),
(229, 'Emma', 'Ramírez Gorgoso', 'Ramírez', '2002-05-10', 1, 2, 'media/ES/jugadoras/emma.png', NULL),
(230, 'Nora', 'Sarriegi Galdós', 'Nora', '2001-02-24', 1, 10, 'media/ES/jugadoras/sarriegi.png', NULL),
(231, 'Manuela', 'Vanegas Cataño', 'Manuela', '2000-11-09', 26, 3, 'media/CO/jugadoras/vanegas.png', NULL),
(232, 'Izarne', 'Sarasola Beain', 'Izarne', '2002-02-17', 1, 4, 'media/ES/jugadoras/izarne.png', NULL),
(233, 'María', 'Valle López', 'Valle', '2004-11-14', 1, 3, 'media/ES/jugadoras/valle.png', NULL),
(234, 'Nahia', 'Aparicio Jaular', 'Apari', '2004-01-07', 1, 3, 'media/ES/jugadoras/apari.png', NULL),
(235, 'Claire', 'Lavogez', 'Claire', '1994-06-18', 4, 10, 'media/FR/jugadoras/lavogez.png', NULL),
(236, 'Klara', 'Cahynová', 'Centro', '1993-12-20', 45, 6, 'media/CZ/jugadoras/cahynova.png', NULL),
(237, 'Nerea', 'Eizagirre Lasa', 'Nerea', '2000-01-04', 1, 11, 'media/ES/jugadoras/eizaguirre.png', NULL),
(238, 'Andreia', 'De Jesus Jacinto', 'Andreia', '2002-06-08', 41, 6, 'media/PT/jugadoras/andreia.png', NULL),
(239, 'Jacqueline', 'Owusu', 'Owusu', '2002-06-12', 34, 5, 'media/GH/jugadoras/jacqueline.png', NULL),
(240, 'Elene', 'Viles Odriozola', 'Viles', '2001-07-02', 1, 2, 'media/ES/jugadoras/viles.png', NULL),
(241, 'Cecilia', 'Marcos Nabal', 'Marcos', '2001-11-03', 1, 11, 'media/ES/jugadoras/cecilia marcos.png', NULL),
(242, 'Sanni Maija', 'Franssi', 'Sanni', '1995-03-19', 49, 10, 'media/FI/jugadoras/franssi.png', NULL),
(243, 'Lorena', 'Navarro Domínguez', 'Lorena', '2000-11-11', 1, 5, 'media/ES/jugadoras/lorena.png', NULL),
(244, 'Mirari', 'Uria Gabilondo', 'Mirari', '2003-01-01', 1, 12, 'media/ES/jugadoras/mirari.png', NULL),
(245, 'Amaiur', 'Sarriegi Isasa', 'Amaiur', '2000-12-13', 1, 12, 'media/ES/jugadoras/amaiur.png', NULL),
(246, 'Lucía', 'Pardo Méndez', 'Pardo', '2000-01-05', 1, 10, 'media/ES/jugadoras/pardo.png', NULL),
(247, 'Violeta', 'García Quiles', 'Quiles', '1999-12-10', 1, 8, 'media/ES/jugadoras/quiles.png', NULL),
(248, 'Andrea', 'Romero Burgos', 'Romero', '1995-02-13', 1, 1, 'media/ES/jugadoras/andrea romero.png', NULL),
(249, 'Sandra', 'Estévez Ogalla', 'Ogalla', '2002-07-15', 1, 1, 'media/ES/jugadoras/sandra estevez.png', NULL),
(250, 'Laura', 'Sánchez Comuñas', 'Laura', '2006-05-15', 1, 1, 'media/ES/jugadoras/laura_sanchez.png', NULL),
(251, 'Marta', 'Carrasco García', 'Carrasco', '1994-09-16', 1, 3, 'media/ES/jugadoras/marta carrasco.png', NULL),
(252, 'Cristina', 'Postigo Martín', 'Cristina', '1998-04-27', 1, 3, 'media/ES/jugadoras/postigo.png', NULL),
(253, 'Alba', 'Pérez Manrique', 'Alba', '2000-06-18', 1, 2, 'media/ES/jugadoras/alba perez.png', NULL),
(254, 'Naroa', 'Uriarte Urazurrutia', 'Naroa', '2001-02-05', 1, 3, 'media/ES/jugadoras/naroa.png', NULL),
(255, 'Juliana', 'Aparecida Paulino Cardozo', 'Jujuba', '1991-09-06', 27, 3, 'media/BR/jugadoras/jujuba.png', NULL),
(256, 'Isabel', 'Álvarez Tenorio', 'Isabel', '1999-06-12', 1, 3, 'media/ES/jugadoras/isabel.png', NULL),
(257, 'Clara', 'Rodríguez García', 'Clara', '2003-02-12', 1, 4, 'media/ES/jugadoras/clara.png', NULL),
(258, 'María', 'De Los Ángeles Carrión Egido', 'Leles', '1997-02-22', 1, 5, 'media/ES/jugadoras/leles.png', NULL),
(259, 'Ariadna', 'Mingueza García', 'Mingueza', '2003-03-22', 1, 5, 'media/ES/jugadoras/ari min.png', NULL),
(260, 'Ornella', 'María Vignola Cabot', 'Ornella', '2004-09-30', 1, 8, 'media/ES/jugadoras/ornella.png', NULL),
(261, 'Miku', 'Kojima', 'Miku', '1999-11-06', 38, 9, 'media/JP/jugadoras/miku.png', NULL),
(262, 'Amaia', 'Iribarren Arteta', 'Amaia', '2003-06-06', 1, 5, 'media/ES/jugadoras/amaia.png', NULL),
(263, 'Laura María', 'Pérez Martín', 'Laura', '1998-06-15', 1, 9, 'media/ES/jugadoras/laura perez.png', NULL),
(264, 'Laura', 'Requena Sánchez', 'Lauri', '1990-05-25', 1, 8, 'media/ES/jugadoras/lauri.png', NULL),
(265, 'Biljana', 'Bradić', 'Biljana', '1991-04-24', 9, 10, 'media/RS/jugadoras/bradic.png', NULL),
(266, 'Paula', 'Arana Montes', 'Arana', '2001-11-08', 1, 11, 'media/ES/jugadoras/arana.png', NULL),
(267, 'Lucía', 'Ramos Narváez', 'Lucía', '1999-09-13', 1, 8, 'media/ES/jugadoras/ramos.png', NULL),
(268, 'Edna', 'Imade', 'Imade', '2000-10-05', 36, 10, 'media/NG/jugadoras/imade.png', NULL),
(269, 'Andrea', 'Gómez Oliver', 'Gómez', '2003-05-14', 1, 10, 'media/ES/jugadoras/gomez.png', NULL),
(270, 'Alexia', 'Fernández Díaz', 'Alexia', '2002-05-28', 1, 11, 'media/ES/jugadoras/alexia_fernandez.png', NULL),
(271, 'Inés', 'Rizo Galiano', 'Inés', '2004-11-12', 1, 10, 'media/ES/jugadoras/inés rizo.png', NULL),
(272, 'Sydney', 'Joy Schertenleib', 'Sydney', '2007-01-30', 8, 5, 'media/SUI/jugadoras/sydney.png', NULL),
(290, 'María', 'Miralles Gascón', 'Gascón', '1997-05-28', 1, 1, 'media/ES/jugadoras/gascon.png', NULL),
(291, 'Noelia', 'García Domenech', 'Noelia', '1992-09-25', 1, 1, 'media/ES/jugadoras/noelia.png', NULL),
(292, 'Elba', 'Vergés Prats', 'Elba', '1995-10-24', 1, 3, 'media/ES/jugadoras/elba.png', NULL),
(293, 'Andrea Maddalen', 'Sierra Larrauri', 'Andrea', '1998-05-15', 1, 2, 'media/ES/jugadoras/sierra.png', NULL),
(294, 'Patricia', 'Ojeda Ramírez', 'Ojeda', '1991-03-08', 1, 3, 'media/ES/jugadoras/patri ojeda.png', NULL),
(295, 'Alena', 'Pěčková', 'Alena', '2001-03-30', 45, 3, 'media/CZ/jugadoras/alena.png', NULL),
(296, 'Annelie', 'Leitner', 'Annelie', '1996-06-15', 46, 2, 'media/AT/jugadoras/annelie.png', NULL),
(297, 'Carla', 'Andrés Abad', 'Carla', '2002-12-12', 1, 3, 'media/ES/jugadoras/carla.png', NULL),
(298, 'Eider', 'Arana Mugueta', 'Eider', '2002-04-11', 1, 4, 'media/ES/jugadoras/eider.png', NULL),
(299, 'Mireia', 'Masegur Torrent', 'Masegur', '2002-08-19', 1, 3, 'media/ES/jugadoras/mireia.png', NULL),
(300, 'Arene', 'Altonaga Etxebarria', 'Arene', '1993-02-25', 1, 5, 'media/ES/jugadoras/arene.png', NULL),
(301, 'Eva', 'Van Deursen', 'Eva', '1999-01-21', 7, 5, 'media/NL/jugadoras/van deursen.png', NULL),
(302, 'Leire', 'Peña Ruiz', 'Leire', '2001-06-20', 1, 6, 'media/ES/jugadoras/leire peña.png', NULL),
(303, 'Amani', 'Kakounan Bernadette', 'Amani', '1997-09-05', 33, 6, 'media/CI/jugadoras/amani.png', NULL),
(304, 'Esperanza', 'Pizarro Pagalday', 'Pizarro', '2001-04-15', 20, 5, 'media/UY/jugadoras/pizarro.png', NULL),
(305, 'Ane', 'Campos Andueza', 'Campos', '1999-05-21', 1, 10, 'media/ES/jugadoras/ane campos.png', NULL),
(306, 'Margherita', 'Monnecchi', 'Monnecchi', '2001-11-06', 6, 10, 'media/IT/jugadoras/monacchi.png', NULL),
(307, 'Andrea Abigail', 'Álvarez Donis', 'Andrea', '2003-01-13', 24, 10, 'media/GT/jugadoras/andrea.png', NULL),
(308, 'Laura', 'Camino Fernández', 'Laura', '2002-04-01', 1, 11, 'media/ES/jugadoras/camino.png', NULL),
(309, 'María', 'López Valenzuela', 'Valenzuela', '2002-11-26', 1, 1, 'media/ES/jugadoras/valenzuela.png', NULL),
(310, 'Laura', 'Coronado Vílchez', 'Laura', '2003-04-06', 1, 1, 'media/ES/jugadoras/coronado.png', NULL),
(311, 'Laia', 'García Dalmases', 'Laura', '2000-12-19', 1, 1, 'media/ES/jugadoras/laia.png', NULL),
(312, 'Melanie', 'Serrano Pérez', 'Melanie', '1989-10-12', 1, 3, 'media/ES/jugadoras/melanie.png', NULL),
(313, 'Ana', 'González Rosa', 'Ana', '1995-03-26', 1, 6, 'media/ES/jugadoras/ana g.png', NULL),
(314, 'Berta', 'Pujadas Boix', 'Berta', '2000-04-09', 1, 3, 'media/ES/jugadoras/berta pujadas.png', NULL),
(315, 'Cristina', 'Cubedo Pitarch', 'Cubedo', '1999-10-21', 1, 3, 'media/ES/jugadoras/cubedo.png', NULL),
(316, 'Itziar', 'Pinillos Moreno', 'Itziar', '2000-10-21', 1, 2, 'media/ES/jugadoras/itzi.png', NULL),
(317, 'Morgane', 'Nicoli', 'Morgane', '1997-04-07', 4, 3, 'media/FR/jugadoras/nicoli.png', NULL),
(318, 'Sonia', 'García Majarín', 'Sonia', '2002-12-06', 1, 6, 'media/ES/jugadoras/majarin.png', NULL),
(319, 'Júlia', 'Mora Tobías', 'Júlia', '1997-10-14', 1, 3, 'media/ES/jugadoras/julia mora.png', NULL),
(320, 'Cristina', 'Baudet Lucena', 'Baudet', '1991-07-08', 1, 7, 'media/ES/jugadoras/baudet.png', NULL),
(321, 'Nuria', 'Garrote Camuñez', 'Garrote', '1997-06-10', 1, 2, 'media/ES/jugadoras/nuria garr.png', NULL),
(322, 'Estefanía Romina', 'Banini Ruiz', 'Banini', '1990-06-26', 28, 5, 'media/AR/jugadoras/banini.png', NULL),
(323, 'María', 'Llompart Pons', 'Llompart', '2000-10-19', 1, 5, 'media/ES/jugadoras/llompart.png', NULL),
(324, 'Young-Ju', 'Lee', 'Young', '1992-04-22', 37, 6, 'media/KR/jugadoras/lee.png', NULL),
(325, 'Ghizlane', 'Chebbak', 'Ghizlane', '1991-02-19', 30, 5, 'media/MA/jugadoras/cgebbak.png', NULL),
(326, 'Laura', 'Martínez González', 'Laura', '1999-01-29', 1, 5, 'media/ES/jugadoras/laura.png', NULL),
(327, 'Rebecca Grace', 'Elloh Amon', 'Grace', '1994-12-25', 33, 11, 'media/CI/jugadoras/rebecca.png', NULL),
(328, 'Macarena', 'Portales Nieto', 'Maca', '1998-08-02', 1, 11, 'media/ES/jugadoras/maca.png', NULL),
(329, 'Elena', 'Julve Pérez', 'Julve', '2000-12-08', 1, 12, 'media/ES/jugadoras/julve.png', NULL),
(330, 'Irina Priscilla', 'Uribe García', 'Uribe', '1998-07-29', 1, 10, 'media/ES/jugadoras/irina.png', NULL),
(331, 'María Del Pilar', 'Garrote Camuñez', 'Pilar', '1997-06-10', 1, 5, 'media/ES/jugadoras/pilar.png', NULL),
(332, 'Paola', 'Ulloa Jiménez', 'Paola U.J.M.', '1996-12-26', 1, 1, 'media/ES/jugadoras/ulloa.png', NULL),
(333, 'Belén', 'De Gracia Ruiz', 'Belén', '2004-04-12', 1, 1, 'media/ES/jugadoras/belen.png', NULL),
(334, 'Núria', 'Mendoza Miralles', 'N. Mendoza', '1995-12-15', 1, 3, 'media/ES/jugadoras/mendo.png', NULL),
(335, 'Mónica', 'Hickmann Alves', 'Mônica', '1987-04-21', 27, 3, 'media/BR/jugadoras/monica.png', NULL),
(336, 'Allegra', 'Poljak', 'Allegra', '1999-02-05', 9, 4, 'media/RS/jugadoras/allegra.png', NULL),
(337, 'Aldana', 'Cometti', 'Cometti', '1996-03-03', 28, 3, 'media/AR/jugadoras/cometti.png', NULL),
(338, 'Esther', 'Laborde Cabanillas', 'Esther', '2004-04-20', 1, 2, 'media/ES/jugadoras/laborde.png', NULL),
(339, 'Sandra', 'Villafañe Serrada', 'Villafañe', '2005-09-18', 1, 3, 'media/ES/jugadoras/villafañe.png', NULL),
(340, 'Freja Siri', 'Olofsson', 'Freja Siri', '1998-05-24', 16, 6, 'media/SE/jugadoras/freja.png', NULL),
(341, 'Hildur', 'Antonsdottir', 'Antonsdottir', '1995-09-18', 47, 5, 'media/IS/jugadoras/antonsdottir.png', NULL),
(342, 'Karen Andrea', 'Araya Ponce', 'Araya', '1990-10-16', 25, 5, 'media/CL/jugadoras/araya.png', NULL),
(343, 'María Florencia', 'Bonsegundo', 'Bonsegundo', '1993-07-14', 28, 7, 'media/AR/jugadoras/bonsegundo.png', NULL),
(344, 'Malou', 'Marcetto Rylov', 'Marcetto', '2003-04-16', 17, 6, 'media/DK/jugadoras/marcetto.png', NULL),
(345, 'Marina', 'Rivas Jaén', 'Marina', '2005-07-02', 1, 5, 'media/ES/jugadoras/marina.png', NULL),
(346, 'Cristina', 'Librán Quiroga', 'Librán', '2006-06-11', 1, 5, 'media/ES/jugadoras/libran.png', NULL),
(347, 'Paula', 'León Breña', 'Paula León', '2001-01-23', 1, 10, 'media/ES/jugadoras/paula leon.png', NULL),
(348, 'Alba', 'Ruiz Soto', 'A. Ruiz', '2003-06-20', 1, 10, 'media/ES/jugadoras/alba.png', NULL),
(349, 'Laura', 'Domínguez Rojo', 'Laurita', '1997-08-12', 1, 8, 'media/ES/jugadoras/laurita.png', NULL),
(350, 'Emily', 'Assis De Carvalho', 'Emily', '2002-02-22', 27, 12, 'media/BR/jugadoras/emily.png', NULL),
(351, 'Kamilla', 'Melgård', 'Melgård', '2005-12-16', 3, 10, 'media/NO/jugadoras/melgard.png', NULL),
(352, 'Bárbara', 'López Gorrado', 'Bárbara', '2005-08-30', 1, 10, 'media/ES/jugadoras/barbara.png', NULL),
(353, 'Kayla Jay', 'McKenna', 'McKenna', '1996-09-03', 42, 10, 'media/JM/jugadoras/McKenna.png', NULL),
(354, 'Noelia', 'Ramos Álvarez', 'Noelia Ramos', '1999-02-10', 1, 1, 'media/ES/jugadoras/noelia ramos.png', NULL),
(355, 'María', 'Echezarreta Fernández', 'Cheza', '2001-07-19', 1, 1, 'media/ES/jugadoras/cheza.png', NULL),
(356, 'Nekane', 'Morales Morán', 'N. Morales', '2002-05-19', 1, 13, NULL, NULL),
(357, 'María', 'Estella Del Valle', 'Estella', '1994-06-10', 1, 2, NULL, NULL),
(358, 'Cinta', 'Rodríguez Toronjo', 'Cinta R.', '1999-11-07', 1, 3, 'media/ES/jugadoras/cinta.png', NULL),
(359, 'Raquel', 'Peña Rodríguez', 'Pisco', '1988-12-20', 1, 4, 'media/ES/jugadoras/pisco.png', NULL),
(360, 'Beatriz', 'Beltrán Sanz', 'B. Beltrán', '1997-12-10', 1, 4, 'media/ES/jugadoras/bea beltrán.png', NULL),
(361, 'Claudia', 'Roldán Blanco', 'Clau Blanco', '1997-03-11', 1, 4, 'media/ES/jugadoras/clau blanco.png', NULL),
(362, 'Andrea', 'Marrero Avero', 'A. Marrero', '1996-10-06', 1, 3, 'media/ES/jugadoras/marrero.png', NULL),
(363, 'Thais Cristina', 'Da Silva Ferreira', 'Thaís Ferreira', '1996-05-01', 27, 3, 'media/BR/jugadoras/thais ferreira.png', NULL),
(364, 'Barbara Crisbelis', 'Martinez Flores', 'B. Martinez', '2003-04-22', 22, 5, 'media/VE/jugadoras/crisbelis.png', NULL),
(365, 'Sandra', 'Castelló Oliver', 'S. Castelló', '1993-08-07', 1, 6, 'media/ES/jugadoras/castelló.png', NULL),
(366, 'Patricia', 'Gavira Collado', 'Patri Gavira', '1989-04-26', 1, 3, 'media/ES/jugadoras/gavira.png', NULL),
(367, 'Natalia', 'Ramos Álvarez', 'N. Ramos', '1999-02-10', 1, 6, 'media/ES/jugadoras/natalia ramos.png', NULL),
(368, 'Yerliane Glamar', 'Moreno Hernández', 'Moreno', '2000-10-13', 22, 5, 'media/VE/jugadoras/yerliane.png', NULL),
(369, 'Lucía', 'Méndez Méndez', 'L. Méndez', '1999-02-19', 1, 5, 'media/ES/jugadoras/lucía méndez.png', NULL),
(370, 'Paola', 'Hernández Díaz', 'Paola H.D.', '2002-07-25', 1, 5, 'media/ES/jugadoras/paola hernández.png', NULL),
(371, 'Claudia', 'Iglesias De La Cruz', 'Bicho', '2003-08-30', 1, 5, 'media/ES/jugadoras/bicho.png', NULL),
(372, 'Ainhoa', 'Delgado', 'Ainhoa Delgado', '2004-07-02', 1, 13, NULL, NULL),
(373, 'María José', 'Pérez González', 'Mari Jose', '1984-03-19', 1, 11, 'media/ES/jugadoras/mari jose.png', NULL),
(374, 'Koko Ange Mariette Christelle', 'N\'guessan N\'Guessan', 'Koko Ange', '1990-11-18', 33, 12, 'media/CI/jugadoras/koko ange.png', NULL),
(375, 'Rinsola', 'Babajide', 'Babajide', '1998-06-17', 2, 12, 'media/NG/jugadoras/babajide.png', NULL),
(376, 'Nina', 'Richard', 'Richard', '2000-06-09', 4, 5, 'media/FR/jugadoras/richard.png', NULL),
(377, 'Aleksandra', 'Zaremba Kupiec', 'Aleksandra', '2001-02-19', 14, 2, 'media/PL/jugadoras/zaremba.png', NULL),
(378, 'Sakina', 'Ouzraoui Diki', 'S. Ouzraoui', '2001-08-29', 30, 10, 'media/MA/jugadoras/ouzraoui.png', NULL),
(379, 'Gift Nyakno', 'Monday', 'Monday G.', '2001-12-09', 36, 11, 'media/NG/jugadoras/monday.png', NULL),
(380, 'Jassina', 'Blom', 'Blom', '1994-09-03', 48, 10, 'media/BE/jugadoras/blom.png', NULL),
(381, 'Jackie Noëlle', 'Groenen', 'Groenen', '1994-12-17', 7, 5, 'media/NL/jugadoras/groenen.png', NULL),
(382, 'Lotte', 'Keukelaar', 'Lotte', '2005-09-25', 7, 10, 'media/NL/jugadoras/lotte_keukelaar.png', NULL),
(383, 'Jill Jamie', 'Roord ', 'Roord', '1997-04-22', 7, 7, 'media/NL/jugadoras/jill roord.png', NULL),
(384, 'Daphne', 'van Domselaar', 'Daph', '2000-03-06', 7, 1, 'media/NL/jugadoras/Daphne van Doomselaar.png', NULL),
(385, 'Olga', 'San Nicolás Rolando', 'San Nicolás', '2003-11-11', 1, 13, NULL, NULL),
(386, 'María Victoria', 'Losada Gómez', 'Losada', '1991-03-05', 1, 5, NULL, NULL),
(387, 'Nuria', 'Rabano Blanco', 'Rabano', '1999-06-15', 1, 4, NULL, NULL),
(388, 'María Paz', 'Vilas Dono', 'Mapi', '1988-02-01', 1, 10, 'media/ES/jugadoras/mapigol.png', '2023'),
(389, 'Bruna', 'Vilamala Costa', 'Bruna', '2002-06-04', 1, 10, NULL, NULL),
(390, 'Giulia', 'Dragoni', 'Dragoni', '2006-11-07', 6, 5, NULL, NULL),
(391, 'Ana', 'Tejada Jimenez', 'Tejada', '2002-06-02', 1, 3, NULL, '0000'),
(392, 'Celia', 'Jiménez Delgado', 'Celia', '1995-06-20', 1, 3, NULL, '0000'),
(393, 'Sonia', 'Prim Fernández', 'Prim', '1984-11-05', 1, 3, NULL, '2019'),
(394, 'Erika', 'Vázquez Morales', 'Erika V.', '1983-02-16', 1, 10, NULL, '2022'),
(395, 'Sonia', 'Bermúdez Tribano', 'Sonia', '1984-11-15', 1, 10, NULL, '2020'),
(396, 'Ruth', 'García García', 'Ruth', '1987-03-26', 1, 3, NULL, '2020'),
(397, 'Cristina', 'Martín-Prieto Gutiérrez', 'Martín-Prieto', '1993-03-14', 1, 10, NULL, '0000'),
(398, 'Laura', 'Ràfols Parellada', 'Ràfols', '1990-06-23', 1, 1, NULL, '2018'),
(399, 'Ana María', 'Romero Moreno', 'Willy', '1987-06-14', 1, 10, NULL, '2020'),
(400, 'Paula', 'Nicart Mejías', 'Nicart', '1994-09-08', 1, 3, NULL, '2022'),
(401, 'Lucia', 'García Córdoba', 'Lucia', '1998-11-14', 1, 10, NULL, '0000'),
(402, 'Olga', 'García Pérez', 'Olga', '1992-06-01', 1, 10, NULL, '2024'),
(403, 'Mariví', 'Simó Marco', 'Mariví', '1983-04-25', 1, 3, NULL, '2016'),
(404, 'Virginia', 'Torrecilla Reyes', 'Torrecilla', '1994-09-04', 1, 5, NULL, '2024'),
(405, 'Maitane', 'López Millán', 'Mai', '1995-03-13', 1, 5, NULL, '0000'),
(406, 'Paula', 'Tomas Serer', 'Tomi', '2001-09-11', 1, 4, NULL, '0000'),
(407, 'Inmaculada', 'Gabarro Romero', 'Gabarro', '2002-11-05', 1, 5, NULL, '0000'),
(408, 'Oihane', 'Valdezate Cabornero', 'Valdezate', '2000-04-10', 1, 5, NULL, '0000'),
(409, 'Paula', 'Domínguez Encinas', 'Pauleta', '1997-08-11', 1, 5, NULL, '0000'),
(410, 'Ivana', 'Andrés Sanz', 'Ivana', '1994-07-13', 1, 3, NULL, '0000'),
(411, 'Julia', 'Bartel Holgado', 'Bartel', '2004-05-18', 1, 5, NULL, '0000'),
(412, 'Ariana', 'Arias Jiménez', 'Ari', '2003-05-25', 1, 10, NULL, '0000'),
(413, 'Verónica Charlyn', 'Corral Ang', 'Charlyn', '1991-09-11', 21, 10, NULL, '0000'),
(414, 'Jennifer', 'Hermoso Fuentes', 'Jenni', '1990-05-09', 1, 10, NULL, '0000'),
(415, 'Marta', 'Corredera Rueda', 'Corredera', '1991-08-08', 1, 3, NULL, '2023'),
(416, 'Laura ', 'Gutiérrez Navarro', 'Guti', '1994-05-02', 1, 5, NULL, '2020'),
(417, 'Lucia', 'Gómez García', 'Luci', '1996-10-11', 1, 3, NULL, '0000'),
(418, 'Andrea', 'Sánchez Falcón', 'Falcón', '1997-02-28', 1, 4, NULL, '0000'),
(419, 'Sandra', 'Paños García-Villamil', 'Paños', '1992-11-04', 1, 1, NULL, '0000'),
(420, 'Andrea', 'Pereira Cejudo', 'Pere', '1993-09-19', 1, 3, NULL, '0000'),
(421, 'Veronica', 'Boquete Giadans', 'Vero', '1987-04-09', 1, 10, NULL, '0000'),
(422, 'Leila', 'Ouahabi El Ouahabi', 'Leia', '1993-03-22', 1, 4, NULL, '0000'),
(423, 'Laia', 'Aleixandri López', 'Aleixandri', '2000-08-25', 1, 3, NULL, '0000'),
(424, 'Laia', 'Codina Panedas', 'Codina', '2000-01-22', 1, 3, NULL, '0000'),
(425, 'Maria Francesca', 'Caldentey Oliver', 'Mariona', '1996-03-19', 1, 11, NULL, '0000'),
(426, 'Esther', 'González Rodríguez', 'Esther', '1992-12-08', 1, 10, NULL, '0000'),
(427, 'Claudia', 'Zornoza Sánchez', 'Zornoza', '1990-10-20', 1, 5, NULL, '0000'),
(428, 'Beatriz ', 'Parra Salas', 'Bea Parra', '1987-07-31', 1, 5, NULL, '0000'),
(429, 'Kheira', 'Hamraoui ', 'Hamraoui ', '1990-01-13', 4, 5, NULL, '0000'),
(430, 'Anna Maria', 'Crnogorcevic', 'Crnogorcevic', '1990-10-03', 8, 4, NULL, '0000'),
(431, 'Alejandra', 'Bernabé de Santiago', 'Alejandra', '2001-11-12', 1, 4, NULL, '0000'),
(432, 'Marta', 'Cazalla Garcia', 'Cazalla', '1997-04-05', 1, 3, NULL, '0000'),
(433, 'Marta', 'Vieira Da Silva', 'Marta Vieira', '1986-02-19', 27, 10, NULL, '0000'),
(434, 'Ludmila', 'da Silva', 'Ludmila', '1994-12-01', 27, 10, NULL, '0000'),
(435, 'Claudia Christiane ', 'Endler Mutinelli', 'Endler', '1991-07-23', 25, 1, NULL, '0000'),
(436, 'Sofie', 'Svava', 'Svava', '2000-08-11', 17, 3, NULL, '0000'),
(437, 'Damaris Berta', 'Egurrola Wienke', 'Damaris', '1999-08-26', 7, 5, 'media/NL/jugadoras/damaris.png', '0000'),
(438, 'Ada Martine', 'Stolsmo Hegerberg', 'Ada Hegerberg', '1995-07-10', 3, 10, NULL, '0000'),
(439, 'Nataša', 'Andonova', 'Andonova', '1993-12-04', 12, 10, NULL, '0000'),
(440, 'Andreea María', 'Paraluta', 'Paraluta', '1994-11-27', 11, 1, NULL, '0000'),
(441, 'Wendie', 'Thérèse Renard', 'Renard', '1990-07-20', 4, 3, NULL, '0000'),
(442, 'Ellie', 'Madison Carpenter', 'Carpenter', '2000-04-28', 39, 3, NULL, '0000'),
(443, 'Kadeisha', 'Buchanan', 'Buchanan', '1995-11-05', 23, 3, NULL, '0000'),
(444, 'Amandine ', 'Chantal Henry', 'Henry', '1989-09-28', 4, 5, NULL, '0000'),
(445, 'Eugénie Anne', 'Claudine Le Sommer', 'Le Sommer', '1989-05-18', 4, 10, NULL, '0000'),
(446, 'Catarina Cantanhede ', 'Melônio Macário', 'Macário', '1999-10-04', 18, 5, NULL, '0000'),
(447, 'Delphine', 'Cascarino', 'Cascarino', '1997-02-05', 4, 10, NULL, '0000'),
(448, 'Selma', 'Bacha', 'Bacha', '2000-11-09', 4, 4, NULL, '0000'),
(449, 'Daniëlle', 'van de Donk', 'van de Donk', '1991-08-05', 7, 5, 'media/NL/jugadoras/van de donk.png', '0000'),
(450, 'Kadidiatou', 'Diani', 'Diani', '1995-04-01', 4, 10, NULL, '0000'),
(451, 'Alexandra', 'Popp', 'Popp', '1991-04-06', 15, 10, NULL, '0000'),
(452, 'Lena', 'Sophie Oberdorf', 'Oberdorf', '2001-12-19', 15, 5, NULL, '0000'),
(453, 'Danique ', 'Tolhoek', 'Tolhoek', '2005-03-17', 7, 10, 'media/NL/jugadoras/tolhoek.png', NULL),
(454, 'Sveindís', 'Jane Jónsdóttir', 'Jónsdóttir', '2001-06-05', 47, 10, NULL, '0000'),
(455, 'Zećira', 'Musovic', 'Musovic', '1996-05-26', 16, 1, NULL, '0000'),
(456, 'Hannah', 'Alice Hampton', 'Hampton', '2000-11-16', 2, 1, NULL, '0000'),
(457, 'Ashley', 'Elizabeth Lawrence', 'Lawrence', '1995-06-11', 23, 5, NULL, '0000'),
(458, 'Lucía Roberta', 'Tough Bronze', 'Bronze', '1991-11-28', 2, 2, NULL, '0000'),
(459, 'Sandy', 'Madeleine Baltimore', 'Baltimore', '2000-02-19', 4, 10, NULL, '0000'),
(460, 'Keira', 'Fae Walsh', 'Walsh', '1997-04-08', 2, 5, NULL, '0000'),
(461, 'Mayra Tatiana', 'Ramírez Ramírez', 'Mayra', '1999-03-25', 26, 10, NULL, '0000'),
(462, 'Lauren', 'James', 'James', '2001-09-29', 2, 10, NULL, '0000'),
(463, 'Pernille', 'Mosegaard Harder', 'Harder', '1992-11-15', 17, 10, NULL, '0000'),
(464, 'Samantha', 'May Kerr', 'Kerr', '1993-11-10', 39, 10, NULL, '0000'),
(465, 'Viola', 'Mónica Calligaris', 'Calligaris', '1996-03-17', 8, 5, NULL, '0000'),
(466, 'Anna Margaretha Marina', 'Astrid Miedema', 'Miedema', '1996-07-15', 7, 10, NULL, '0000'),
(467, 'Lauren', 'May Hemp', 'Hemp', '2000-08-07', 2, 10, NULL, '0000'),
(468, 'Pauline', 'Peyraud-Magnin', 'Pauline', '1992-03-17', 4, 1, NULL, '0000'),
(469, 'Elena', 'Linari', 'Linari', '1994-04-15', 6, 3, NULL, '0000'),
(470, 'Alexandra', 'Morgan Carrasco', 'Morgan', '1989-07-02', 18, 5, NULL, '0000'),
(471, 'Christine', 'Margaret Sinclair ', 'Sinclair ', '1983-07-12', 23, 10, NULL, '0000'),
(472, 'Kosovare', 'Asllani', 'Asllani', '1989-07-29', 16, 10, NULL, '0000'),
(473, 'Sofia', 'Jakobsson', 'Jakobsson', '1990-04-23', 16, 10, NULL, '0000'),
(474, 'Regina', 'van Eijk', 'van Eijk', '2002-03-09', 7, 1, 'media/NL/jugadoras/van-eijk.png', NULL),
(475, 'Bo', 'van Egmond', 'van Egmond', '2006-11-13', 7, 11, 'media/NL/jugadoras/van-egmond.png', NULL),
(476, 'Ranneke', 'Derks', 'Derks', '2008-04-29', 7, 10, 'media/NL/jugadoras/derks.png', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ligas`
--

CREATE TABLE `ligas` (
  `id_liga` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `logo` text DEFAULT NULL,
  `pais` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ligas`
--

INSERT INTO `ligas` (`id_liga`, `nombre`, `logo`, `pais`) VALUES
(1, 'Liga F', 'media/ES/ligas/liga f.png', 1),
(2, 'NWSL', 'media/US/ligas/eeuu1.png', 18),
(3, 'GPFB', 'media/DE/ligas/ger1.png', 15),
(4, 'Première League', 'media/FR/ligas/fra1.png', 4),
(5, 'FA WSL', 'media/ENG/ligas/eng1.png', 2),
(6, 'Vrouwen Eredivisie', 'media/NL/ligas/Vrouwen_Eredivisie.png', 7),
(7, 'Primera Federación', 'media/ES/ligas/esp2.png', 1),
(8, 'Damallsvenskan', 'media/SE/ligas/damalls.png', 16),
(9, 'BeNe', 'media/NL/ligas/old/BeNe.png', 7),
(10, 'Toppserien', 'media/NO/ligas/toppserien-logo.png', 3),
(11, 'Ekstraliga', 'media/PL/ligas/Ekstraliga.png', 14),
(12, 'Liga BPI', 'media/PT/ligas/Liga_BPI.png', 41),
(13, 'Brasileirao Femenino', '', 27),
(14, 'Liga Femenina BetPlay Dimayor', 'media/CO/ligas/Liga_Femenina_Betplay_Dimayor_Colombia.png', 26),
(15, 'Retiradas', '', 50),
(16, 'Equipos Disueltos', '', 50),
(17, 'Serie A Femminile', 'media/IT/ligas/it1.png', 6),
(18, '2. Bundesliga Femenina', 'media/DE/ligas/ger2.png', 15),
(19, 'Liga MX Femenil', '', 21),
(20, 'Liga Femenina', '', 25),
(21, 'Segunda Federación', '', 1),
(22, 'Tercera Federación', '', 1),
(23, 'FA WSL2', 'media/ENG/ligas/eng2.png', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `iso` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id_pais`, `nombre`, `iso`) VALUES
(1, 'España', 'es'),
(2, 'Inglaterra', 'gb-eng'),
(3, 'Noruega', 'no'),
(4, 'Francia', 'fr'),
(5, 'Ucrania', 'ua'),
(6, 'Italia', 'it'),
(7, 'Paises Bajos', 'nl'),
(8, 'Suiza', 'ch'),
(9, 'Serbia', 'rs'),
(10, 'Georgia', 'ge'),
(11, 'Rumania', 'ro'),
(12, 'Macedonia', 'mk'),
(13, 'Montenegro', 'me'),
(14, 'Polonia', 'pl'),
(15, 'Alemania', 'de'),
(16, 'Suecia', 'se'),
(17, 'Dinamarca', 'dk'),
(18, 'Estados Unidos', 'us'),
(19, 'Paraguay', 'py'),
(20, 'Uruguay', 'uy'),
(21, 'Mexico', 'mx'),
(22, 'Venezuela', 've'),
(23, 'Canada', 'ca'),
(24, 'Guatemala', 'gt'),
(25, 'Chile', 'cl'),
(26, 'Colombia', 'co'),
(27, 'Brasil', 'br'),
(28, 'Argentina', 'ar'),
(29, 'Costa Rica', 'cr'),
(30, 'Marruecos', 'ma'),
(31, 'Zambia', 'zm'),
(32, 'Camerun', 'cm'),
(33, 'Costa de Marfil', 'ci'),
(34, 'Ghana', 'gh'),
(35, 'Namibia', 'na'),
(36, 'Nigeria', 'ng'),
(37, 'Corea del Sur', 'kr'),
(38, 'Japon', 'jp'),
(39, 'Australia', 'au'),
(40, 'Russia', 'ru'),
(41, 'Portugal', 'pt'),
(42, 'Jamaica', 'jm'),
(43, 'Escocia', 'gb-sct'),
(44, 'Eslovaquia', 'sk'),
(45, 'República Checa', 'cz'),
(46, 'Austria', 'at'),
(47, 'Islandia', 'is'),
(48, 'Bélgica', 'be'),
(49, 'Finlandia', 'fi'),
(50, 'Mundo', ''),
(51, 'Ecuador', 'ec');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pistas`
--

CREATE TABLE `pistas` (
  `id_juego` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `valor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pistas`
--

INSERT INTO `pistas` (`id_juego`, `descripcion`, `valor`) VALUES
(1, 'Guess Trayectoria', '{\"idJugadora\": \"25\"}'),
(2, 'Wordle', '{\"idJugadora\": \"1\"}'),
(3, 'Adivina Jugadora', '{\"idJugadora\": \"30\"}'),
(4, 'Grid', '{\"pais1\":\"7\",\"pais2\":\"10\",\"pais3\":\"3\",\"club1\":\"8\",\"club2\":\"1\",\"club3\":\"6\"}'),
(5, 'Compañeras', '{\"idJugadora\":\"1\"}'),
(6, 'FutFemBingo', '{\"paises\": [1, 2, 7], \"equipos\": [3, 1, 2], \"ligas\": [1,2,3], \"trofeos\": [1]}\r\n'),
(7, 'Futfem Clubs', '{\"equipo\": \"1\", \"temporada\": \"2021\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posiciones`
--

CREATE TABLE `posiciones` (
  `idPosicion` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `abreviatura` text NOT NULL,
  `idPosicionPadre` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `posiciones`
--

INSERT INTO `posiciones` (`idPosicion`, `nombre`, `abreviatura`, `idPosicionPadre`) VALUES
(1, 'Portera', 'POR', NULL),
(2, 'Lateral Derecha', 'LD', 3),
(3, 'Defensa', 'DFC', NULL),
(4, 'Lateral Izquierda', 'LI', 3),
(5, 'Mediocentro', 'MC', NULL),
(6, 'Mediocentro Defensivo', 'MCD', 5),
(7, 'Mediocentro ofensivo', 'MCO', 5),
(8, 'Mediocentro Izquierda', 'MI', 5),
(9, 'Mediocentro Derecha', 'MD', 5),
(10, 'Delantera', 'DC', NULL),
(11, 'Extremo Izquierda', 'EI', 10),
(12, 'Extremo Derecha', 'ED', 10),
(13, 'Sin determinar', 'TBD', 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rachas`
--

CREATE TABLE `rachas` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `juego` int(11) NOT NULL,
  `racha_actual` int(11) NOT NULL,
  `mejor_racha` int(11) NOT NULL,
  `ultima_respuesta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rachas`
--

INSERT INTO `rachas` (`id`, `usuario`, `juego`, `racha_actual`, `mejor_racha`, `ultima_respuesta`) VALUES
(1, 8, 1, 2, 0, '1'),
(2, 8, 2, 4, 0, '[{\"guess\":[\"e\",\"m\",\"a\",\"d\",\"h\"],\"result\":[\"present\",\"absent\",\"absent\",\"absent\",\"absent\"]},{\"guess\":[\"e\",\"l\",\"l\",\"i\",\"e\"],\"result\":[\"present\",\"present\",\"absent\",\"present\",\"correct\"]},{\"guess\":[\"l\",\"i\",\"e\",\"k\",\"e\"],\"result\":[\"correct\",\"correct\",\"correct\",\"correct\",\"correct\"],\"answer\":\"1\"}]'),
(3, 8, 3, 4, 0, '25'),
(4, 8, 4, 0, 0, '[{\"celda\":\"c11\",\"foto\":\"media/NL/jugadoras/likitaaa.png\"},{\"celda\":\"c31\",\"foto\":\"media/ES/jugadoras/paredes.png\"},{\"celda\":\"c12\",\"foto\":\"media/SE/jugadoras/frido.png\"},{\"answer\":\"loss5103816\"}]'),
(5, 8, 5, 6, 0, '1'),
(6, 8, 6, 0, 0, '[{\"celda\":\"c21\",\"foto\":\"media/ES/jugadoras/ortega.png\"},{\"celda\":\"c13\",\"foto\":\"media/ES/jugadoras/fiamma.png\"},{\"celda\":\"c14\",\"foto\":\"media/ES/jugadoras/daniela.png\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `Nombre` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `Nombre`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trayectoria`
--

CREATE TABLE `trayectoria` (
  `id` int(11) NOT NULL,
  `jugadora` int(11) NOT NULL,
  `equipo` int(11) NOT NULL,
  `años` text NOT NULL,
  `imagen` text DEFAULT NULL,
  `equipo_actual` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trayectoria`
--

INSERT INTO `trayectoria` (`id`, `jugadora`, `equipo`, `años`, `imagen`, `equipo_actual`) VALUES
(1, 1, 1, '2017-2022', 'media/ES/trayectorias/lieke-barsa.jpg', 0),
(2, 2, 21, '2016-2024', NULL, 0),
(3, 3, 12, '2019-2020', NULL, 0),
(4, 5, 3, '2016-2021', NULL, 0),
(5, 5, 10, '2011-2016', NULL, 0),
(6, 5, 8, '2008-2011', NULL, 0),
(7, 6, 26, '2004-2013', NULL, 0),
(8, 7, 6, '2014-2017', NULL, 0),
(9, 7, 26, '2013-2014', NULL, 0),
(10, 8, 22, '2020-2023', NULL, 0),
(11, 8, 2, '2018-2020', NULL, 0),
(12, 8, 9, '2017-2018', NULL, 0),
(13, 11, 2, '2011-2012', NULL, 0),
(14, 11, 26, '2010-2011', NULL, 0),
(15, 14, 5, '2019-2021', NULL, 0),
(16, 15, 21, '2014-2022', NULL, 0),
(17, 17, 5, '2015-2024', NULL, 0),
(18, 19, 5, '2019-2021', NULL, 0),
(19, 19, 14, '2017-2019', NULL, 0),
(20, 18, 5, '2014-2019', NULL, 0),
(21, 20, 12, '2020-2021', NULL, 0),
(22, 21, 27, '2019-2022', NULL, 0),
(23, 23, 28, '2019-2021', NULL, 0),
(24, 24, 24, '2020-2023', NULL, 0),
(25, 1, 29, '2016-2017', NULL, 0),
(26, 1, 30, '2014-2015', NULL, 0),
(27, 1, 31, '2013-2014', NULL, 0),
(28, 1, 32, '2011-2012', NULL, 0),
(29, 1, 33, '2010-2011', NULL, 0),
(30, 1, 34, '2009-2010', NULL, 0),
(31, 3, 35, '2016-2019', NULL, 0),
(32, 1, 3, '2022-2025', 'media\\ES\\trayectorias\\lieke-psg.jpg', 0),
(33, 2, 1, '2024-2025', NULL, 0),
(34, 3, 1, '2020-act', NULL, 1),
(35, 4, 1, '2016-act', NULL, 1),
(36, 5, 1, '2021-act', NULL, 1),
(37, 6, 1, '2013-act', NULL, 1),
(38, 7, 1, '2017-act', NULL, 1),
(39, 8, 1, '2023-act', NULL, 1),
(40, 4, 36, '2016-2021', NULL, 0),
(41, 8, 36, '2014-2016', NULL, 0),
(42, 9, 1, '2021-2025', NULL, 0),
(43, 9, 36, '2018-2021', NULL, 0),
(44, 10, 1, '2024-2025', NULL, 0),
(45, 10, 36, '2020-2024', NULL, 0),
(46, 11, 1, '2012-act', NULL, 1),
(47, 12, 1, '2015-act', NULL, 1),
(48, 12, 35, '2014-2015', NULL, 0),
(49, 13, 1, '2016-act', NULL, 1),
(50, 13, 36, '2013-2016', NULL, 0),
(51, 14, 37, '2018-2019', NULL, 0),
(52, 14, 1, '2021-act', NULL, 1),
(53, 14, 38, '2014-2018', NULL, 0),
(54, 15, 1, '2022-2024', NULL, 0),
(55, 16, 1, '2024-act', NULL, 1),
(56, 16, 36, '2022-2024', NULL, 0),
(57, 16, 9, '2021-2022', NULL, 0),
(58, 17, 1, '2024-act', NULL, 1),
(59, 17, 39, '2011-2015', NULL, 0),
(60, 18, 1, '2019-act', NULL, 1),
(61, 18, 40, '2013-2014', NULL, 0),
(62, 18, 41, '2010-2013', NULL, 0),
(63, 19, 1, '2021-2025', NULL, 0),
(64, 19, 42, '2014-2016', NULL, 0),
(65, 19, 43, '2011-2014', NULL, 0),
(66, 20, 1, '2021-act', NULL, 1),
(67, 20, 36, '2017-2020', NULL, 0),
(68, 21, 1, '2022-act', NULL, 1),
(69, 21, 44, '2017-2019', NULL, 0),
(70, 22, 1, '2024-act', NULL, 1),
(71, 22, 45, '2018-2024', NULL, 0),
(72, 23, 2, '2021-act', NULL, 1),
(73, 24, 1, '2023-act', NULL, 1),
(74, 25, 2, '2023-2025', NULL, 0),
(75, 25, 4, '2021-2023', NULL, 0),
(76, 25, 46, '2021', NULL, 0),
(77, 25, 47, '2020', NULL, 0),
(78, 25, 42, '2019', NULL, 0),
(79, 25, 48, '2017-2018', NULL, 0),
(80, 25, 49, '2014-2016', NULL, 0),
(81, 25, 50, '2013-2014', NULL, 0),
(82, 25, 51, '2012', NULL, 0),
(83, 26, 2, '2020-act', NULL, 1),
(84, 26, 11, '2015-2020', NULL, 0),
(85, 27, 2, '2012-act', NULL, 1),
(86, 27, 52, '2010-2012', NULL, 0),
(87, 27, 53, '2009-2010', NULL, 0),
(88, 28, 2, '2024-2025', NULL, 0),
(89, 28, 11, '2022-2024', NULL, 0),
(90, 28, 36, '2020-2022', NULL, 0),
(91, 28, 26, '2019-2020', NULL, 0),
(92, 29, 2, '2024-act', NULL, 1),
(93, 29, 12, '2020-2024', NULL, 0),
(94, 29, 54, '2019-2020', NULL, 0),
(95, 30, 2, '2020-2025', NULL, 0),
(96, 30, 11, '2019-2020', NULL, 0),
(97, 31, 2, '2024-act', NULL, 1),
(98, 31, 52, '2022-2024', NULL, 0),
(99, 32, 2, '2021-act', NULL, 1),
(100, 33, 2, '2020-act', NULL, 1),
(101, 34, 2, '2023-2025', NULL, 0),
(102, 34, 13, '2020-2023', NULL, 0),
(103, 34, 6, '2014-2020', NULL, 0),
(104, 34, 52, '2013-2014', NULL, 0),
(105, 34, 12, '2009-2013', NULL, 0),
(106, 35, 2, '2024-2025', NULL, 0),
(107, 35, 55, '2023-2024', NULL, 0),
(108, 35, 56, '2022-2023', NULL, 0),
(109, 35, 57, '2021-2022', NULL, 0),
(110, 35, 56, '2020-2021', NULL, 0),
(111, 35, 57, '2019-2020', NULL, 0),
(112, 35, 17, '2017-2018', NULL, 0),
(113, 35, 58, '2017', NULL, 0),
(114, 35, 3, '2015-2019', NULL, 0),
(115, 36, 2, '2022-2025', NULL, 0),
(116, 36, 59, '2019-2022', NULL, 0),
(117, 36, 60, '2017-2019', NULL, 0),
(118, 36, 36, '2013-2017', NULL, 0),
(119, 37, 2, '2023-2025', NULL, 0),
(120, 37, 11, '2020-2023', NULL, 0),
(121, 37, 26, '2018-2020', NULL, 0),
(122, 37, 36, '2014-2018', NULL, 0),
(123, 38, 2, '2019-act', NULL, 1),
(124, 39, 2, '2024-act', NULL, 1),
(125, 39, 61, '2020-2024', NULL, 0),
(126, 39, 59, '2014-2020', NULL, 0),
(127, 40, 2, '2023-2025', NULL, 0),
(128, 40, 62, '2021-2023', NULL, 0),
(129, 40, 63, '2016-2021', NULL, 0),
(130, 41, 2, '2023-2024', NULL, 0),
(131, 41, 9, '2021-2023', NULL, 0),
(132, 41, 64, '2016-2021', NULL, 0),
(133, 42, 2, '2024-act', NULL, 1),
(134, 42, 12, '2017-2024', NULL, 0),
(135, 42, 65, '2014-2017', NULL, 0),
(136, 43, 2, '2024-2025', NULL, 0),
(137, 43, 11, '2022-2024', NULL, 0),
(138, 43, 66, '2021-2022', NULL, 0),
(139, 43, 67, '2020-2021', NULL, 0),
(140, 43, 68, '2019-2020', NULL, 0),
(141, 43, 69, '2018-2019', NULL, 0),
(142, 44, 70, '2008-2010', NULL, 0),
(143, 44, 25, '2010-2015', NULL, 0),
(144, 44, 18, '2015-2019', NULL, 0),
(145, 44, 6, '2019-2020', NULL, 0),
(146, 44, 24, '2020-2022', NULL, 0),
(147, 45, 71, '2022-2024', NULL, 0),
(148, 45, 72, '2021-2022', NULL, 0),
(149, 45, 73, '2020', NULL, 0),
(150, 45, 72, '2017-2020', NULL, 0),
(151, 45, 4, '2016-2017', NULL, 0),
(152, 45, 72, '2016', NULL, 0),
(153, 45, 74, '2013-2015', NULL, 0),
(154, 45, 75, '2012', NULL, 0),
(155, 45, 76, '2011', NULL, 0),
(156, 45, 77, '2010', NULL, 0),
(157, 46, 6, '2021-act', NULL, 1),
(158, 47, 6, '2023-act', NULL, 1),
(159, 48, 6, '2022-act', NULL, 1),
(160, 49, 6, '2016-act', NULL, 1),
(161, 50, 6, '2024-act', NULL, 1),
(162, 51, 6, '2024-act', NULL, 1),
(163, 52, 6, '2024-act', NULL, 1),
(164, 53, 6, '2022-act', NULL, 1),
(165, 54, 6, '2022-act', NULL, 1),
(166, 55, 6, '2024-act', NULL, 1),
(167, 56, 6, '2022-act', NULL, 1),
(168, 57, 6, '2023-2025', NULL, 0),
(169, 58, 6, '2024-act', NULL, 1),
(170, 59, 6, '2023-act', NULL, 1),
(171, 60, 6, '2024-act', NULL, 1),
(172, 61, 6, '2022-act', NULL, 1),
(173, 62, 6, '2023-act', NULL, 1),
(174, 63, 6, '2024-act', NULL, 1),
(175, 64, 6, '2021-act', NULL, 1),
(176, 65, 6, '2024-act', NULL, 1),
(177, 66, 6, '2024-act', NULL, 1),
(178, 67, 55, '2022-2023', NULL, 0),
(179, 68, 11, '2025-act', NULL, 1),
(180, 69, 11, '2025-act', NULL, 1),
(181, 70, 11, '2025-act', NULL, 1),
(182, 71, 11, '2025-act', NULL, 1),
(183, 72, 11, '2025-act', NULL, 1),
(184, 73, 11, '2025-act', NULL, 1),
(185, 74, 11, '2024-2025', NULL, 0),
(186, 75, 11, '2025-act', NULL, 1),
(187, 76, 11, '2024-2025', NULL, 0),
(188, 77, 11, '2025-act', NULL, 1),
(189, 78, 11, '2025-act', NULL, 1),
(190, 79, 11, '2025-act', NULL, 1),
(191, 80, 11, '2025-act', NULL, 1),
(192, 81, 11, '2025-act', NULL, 1),
(193, 82, 11, '2025-act', NULL, 1),
(194, 83, 11, '2025-act', NULL, 1),
(195, 84, 11, '2025-act', NULL, 1),
(196, 85, 11, '2025-act', NULL, 1),
(197, 86, 11, '2025-act', NULL, 1),
(198, 87, 11, '2025-act', NULL, 1),
(199, 88, 11, '2025-act', NULL, 1),
(200, 89, 11, '2025-act', NULL, 1),
(201, 90, 11, '2025-act', NULL, 1),
(202, 91, 10, '2025-act', NULL, 1),
(203, 92, 10, '2023-act', NULL, 1),
(204, 93, 10, '2025-act', NULL, 1),
(205, 94, 10, '2025-act', NULL, 1),
(206, 95, 10, '2025-act', NULL, 1),
(207, 96, 10, '2025-act', NULL, 1),
(208, 97, 10, '2025-act', NULL, 1),
(209, 98, 10, '2025-act', NULL, 1),
(210, 99, 10, '2025-act', NULL, 1),
(211, 100, 10, '2025-act', NULL, 1),
(212, 101, 10, '2021-act', NULL, 1),
(213, 102, 10, '2025-act', NULL, 1),
(214, 103, 10, '2021-2025', NULL, 0),
(215, 104, 10, '2025-act', NULL, 1),
(216, 105, 10, '2025-act', NULL, 1),
(217, 106, 10, '2025-act', NULL, 1),
(218, 107, 10, '2025-act', NULL, 1),
(219, 108, 10, '2025-act', NULL, 1),
(220, 109, 10, '2025-act', NULL, 1),
(221, 110, 10, '2025-act', NULL, 1),
(222, 111, 10, '2025-act', NULL, 1),
(223, 112, 10, '2025-act', NULL, 1),
(224, 113, 10, '2025-act', NULL, 1),
(225, 114, 10, '2025-act', NULL, 1),
(226, 115, 26, '2024-2025', NULL, 1),
(227, 116, 26, '2024-2025', NULL, 1),
(228, 117, 26, '2024-2025', NULL, 1),
(229, 118, 26, '2024-2025', NULL, 1),
(230, 119, 26, '2024-2025', NULL, 1),
(231, 120, 26, '2024-2025', NULL, 1),
(232, 121, 26, '2024-2025', NULL, 1),
(233, 122, 26, '2024-2025', NULL, 1),
(234, 123, 26, '2024-2025', NULL, 1),
(235, 124, 26, '2024-2025', NULL, 1),
(236, 125, 26, '2024-2025', NULL, 1),
(237, 126, 26, '2024-2025', NULL, 1),
(238, 127, 26, '2024-2025', NULL, 1),
(239, 128, 26, '2024-2025', NULL, 0),
(240, 129, 26, '2024-2025', NULL, 1),
(241, 130, 26, '2024-2025', NULL, 1),
(242, 131, 26, '2024-2025', NULL, 1),
(243, 132, 26, '2024-2025', NULL, 1),
(244, 133, 26, '2024-2025', NULL, 1),
(245, 134, 26, '2024-2025', NULL, 1),
(246, 135, 26, '2024-2025', NULL, 1),
(247, 136, 26, '2024-2025', NULL, 1),
(248, 137, 7, '2025-act', NULL, 1),
(249, 138, 7, '2025-act', NULL, 1),
(250, 139, 7, '2025-act', NULL, 1),
(251, 140, 7, '2025-act', NULL, 1),
(252, 141, 7, '2025-act', NULL, 1),
(253, 142, 7, '2025-act', NULL, 1),
(254, 143, 7, '2025-act', NULL, 1),
(255, 144, 7, '2025-act', NULL, 1),
(256, 145, 7, '2025-act', NULL, 1),
(257, 146, 7, '2025-act', NULL, 1),
(258, 147, 7, '2025-act', NULL, 1),
(259, 148, 7, '2025-act', NULL, 1),
(260, 149, 7, '2025-act', NULL, 1),
(261, 150, 7, '2025-act', NULL, 1),
(262, 151, 7, '2025-act', NULL, 1),
(263, 152, 7, '2025-act', NULL, 1),
(264, 153, 7, '2025-act', NULL, 1),
(265, 154, 7, '2025-act', NULL, 1),
(266, 155, 7, '2025-act', NULL, 1),
(267, 156, 7, '2025-act', NULL, 1),
(268, 157, 7, '2025-act', NULL, 1),
(269, 158, 7, '2025-act', NULL, 1),
(270, 159, 7, '2025-act', NULL, 1),
(271, 160, 12, '2025-act', NULL, 1),
(272, 161, 12, '2025-act', NULL, 1),
(273, 162, 12, '2025-act', NULL, 1),
(274, 163, 12, '2025-act', NULL, 1),
(275, 164, 12, '2025-act', NULL, 1),
(276, 165, 12, '2025-act', NULL, 1),
(277, 166, 12, '2025-act', NULL, 1),
(278, 167, 12, '2025-act', NULL, 1),
(279, 168, 12, '2025-act', NULL, 1),
(280, 169, 12, '2025-act', NULL, 1),
(281, 170, 12, '2025-act', NULL, 1),
(282, 171, 12, '2025-act', NULL, 1),
(283, 172, 12, '2025-act', NULL, 1),
(284, 173, 12, '2025-act', NULL, 1),
(285, 174, 12, '2025-act', NULL, 1),
(286, 175, 12, '2025-act', NULL, 1),
(287, 176, 12, '2025-act', NULL, 1),
(288, 177, 12, '2025-act', NULL, 1),
(289, 178, 12, '2025-act', NULL, 1),
(290, 179, 12, '2025-act', NULL, 1),
(291, 180, 12, '2025-act', NULL, 1),
(292, 182, 78, '2025-act', NULL, 1),
(293, 183, 78, '2025-act', NULL, 1),
(294, 184, 78, '2025-act', NULL, 1),
(295, 185, 78, '2025-act', NULL, 1),
(296, 186, 78, '2025-act', NULL, 1),
(297, 187, 78, '2025-act', NULL, 1),
(298, 188, 78, '2025-act', NULL, 1),
(299, 189, 78, '2025-act', NULL, 1),
(300, 190, 78, '2025-act', NULL, 1),
(301, 191, 78, '2025-act', NULL, 1),
(302, 192, 78, '2025-act', NULL, 1),
(303, 193, 78, '2025-act', NULL, 1),
(304, 194, 78, '2025-act', NULL, 1),
(305, 195, 78, '2025-act', NULL, 1),
(306, 196, 78, '2025-act', NULL, 1),
(307, 197, 78, '2025-act', NULL, 1),
(308, 198, 78, '2025-act', NULL, 1),
(309, 199, 78, '2025-act', NULL, 1),
(310, 200, 78, '2025-act', NULL, 1),
(311, 201, 78, '2025-act', NULL, 1),
(312, 202, 13, '2025-act', NULL, 1),
(313, 203, 13, '2025-act', NULL, 1),
(314, 204, 13, '2025-act', NULL, 1),
(315, 205, 13, '2025-act', NULL, 1),
(316, 206, 13, '2025-act', NULL, 1),
(317, 207, 13, '2025-act', NULL, 1),
(318, 208, 13, '2025-act', NULL, 1),
(319, 209, 13, '2025-act', NULL, 1),
(320, 210, 13, '2025-act', NULL, 1),
(321, 211, 13, '2025-act', NULL, 1),
(322, 212, 13, '2025-act', NULL, 1),
(323, 213, 13, '2025-act', NULL, 1),
(324, 214, 13, '2025-act', NULL, 1),
(325, 215, 13, '2025-act', NULL, 1),
(326, 216, 13, '2025-act', NULL, 1),
(327, 217, 13, '2025-act', NULL, 1),
(328, 218, 13, '2023-2025', NULL, 0),
(329, 219, 13, '2025-act', NULL, 1),
(330, 220, 13, '2025-act', NULL, 1),
(331, 221, 13, '2025-act', NULL, 1),
(332, 222, 13, '2025-act', NULL, 1),
(333, 223, 13, '2025-act', NULL, 1),
(334, 224, 13, '2025-act', NULL, 1),
(335, 225, 8, '2023-', NULL, 1),
(336, 226, 8, '2023-', NULL, 1),
(337, 227, 8, '2023-', NULL, 1),
(338, 228, 8, '2023-', NULL, 1),
(339, 229, 8, '2023-', NULL, 1),
(340, 230, 8, '2023-', NULL, 1),
(341, 231, 8, '2023-', NULL, 1),
(342, 232, 8, '2023-', NULL, 1),
(343, 233, 8, '2023-', NULL, 1),
(344, 234, 8, '2023-', NULL, 1),
(345, 235, 8, '2023-', NULL, 1),
(346, 236, 8, '2023-', NULL, 1),
(347, 237, 8, '2023-', NULL, 1),
(348, 238, 8, '2023-', NULL, 1),
(349, 239, 8, '2023-', NULL, 1),
(350, 240, 8, '2023-', NULL, 1),
(351, 241, 8, '2023-', NULL, 1),
(352, 242, 8, '2023-', NULL, 1),
(353, 243, 8, '2023-', NULL, 1),
(354, 244, 8, '2023-', NULL, 1),
(355, 245, 8, '2023-', NULL, 1),
(356, 246, 8, '2023-', NULL, 1),
(357, 247, 8, '2023-', NULL, 1),
(358, 248, 79, '2023-', NULL, 1),
(359, 249, 79, '2023-', NULL, 1),
(360, 250, 79, '2023-', NULL, 1),
(361, 251, 79, '2023-', NULL, 1),
(362, 252, 79, '2023-', NULL, 1),
(363, 253, 79, '2023-', NULL, 1),
(364, 254, 79, '2023-', NULL, 1),
(365, 255, 79, '2023-', NULL, 1),
(366, 256, 79, '2023-', NULL, 1),
(367, 257, 79, '2023-', NULL, 1),
(368, 258, 79, '2023-', NULL, 1),
(369, 259, 79, '2023-', NULL, 1),
(370, 260, 79, '2023-', NULL, 1),
(371, 261, 79, '2023-', NULL, 1),
(372, 262, 79, '2023-', NULL, 1),
(373, 263, 79, '2023-', NULL, 1),
(374, 264, 79, '2023-', NULL, 1),
(375, 265, 79, '2023-', NULL, 1),
(376, 266, 79, '2023-', NULL, 1),
(377, 267, 79, '2023-', NULL, 1),
(378, 268, 79, '2023-', NULL, 1),
(379, 269, 79, '2023-', NULL, 1),
(380, 270, 79, '2023-', NULL, 1),
(381, 290, 80, '2023-', NULL, 1),
(382, 291, 80, '2023-', NULL, 1),
(383, 292, 80, '2023-', NULL, 1),
(384, 293, 80, '2023-', NULL, 1),
(385, 294, 80, '2023-', NULL, 1),
(386, 295, 80, '2023-', NULL, 1),
(387, 296, 80, '2023-', NULL, 1),
(388, 297, 80, '2023-', NULL, 1),
(389, 298, 80, '2023-', NULL, 1),
(390, 299, 80, '2023-', NULL, 1),
(391, 300, 80, '2023-', NULL, 1),
(392, 301, 80, '2023-', NULL, 1),
(393, 302, 80, '2023-', NULL, 1),
(394, 303, 80, '2023-', NULL, 1),
(395, 304, 80, '2023-', NULL, 1),
(396, 305, 80, '2023-', NULL, 1),
(397, 306, 80, '2023-', NULL, 1),
(398, 307, 80, '2023-', NULL, 1),
(399, 308, 80, '2023-', NULL, 1),
(400, 309, 55, '2023-', NULL, 1),
(401, 310, 55, '2023-2025', NULL, 0),
(402, 311, 55, '2023-', NULL, 1),
(403, 312, 55, '2023-', NULL, 1),
(404, 313, 55, '2023-', NULL, 1),
(405, 314, 55, '2023-', NULL, 1),
(406, 315, 55, '2023-', NULL, 1),
(407, 316, 55, '2023-', NULL, 1),
(408, 317, 55, '2023-', NULL, 1),
(409, 318, 55, '2023-', NULL, 1),
(410, 319, 55, '2023-', NULL, 1),
(411, 320, 55, '2023-', NULL, 1),
(412, 321, 55, '2023-', NULL, 1),
(413, 322, 55, '2023-', NULL, 1),
(414, 323, 55, '2023-', NULL, 1),
(415, 324, 55, '2023-', NULL, 1),
(416, 325, 55, '2023-', NULL, 1),
(417, 326, 55, '2023-', NULL, 1),
(418, 327, 55, '2023-', NULL, 1),
(419, 328, 55, '2023-', NULL, 1),
(420, 329, 55, '2023-', NULL, 1),
(421, 330, 55, '2023-', NULL, 1),
(422, 331, 55, '2023-', NULL, 1),
(423, 332, 9, '2023-act', NULL, 1),
(424, 333, 9, '2023-act', NULL, 1),
(425, 334, 9, '2023-act', NULL, 1),
(426, 335, 9, '2023-act', NULL, 1),
(427, 336, 9, '2023-act', NULL, 1),
(428, 337, 9, '2023-act', NULL, 1),
(429, 338, 9, '2023-act', NULL, 1),
(430, 339, 9, '2023-act', NULL, 1),
(431, 340, 9, '2023-act', NULL, 1),
(432, 341, 9, '2023-act', NULL, 1),
(433, 342, 9, '2023-act', NULL, 1),
(434, 343, 9, '2023-act', NULL, 1),
(435, 344, 9, '2023-act', NULL, 1),
(436, 345, 9, '2023-act', NULL, 1),
(437, 346, 9, '2023-act', NULL, 1),
(438, 347, 9, '2023-act', NULL, 1),
(439, 348, 9, '2023-act', NULL, 1),
(440, 349, 9, '2023-act', NULL, 1),
(441, 350, 9, '2023-act', NULL, 1),
(442, 351, 9, '2023-act', NULL, 1),
(443, 352, 9, '2023-act', NULL, 1),
(444, 353, 9, '2023-act', NULL, 1),
(445, 354, 81, '2023-', NULL, 1),
(446, 355, 81, '2023-', NULL, 1),
(447, 356, 81, '2023-', NULL, 1),
(448, 357, 81, '2023-', NULL, 1),
(449, 358, 81, '2023-', NULL, 1),
(450, 359, 81, '2023-', NULL, 1),
(451, 360, 81, '2023-', NULL, 1),
(452, 361, 81, '2023-', NULL, 1),
(453, 362, 81, '2023-', NULL, 1),
(454, 363, 81, '2023-', NULL, 1),
(455, 364, 81, '2023-', NULL, 1),
(456, 365, 81, '2023-', NULL, 1),
(457, 366, 81, '2023-', NULL, 1),
(458, 367, 81, '2023-', NULL, 1),
(459, 368, 81, '2023-', NULL, 1),
(460, 369, 81, '2023-', NULL, 1),
(461, 370, 81, '2023-', NULL, 1),
(462, 371, 81, '2023-', NULL, 1),
(463, 372, 81, '2023-', NULL, 1),
(464, 373, 81, '2023-', NULL, 1),
(465, 374, 81, '2023-', NULL, 1),
(466, 375, 81, '2023-', NULL, 1),
(467, 376, 81, '2023-', NULL, 1),
(468, 377, 81, '2023-', NULL, 1),
(469, 378, 81, '2023-', NULL, 1),
(470, 379, 81, '2023-', NULL, 1),
(471, 380, 81, '2023-', NULL, 1),
(472, 381, 3, '2022-act', NULL, 1),
(473, 381, 22, '2019-2022', NULL, 0),
(474, 381, 82, '2015-2019', NULL, 0),
(475, 381, 20, '2014-2015', NULL, 0),
(476, 381, 31, '2011-2013', NULL, 0),
(477, 382, 23, '2023-2025', NULL, 0),
(478, 383, 21, '2023-2025', NULL, 0),
(479, 383, 5, '2021-2023', NULL, 0),
(480, 383, 18, '2019-2021', NULL, 0),
(481, 383, 14, '2017-2019', NULL, 0),
(482, 383, 25, '2013-2017', NULL, 0),
(483, 384, 18, '2024-act', NULL, 1),
(484, 384, 19, '2023-2024', NULL, 0),
(485, 384, 25, '2017-2023', NULL, 0),
(486, 271, 2, '2023-act', NULL, 1),
(487, 41, 19, '2024-act', NULL, 1),
(488, 45, 83, '2024', NULL, 1),
(489, 44, 83, '2022', NULL, 1),
(490, 67, 83, '2023', NULL, 1),
(491, 386, 1, '2006-2007', NULL, 0),
(492, 386, 1, '2006-2007', NULL, 0),
(493, 386, 26, '2007-2008', NULL, 0),
(494, 386, 1, '2008-2015', NULL, 0),
(495, 386, 76, '2014', NULL, 0),
(496, 386, 18, '2015-2016', NULL, 0),
(497, 386, 1, '2016-2021', NULL, 0),
(498, 386, 21, '2021-2023', NULL, 0),
(499, 386, 85, '2023', NULL, 0),
(500, 386, 90, '2023-act', NULL, 1),
(501, 389, 1, '2019-2024', NULL, 0),
(502, 389, 90, '2024-act', NULL, 1),
(503, 390, 86, '2022-2023', NULL, 0),
(504, 390, 1, '2022-2024', NULL, 0),
(505, 390, 85, '2024-act', NULL, 1),
(506, 272, 1, '2024-act', NULL, 1),
(518, 52, 2, '2020-2024', NULL, 0),
(519, 65, 9, '2018-2020', NULL, 0),
(520, 65, 36, '2020-2021', NULL, 0),
(521, 65, 2, '2021-2022', NULL, 0),
(522, 65, 18, '2022-2023', NULL, 0),
(523, 65, 91, '2022-2023', NULL, 0),
(524, 65, 18, '2023-2024', NULL, 0),
(525, 65, 9, '2023-2024', NULL, 0),
(526, 91, 8, '2014-2021', NULL, 0),
(527, 92, 8, '2019-2023', NULL, 0),
(528, 94, 82, '2016-2019', NULL, 0),
(529, 101, 8, '2011-2021', NULL, 0),
(530, 100, 1, '2006-2018', NULL, 0),
(531, 102, 8, '2013-2021', NULL, 0),
(532, 102, 2, '2021-2024', NULL, 0),
(533, 108, 8, '2014-2021', NULL, 0),
(534, 108, 7, '2021-2023', NULL, 0),
(535, 109, 78, '2017-2021', NULL, 0),
(536, 46, 12, '2008-2011', NULL, 0),
(537, 46, 52, '2011-2012', NULL, 0),
(538, 46, 6, '2012-2020', NULL, 0),
(539, 46, 4, '2020-2021', NULL, 0),
(540, 47, 59, '2019-2022', NULL, 0),
(541, 48, 8, '2012-2015', NULL, 0),
(542, 48, 10, '2015-2022', NULL, 0),
(543, 51, 9, '2022-2023', NULL, 0),
(544, 50, 13, '2019-2021', NULL, 0),
(545, 50, 12, '2021-2024', NULL, 0),
(546, 50, 6, '2016-2019', NULL, 0),
(547, 54, 13, '2019-2022', NULL, 0),
(548, 55, 2, '2021-2023', NULL, 0),
(549, 59, 78, '2016-2021', NULL, 0),
(550, 59, 8, '2021-2023', NULL, 0),
(551, 60, 2, '2019-2022', NULL, 0),
(552, 60, 11, '2022-2024', NULL, 0),
(553, 62, 27, '2017-2023', NULL, 0),
(554, 62, 2, '2011-2016', NULL, 0),
(555, 62, 60, '2016-2017', NULL, 0),
(556, 61, 44, '2010-2017', NULL, 0),
(557, 61, 2, '2017-2018', NULL, 0),
(558, 61, 8, '2018-2020', NULL, 0),
(559, 61, 7, '2020-2022', NULL, 0),
(560, 15, 20, '2024-act', NULL, 1),
(561, 138, 6, '2017-2019', NULL, 0),
(562, 138, 78, '2019-2020', NULL, 0),
(563, 142, 59, '2016-2021', NULL, 0),
(564, 142, 6, '2021-2024', NULL, 0),
(565, 144, 9, '2020-2022', NULL, 0),
(566, 144, 2, '2022-2024', NULL, 0),
(567, 140, 10, '2018-2023', NULL, 0),
(568, 145, 2, '2020-2024', NULL, 0),
(569, 145, 78, '2019-2020', NULL, 0),
(570, 139, 12, '2012-2013', NULL, 0),
(571, 139, 13, '2013-2014', NULL, 0),
(572, 139, 6, '2014-2017', NULL, 0),
(573, 139, 13, '2017-2019', NULL, 0),
(574, 139, 2, '2019-2021', NULL, 0),
(575, 387, 78, '2019-2020', NULL, 0),
(576, 387, 8, '2020-2022', NULL, 0),
(577, 387, 1, '2022-2023', NULL, 0),
(578, 387, 5, '2023-2025', NULL, 0),
(579, 67, 2, '2006-2008', NULL, 0),
(580, 67, 1, '2008-2011', NULL, 0),
(581, 67, 26, '2011-2013', NULL, 0),
(582, 67, 11, '2013-2020', NULL, 0),
(583, 67, 13, '2020-2022', NULL, 0),
(584, 391, 8, '2019-2024', NULL, 0),
(585, 392, 12, '2010-2013', NULL, 0),
(586, 392, 29, '2018', NULL, 0),
(587, 392, 4, '2020-2021', NULL, 0),
(588, 392, 72, '2021-act', NULL, 1),
(589, 393, 2, '2004-2010', NULL, 0),
(590, 393, 6, '2012-2012', NULL, 0),
(591, 393, 2, '2012-2019', NULL, 0),
(592, 394, 10, '2004-2010', NULL, 0),
(593, 394, 26, '2010-2011', NULL, 0),
(594, 394, 10, '2011-2022', NULL, 0),
(595, 395, 59, '2004-2011', NULL, 0),
(596, 395, 1, '2011-2014', NULL, 0),
(597, 395, 1, '2014-2015', NULL, 0),
(598, 395, 6, '2015-2018', NULL, 0),
(599, 395, 2, '2018-2020', NULL, 0),
(600, 396, 2, '2004-2013', NULL, 0),
(601, 396, 1, '2013-2018', NULL, 0),
(602, 396, 2, '2018-2020', NULL, 0),
(603, 397, 12, '2008-2013', NULL, 0),
(604, 397, 52, '2013-2017', NULL, 0),
(605, 397, 81, '2017-2022', NULL, 0),
(606, 397, 12, '2022-2024', NULL, 0),
(607, 397, 45, '2024-act', NULL, 1),
(608, 398, 36, '2005-2007', NULL, 0),
(609, 398, 1, '2007-2018', NULL, 0),
(610, 399, 12, '2005-2007', NULL, 0),
(611, 399, 59, '2007-2010', NULL, 0),
(612, 399, 26, '2010-2013', NULL, 0),
(613, 399, 1, '2013-2015', NULL, 0),
(614, 399, 11, '2015-2016', NULL, 0),
(615, 399, 23, '2016-2018', NULL, 0),
(616, 399, 13, '2018-2020', NULL, 0),
(617, 400, 36, '2008-2011', NULL, 0),
(618, 400, 55, '2011-2013', NULL, 0),
(619, 400, 11, '2014-2020', NULL, 0),
(620, 400, 26, '2020-2021', NULL, 0),
(621, 400, 12, '2021-2022', NULL, 0),
(622, 401, 10, '2016-2022', NULL, 0),
(623, 401, 22, '2022-2024', NULL, 0),
(624, 401, 107, '2024-act', NULL, 1),
(625, 402, 1, '2010-2013', NULL, 0),
(626, 402, 2, '2013-2015', NULL, 0),
(627, 402, 1, '2015-2018', NULL, 0),
(628, 402, 6, '2018-2020', NULL, 0),
(629, 402, 108, '2020-2024', NULL, 0),
(630, 403, 2, '2004-2016', NULL, 0),
(631, 404, 35, '2009-2011', NULL, 0),
(632, 404, 1, '2012-2015', NULL, 0),
(633, 404, 6, '2019-2023', NULL, 0),
(634, 404, 27, '2023-2024', NULL, 0),
(635, 405, 35, '2012-2015', NULL, 0),
(636, 405, 2, '2015-2020', NULL, 0),
(637, 405, 8, '2020-2021', NULL, 0),
(638, 405, 6, '2021-2023', NULL, 0),
(639, 405, 97, '2023-act', NULL, 1),
(640, 406, 2, '2016-2024', NULL, 0),
(641, 406, 19, '2024-act', NULL, 1),
(642, 407, 12, '2016-2024', NULL, 0),
(643, 407, 91, '2024-act', NULL, 1),
(644, 408, 10, '2016-2023', NULL, 0),
(645, 408, 85, '2023-act', NULL, 1),
(646, 409, 45, '2018-act', NULL, 1),
(647, 410, 11, '2009-2018', NULL, 0),
(648, 410, 2, '2018-2020', NULL, 0),
(649, 410, 7, '2020-2024', NULL, 0),
(650, 410, 86, '2024-act', NULL, 1),
(651, 411, 26, '2016-2019', NULL, 0),
(652, 411, 1, '2019-2024', NULL, 0),
(653, 411, 20, '2024-act', NULL, 1),
(654, 412, 7, '2020-2022', NULL, 0),
(655, 412, 1, '2022-2024', NULL, 0),
(656, 412, 5, '2024-act', NULL, 1),
(657, 413, 2, '2015-2019', NULL, 0),
(658, 413, 6, '2019-2021', NULL, 0),
(659, 413, 101, '2021-act', NULL, 1),
(660, 414, 6, '2004-2010', NULL, 0),
(661, 414, 59, '2010-2013', NULL, 0),
(662, 414, 40, '2013', NULL, 0),
(663, 414, 1, '2013-2017', NULL, 0),
(664, 414, 3, '2017-2018', NULL, 0),
(665, 414, 6, '2018-2019', NULL, 0),
(666, 414, 1, '2019-2022', NULL, 0),
(667, 414, 101, '2022-2023', NULL, 0),
(668, 415, 26, '2008-2010', NULL, 0),
(669, 415, 1, '2010-2015', NULL, 0),
(670, 415, 18, '2015-2016', NULL, 0),
(671, 415, 6, '2016-2018', NULL, 0),
(672, 415, 2, '2018-2020', NULL, 0),
(673, 415, 7, '2020-2023', NULL, 0),
(674, 416, 1, '2009-2013', NULL, 0),
(675, 416, 2, '2013-2020', NULL, 0),
(676, 417, 27, '2012-2014', NULL, 0),
(677, 417, 2, '2014-2022', NULL, 0),
(678, 417, 27, '2022-act', NULL, 1),
(679, 418, 1, '2012-2016', NULL, 0),
(680, 418, 6, '2016-2019', NULL, 0),
(681, 418, 1, '2019-2021', NULL, 0),
(682, 418, 2, '2021-2022', NULL, 0),
(683, 418, 96, '2022-2023', NULL, 0),
(684, 418, 45, '2023-act', NULL, 1),
(685, 436, 4, '2024-act', NULL, 1),
(686, 436, 7, '2022-2024', NULL, 0),
(687, 436, 5, '2020-2022', NULL, 0),
(688, 437, 4, '2020-act', NULL, 1),
(689, 437, 10, '2015-2020', NULL, 0),
(690, 437, 91, '2020-2021', NULL, 0),
(691, 451, 5, '2012-act', NULL, 1),
(692, 438, 94, '2010-2011', NULL, 0),
(693, 438, 41, '2012', NULL, 0),
(694, 438, 93, '2012-2014', NULL, 0),
(695, 438, 4, '2014-act', NULL, 1),
(696, 451, 95, '2008-2012', NULL, 0),
(697, 419, 2, '2010-2012', NULL, 0),
(698, 419, 1, '2015-2024', NULL, 0),
(699, 419, 96, '2024-act', NULL, 1),
(700, 426, 2, '2009-2011', NULL, 0),
(701, 426, 52, '2012-2013', NULL, 0),
(702, 426, 6, '2013-2019', NULL, 0),
(703, 426, 2, '2019-2021', NULL, 0),
(704, 426, 7, '2021-2023', NULL, 0),
(705, 426, 97, '2023-act', NULL, 1),
(706, 435, 20, '2014', NULL, 0),
(707, 435, 98, '2011-2012', NULL, 0),
(708, 435, 98, '2015-2016', NULL, 0),
(709, 435, 11, '2016-2017', NULL, 0),
(710, 435, 3, '2017-2021', NULL, 0),
(711, 435, 4, '2022-act', NULL, 1),
(712, 421, 26, '2008-2010', NULL, 0),
(713, 427, 59, '2010-2011', NULL, 0),
(714, 427, 6, '2011-2014', NULL, 0),
(715, 421, 26, '2010-2011', NULL, 0),
(716, 421, 40, '2012-2014', NULL, 0),
(717, 421, 82, '2014-2015', NULL, 0),
(718, 421, 14, '2015-2016', NULL, 0),
(719, 421, 3, '2016-2018', NULL, 0),
(720, 421, 88, '2020-2022', NULL, 0),
(721, 421, 87, '2023-2025', NULL, 0),
(722, 421, 99, '2025-act', NULL, 1),
(723, 421, 103, '2019-2020', NULL, 0),
(724, 421, 44, '2005-2008', NULL, 0),
(725, 427, 11, '2014-2017', NULL, 0),
(726, 427, 8, '2017-2018', NULL, 0),
(727, 427, 2, '2018-2021', NULL, 0),
(728, 427, 7, '2021-2024', NULL, 0),
(729, 427, 103, '2024-act', NULL, 1),
(730, 430, 82, '2011-2018', NULL, 0),
(731, 430, 1, '2019-2023', NULL, 0),
(732, 430, 6, '2023-2024', NULL, 0),
(733, 430, 104, '2024-act', NULL, 1),
(734, 430, 74, '2018-2019', NULL, 0),
(735, 1, 83, '2025-act', NULL, 1),
(736, 310, 2, '2025-act', NULL, 1),
(737, 128, 2, '2025-act', NULL, 1),
(738, 218, 2, '2025-act', NULL, 1),
(739, 382, 7, '2025-act', NULL, 1),
(740, 103, 80, '2025-act', NULL, 1),
(741, 423, 1, '2012-2017', NULL, 0),
(742, 423, 6, '2017-2022', NULL, 0),
(743, 423, 21, '2022-2025', NULL, 0),
(744, 423, 1, '2025-act', NULL, 1),
(745, 19, 22, '2025-act', NULL, 1),
(746, 10, 91, '2025-ACT', NULL, 1),
(747, 2, 19, '2025-act', NULL, 1),
(748, 124, 59, '2022-2023', NULL, 0),
(749, 320, 26, '2025-act', NULL, 1),
(750, 320, 1, '2014-2016', NULL, 0),
(751, 320, 26, '2016-2023', NULL, 0),
(752, 37, 26, '2025-act', NULL, 1),
(753, 215, 26, '2025-act', NULL, 1),
(754, 215, 59, '2018-2019', NULL, 0),
(755, 215, 44, '2019-2020', NULL, 0),
(756, 215, 79, '2022-2024', NULL, 0),
(757, 326, 26, '2025-act', NULL, 1),
(758, 326, 36, '2012-2018', NULL, 0),
(759, 326, 44, '2018-2021', NULL, 0),
(760, 266, 26, '2025-act', NULL, 1),
(761, 266, 10, '2018-2024', NULL, 0),
(762, 89, 26, '2025-act', NULL, 1),
(763, 154, 2, '2018-2022', NULL, 0),
(764, 154, 6, '2022-2024', NULL, 0),
(765, 150, 21, '2021-2024', NULL, 0),
(766, 150, 48, '2016-2018', NULL, 0),
(767, 150, 42, '2018-2020', NULL, 0),
(769, 270, 6, '2025-act', NULL, 1),
(770, 270, 59, '2015-2019', NULL, 0),
(771, 411, 6, '2025-act', NULL, 1),
(772, 328, 6, '2025-act', NULL, 1),
(773, 328, 11, '2022-2024', NULL, 0),
(774, 328, 9, '2019-2021', NULL, 0),
(775, 328, 86, '2021-2022', NULL, 0),
(776, 328, 12, '2018-2019', NULL, 0),
(777, 328, 44, '2017-2018', NULL, 0),
(779, 245, 6, '2025-act', NULL, 1),
(780, 355, 12, '2025-act', NULL, 1),
(781, 208, 12, '2025-act', NULL, 1),
(782, 208, 11, '2020-2022', NULL, 0),
(783, 208, 55, '2022-2023', NULL, 0),
(784, 208, 79, '2023-2024', NULL, 0),
(785, 256, 12, '2025-act', NULL, 1),
(786, 76, 12, '2025-act', NULL, 1),
(787, 76, 4, '2020-2024', NULL, 0),
(788, 216, 12, '2025-act', NULL, 1),
(789, 407, 12, '2025-act', NULL, 1),
(790, 380, 12, '2025-act', NULL, 1),
(791, 380, 25, '2017-2019', NULL, 0),
(792, 307, 12, '2025-act', NULL, 1),
(793, 307, 44, '2021-2022', NULL, 0),
(794, 181, 12, '2024-act', NULL, 1),
(795, 181, 6, '2022-2024', NULL, 0),
(797, 56, 78, '2025-act', NULL, 1),
(798, 304, 78, '2025-act', NULL, 1),
(799, 225, 109, '2025-act', NULL, 1),
(800, 48, 8, '2025-act', NULL, 1),
(801, 74, 8, '2025-act', NULL, 1),
(802, 74, 7, '2020-2023', NULL, 0),
(803, 28, 8, '2025-act', NULL, 1),
(804, 36, 8, '2025-act', NULL, 1),
(805, 120, 8, '2025-act', NULL, 1),
(806, 120, 80, '2020-2022', NULL, 0),
(807, 120, 12, '2022-2024', NULL, 0),
(808, 9, 109, '2025-act', NULL, 1),
(815, 383, 25, '2025-act', NULL, 1),
(816, 453, 23, '2023-act', NULL, 1),
(817, 25, 48, '2025-act', NULL, 1),
(818, 474, 23, '2018-act', NULL, 1),
(819, 475, 23, '2024-act', NULL, 1),
(820, 476, 23, '2024-act', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trofeos`
--

CREATE TABLE `trofeos` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `tipo` text NOT NULL,
  `icono` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trofeos`
--

INSERT INTO `trofeos` (`id`, `nombre`, `tipo`, `icono`) VALUES
(1, 'UWCL', 'clubes', 'media/1-EU/trofeos/uwcl.png'),
(2, 'WWC', 'selecciones', 'media/2-WORLD/WWC.png'),
(3, 'The Best', 'jugadora', 'media/1-EU/trofeos/thebest.png'),
(4, 'FIFPRO World XI', 'jugadora', 'media/2-WORLD/individuales/FIFPRO_XI.png'),
(5, 'Uefa Euro Cup', 'seleccion', 'media/1-EU/trofeos/euro.png'),
(6, 'Liga F', 'club', 'media/ES/trofeos/ligaF.png'),
(7, 'Copa de SM Reina', 'clubes', 'media/ES/trofeos/copa-reina.png'),
(8, 'Supercopa de España', 'clubes', 'media/ES/trofeos/supercopa.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  `rol` int(11) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `jugadora_favorita` int(11) DEFAULT NULL,
  `es_jugadora` int(11) DEFAULT NULL,
  `token` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `Nombre`, `Apellidos`, `usuario`, `rol`, `Contrasena`, `jugadora_favorita`, `es_jugadora`, `token`) VALUES
(3, 'Valencian', 'Sports', 'admin', 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, NULL, ''),
(5, 'Admin', 'merce', 'admin1', 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, NULL, ''),
(6, 'pruebas', 'unos', 'Prueba89', 2, '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, NULL, ''),
(8, 'Rubén', 'García', 'rvby22', 1, 'pbkdf2_sha256$1000000$wivGSfoO5XHsZiMicxDgyR$gPRZL05w38srLubDY7UjKITOSflN88h0fplvWskdxbc=', 1, NULL, ''),
(10, '', '', 'ruby22', 1, 'pbkdf2_sha256$1000000$lzprDp90o7zhxLGaAGqvFC$HPkswl6ibqisnpjXIP+IHKS585EaZrPDjP0w1wrX+NE=', NULL, NULL, ''),
(11, 'Emma', 'Holmgren', 'emmaholmgrenn', 1, 'pbkdf2_sha256$1000000$4bXsvppvC8MJrUlItg0OqY$tbGetHfkyNrUulxIsoFIRqT6i6ymEVRwwA9T8th6TpQ=', 25, 25, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `equipo-trofeo`
--
ALTER TABLE `equipo-trofeo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipo` (`equipo`),
  ADD KEY `trofeo` (`trofeo`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id_equipo`),
  ADD KEY `liga` (`liga`);

--
-- Indices de la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `jugadora-trofeo`
--
ALTER TABLE `jugadora-trofeo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jugadora` (`jugadora`),
  ADD KEY `trofeo` (`trofeo`);

--
-- Indices de la tabla `jugadoras`
--
ALTER TABLE `jugadoras`
  ADD PRIMARY KEY (`id_jugadora`),
  ADD KEY `Nacionalidad` (`Nacionalidad`),
  ADD KEY `Posicion` (`Posicion`);

--
-- Indices de la tabla `ligas`
--
ALTER TABLE `ligas`
  ADD PRIMARY KEY (`id_liga`),
  ADD KEY `pais_2` (`pais`),
  ADD KEY `pais` (`pais`) USING BTREE;

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indices de la tabla `pistas`
--
ALTER TABLE `pistas`
  ADD UNIQUE KEY `id_juego` (`id_juego`) USING BTREE;

--
-- Indices de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD PRIMARY KEY (`idPosicion`),
  ADD KEY `idPosicionPadre` (`idPosicionPadre`);

--
-- Indices de la tabla `rachas`
--
ALTER TABLE `rachas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`),
  ADD KEY `juego` (`juego`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trayectoria`
--
ALTER TABLE `trayectoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jugadora` (`jugadora`),
  ADD KEY `equipo` (`equipo`);

--
-- Indices de la tabla `trofeos`
--
ALTER TABLE `trofeos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Usuario` (`usuario`),
  ADD UNIQUE KEY `es_jugadora_2` (`es_jugadora`),
  ADD KEY `rol` (`rol`),
  ADD KEY `jugadora_favorita` (`jugadora_favorita`) USING BTREE,
  ADD KEY `es_jugadora` (`es_jugadora`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `equipo-trofeo`
--
ALTER TABLE `equipo-trofeo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT de la tabla `juegos`
--
ALTER TABLE `juegos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `jugadora-trofeo`
--
ALTER TABLE `jugadora-trofeo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `jugadoras`
--
ALTER TABLE `jugadoras`
  MODIFY `id_jugadora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=477;

--
-- AUTO_INCREMENT de la tabla `ligas`
--
ALTER TABLE `ligas`
  MODIFY `id_liga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `id_pais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  MODIFY `idPosicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `rachas`
--
ALTER TABLE `rachas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `trayectoria`
--
ALTER TABLE `trayectoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=821;

--
-- AUTO_INCREMENT de la tabla `trofeos`
--
ALTER TABLE `trofeos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equipo-trofeo`
--
ALTER TABLE `equipo-trofeo`
  ADD CONSTRAINT `equipo-trofeo_ibfk_1` FOREIGN KEY (`trofeo`) REFERENCES `trofeos` (`id`),
  ADD CONSTRAINT `equipo-trofeo_ibfk_2` FOREIGN KEY (`equipo`) REFERENCES `equipos` (`id_equipo`);

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`liga`) REFERENCES `ligas` (`id_liga`);

--
-- Filtros para la tabla `jugadora-trofeo`
--
ALTER TABLE `jugadora-trofeo`
  ADD CONSTRAINT `jugadora-trofeo_ibfk_1` FOREIGN KEY (`jugadora`) REFERENCES `jugadoras` (`id_jugadora`),
  ADD CONSTRAINT `jugadora-trofeo_ibfk_2` FOREIGN KEY (`trofeo`) REFERENCES `trofeos` (`id`);

--
-- Filtros para la tabla `jugadoras`
--
ALTER TABLE `jugadoras`
  ADD CONSTRAINT `jugadoras_ibfk_1` FOREIGN KEY (`Nacionalidad`) REFERENCES `paises` (`id_pais`),
  ADD CONSTRAINT `jugadoras_ibfk_2` FOREIGN KEY (`Posicion`) REFERENCES `posiciones` (`idPosicion`);

--
-- Filtros para la tabla `ligas`
--
ALTER TABLE `ligas`
  ADD CONSTRAINT `ligas_ibfk_1` FOREIGN KEY (`pais`) REFERENCES `paises` (`id_pais`);

--
-- Filtros para la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD CONSTRAINT `posiciones_ibfk_1` FOREIGN KEY (`idPosicionPadre`) REFERENCES `posiciones` (`idPosicion`);

--
-- Filtros para la tabla `rachas`
--
ALTER TABLE `rachas`
  ADD CONSTRAINT `rachas_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `rachas_ibfk_2` FOREIGN KEY (`juego`) REFERENCES `pistas` (`id_juego`);

--
-- Filtros para la tabla `trayectoria`
--
ALTER TABLE `trayectoria`
  ADD CONSTRAINT `trayectoria_ibfk_1` FOREIGN KEY (`jugadora`) REFERENCES `jugadoras` (`id_jugadora`),
  ADD CONSTRAINT `trayectoria_ibfk_2` FOREIGN KEY (`equipo`) REFERENCES `equipos` (`id_equipo`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`jugadora_favorita`) REFERENCES `jugadoras` (`id_jugadora`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`es_jugadora`) REFERENCES `jugadoras` (`id_jugadora`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
