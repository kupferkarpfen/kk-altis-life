-- --------------------------------------------------------
-- Host:                         altis.just4fungaming24.de
-- Server version:               10.1.19-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table altis_life.blacklist
CREATE TABLE IF NOT EXISTS `blacklist` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.config_items
CREATE TABLE IF NOT EXISTS `config_items` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `internalName` varchar(32) NOT NULL,
  `displayName` varchar(32) NOT NULL DEFAULT '0',
  `weight` tinyint(4) NOT NULL DEFAULT '0',
  `buyPrice` int(11) NOT NULL DEFAULT '0',
  `sellPrice` int(11) NOT NULL DEFAULT '0',
  `illegal` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = legal, 1 = illegal',
  `requirements` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.config_objects
CREATE TABLE IF NOT EXISTS `config_objects` (
  `orderNr` int(11) NOT NULL,
  `class` varchar(50) NOT NULL,
  `shop` varchar(50) NOT NULL,
  `caption` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `requirements` text NOT NULL,
  PRIMARY KEY (`orderNr`,`class`,`shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.config_ssv
CREATE TABLE IF NOT EXISTS `config_ssv` (
  `name` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.config_traders
CREATE TABLE IF NOT EXISTS `config_traders` (
  `name` varchar(50) NOT NULL,
  `caption` varchar(50) NOT NULL,
  `contents` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.config_vehicles
CREATE TABLE IF NOT EXISTS `config_vehicles` (
  `side` char(3) NOT NULL,
  `classname` varchar(50) NOT NULL,
  `trunk` smallint(6) NOT NULL,
  `priceBuy` int(11) NOT NULL,
  `priceRent` int(11) NOT NULL,
  `priceInsure` int(11) NOT NULL,
  `priceUnpark` int(11) NOT NULL,
  `shops` text NOT NULL,
  `requirements` text NOT NULL,
  PRIMARY KEY (`classname`,`side`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for procedure altis_life.createStatistics
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `createStatistics`()
BEGIN

  INSERT INTO statistics ( houses, vehicles, gangs, volume, players3, players7, players14, players30, playersTotal, playersAvgActivity, cash_avg, cash_total, kills24 ) VALUES (
    (SELECT COUNT(*) FROM houses WHERE owned = '1'),
    (SELECT COUNT(*) FROM vehicles WHERE alive = '1'),
    (SELECT COUNT(*) FROM gangs WHERE active = '1'),
    (SELECT SUM(oil+iron+diamond+copper+salt+sarin+cement+gold+silber+holz+beer+brandy+moonshine+turtle+marijuana+cocaine+heroin+meth+uran235+plutonium+nuclearfuel+lsd+jewelry+crocodile+waste+trashbag+trashp) FROM market WHERE type = 1 AND ts >= DATE_SUB(NOW(), INTERVAL 1 DAY)),
    (SELECT COUNT(DISTINCT pid) FROM kvstore kvs WHERE side = 0 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 3 DAY)),
    (SELECT COUNT(DISTINCT pid) FROM kvstore kvs WHERE side = 0 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 7 DAY)),
    (SELECT COUNT(DISTINCT pid) FROM kvstore kvs WHERE side = 0 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 14 DAY)),
    (SELECT COUNT(DISTINCT pid) FROM kvstore kvs WHERE side = 0 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 30 DAY)),
    (SELECT COUNT(DISTINCT pid) FROM kvstore),
    (SELECT AVG(dekaticks) / 6 FROM playtime WHERE lastUpdate > DATE_SUB(NOW(), INTERVAL 30 DAY)),
    (SELECT AVG(v) FROM kvstore kvs WHERE k = 'bank' OR k = 'cash' AND (SELECT dekaticks FROM playtime pt WHERE pt.pid = kvs.pid) > 30 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 30 DAY)),
    (SELECT SUM(v) FROM kvstore kvs WHERE k = 'bank' OR k = 'cash' AND (SELECT dekaticks FROM playtime pt WHERE pt.pid = kvs.pid) > 30 AND (SELECT lastUpdate FROM playtime pt WHERE pt.pid = kvs.pid) > DATE_SUB(NOW(), INTERVAL 30 DAY)),
    (SELECT COUNT(*) FROM plog WHERE log LIKE "%Getötet von%KEINS%" AND ts >= DATE_SUB(NOW(), INTERVAL 3 DAY))
  );

  DELETE FROM statistics WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM statistics ORDER BY ID DESC LIMIT 150 ) foo );
  DELETE FROM market WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM market ORDER BY ID DESC LIMIT 3000 ) foo );
  DELETE FROM pricelog WHERE ts < DATE_SUB(NOW(), INTERVAL 14 DAY);
  DELETE FROM volumelog WHERE ts < DATE_SUB(NOW(), INTERVAL 14 DAY);
  DELETE FROM plog WHERE ts < DATE_SUB(NOW(), INTERVAL 90 DAY);
END//
DELIMITER ;


-- Dumping structure for procedure altis_life.deleteDeadVehicles
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `deleteDeadVehicles`()
    NO SQL
BEGIN
	DELETE FROM vehicles WHERE alive = 0 AND ts_modified < DATE_SUB(NOW(), INTERVAL 14 DAY);
	UPDATE vehicles SET alive = '0', ts_modified = CURRENT_TIMESTAMP WHERE locked = '1' AND ts_modified < DATE_SUB(NOW(), INTERVAL 14 DAY);
END//
DELIMITER ;


-- Dumping structure for procedure altis_life.deleteOldGangs
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `deleteOldGangs`()
    NO SQL
BEGIN
  UPDATE `gangs` SET `active` = 0 WHERE `lastactivity` <= DATE_SUB(NOW(), INTERVAL 45 DAY);
  DELETE FROM `gangs` WHERE `active` = 0;
END//
DELIMITER ;


-- Dumping structure for procedure altis_life.deleteOldHouses
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `deleteOldHouses`()
    NO SQL
BEGIN
  UPDATE houses SET owned = 0 WHERE pid IN (SELECT playerid FROM player_alias GROUP BY playerid HAVING MAX(lastjoined) <= DATE_SUB(NOW(), INTERVAL 45 DAY));
  DELETE FROM `houses` WHERE `owned` = 0;
END//
DELIMITER ;


-- Dumping structure for procedure altis_life.deleteOldWantedEntries
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `deleteOldWantedEntries`()
BEGIN
   UPDATE wanted SET active = 0 WHERE ts < DATE_SUB(NOW(), INTERVAL 10 DAY);
	DELETE FROM wanted WHERE active = 0 AND ts < DATE_SUB(NOW(), INTERVAL 3 DAY);
END//
DELIMITER ;


-- Dumping structure for table altis_life.gangbanklog
CREATE TABLE IF NOT EXISTS `gangbanklog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_gang` int(11) NOT NULL,
  `pid` varchar(32) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `amount` int(11) NOT NULL,
  `ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `members` text NOT NULL,
  `moderators` text NOT NULL,
  `maxmembers` int(2) NOT NULL DEFAULT '8',
  `bank` int(100) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `lastactivity` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  FULLTEXT KEY `members` (`members`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(32) NOT NULL,
  `pos` varchar(64) DEFAULT NULL,
  `trunk` text,
  `containers` text,
  `owned` tinyint(4) DEFAULT '0',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.kvstore
CREATE TABLE IF NOT EXISTS `kvstore` (
  `pid` char(17) NOT NULL,
  `k` varchar(50) NOT NULL,
  `side` int(11) NOT NULL,
  `v` text NOT NULL,
  `t` text,
  PRIMARY KEY (`pid`,`k`,`side`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for view altis_life.lockedvehicles
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `lockedvehicles` (
	`id` INT(12) NOT NULL,
	`classname` VARCHAR(40) NOT NULL COLLATE 'latin1_swedish_ci',
	`color` INT(20) NOT NULL,
	`name` MEDIUMTEXT NULL COLLATE 'utf8_general_ci',
	`ts` TIMESTAMP NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for table altis_life.market
CREATE TABLE IF NOT EXISTS `market` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0',
  `oil` int(11) NOT NULL DEFAULT '0',
  `iron` int(11) NOT NULL DEFAULT '0',
  `diamond` int(11) NOT NULL DEFAULT '0',
  `copper` int(11) NOT NULL DEFAULT '0',
  `salt` int(11) NOT NULL DEFAULT '0',
  `sarin` int(11) NOT NULL DEFAULT '0',
  `cement` int(11) NOT NULL DEFAULT '0',
  `gold` int(11) NOT NULL DEFAULT '0',
  `silber` int(11) NOT NULL DEFAULT '0',
  `holz` int(11) NOT NULL DEFAULT '0',
  `beer` int(11) NOT NULL DEFAULT '0',
  `brandy` int(11) NOT NULL DEFAULT '0',
  `moonshine` int(11) NOT NULL DEFAULT '0',
  `turtle` int(11) NOT NULL DEFAULT '0',
  `marijuana` int(11) NOT NULL DEFAULT '0',
  `cocaine` int(11) NOT NULL DEFAULT '0',
  `heroin` int(11) NOT NULL DEFAULT '0',
  `meth` int(11) NOT NULL DEFAULT '0',
  `uran235` int(11) NOT NULL DEFAULT '0',
  `plutonium` int(11) NOT NULL DEFAULT '0',
  `nuclearfuel` int(11) NOT NULL DEFAULT '0',
  `lsd` int(11) NOT NULL DEFAULT '0',
  `jewelry` int(11) NOT NULL DEFAULT '0',
  `crocodile` int(11) NOT NULL DEFAULT '0',
  `waste` int(11) NOT NULL DEFAULT '0',
  `trashbag` int(11) NOT NULL DEFAULT '0',
  `trashp` int(11) NOT NULL DEFAULT '0',
  `barrel` int(11) NOT NULL DEFAULT '0',
  `glass` int(11) NOT NULL DEFAULT '0',
  `players` int(11) NOT NULL DEFAULT '0',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `uid` int(12) NOT NULL AUTO_INCREMENT,
  `fromID` varchar(50) NOT NULL,
  `toID` varchar(50) NOT NULL,
  `message` text,
  `fromName` varchar(32) NOT NULL,
  `toName` varchar(32) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `toID` (`toID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.pcomments
CREATE TABLE IF NOT EXISTS `pcomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(50) NOT NULL DEFAULT '0',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supporter` varchar(50) NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.player_alias
CREATE TABLE IF NOT EXISTS `player_alias` (
  `playerid` char(17) NOT NULL,
  `name` varchar(50) NOT NULL,
  `firstjoined` datetime NOT NULL,
  `lastjoined` datetime NOT NULL,
  PRIMARY KEY (`playerid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.playtime
CREATE TABLE IF NOT EXISTS `playtime` (
  `pid` char(17) NOT NULL,
  `dekaticks` int(11) NOT NULL,
  `lastUpdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.plog
CREATE TABLE IF NOT EXISTS `plog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(50) NOT NULL,
  `type` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `log` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.pricelog
CREATE TABLE IF NOT EXISTS `pricelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `resource` (`resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for procedure altis_life.resetLifeVehicles
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `resetLifeVehicles`()
    NO SQL
BEGIN
	UPDATE vehicles SET active = 0 WHERE active != 0 AND alive = 1;
END//
DELIMITER ;


-- Dumping structure for table altis_life.slog
CREATE TABLE IF NOT EXISTS `slog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `supporter` varchar(50) NOT NULL,
  `pid` varchar(50) NOT NULL,
  `side` int(11) NOT NULL DEFAULT '0',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.statistics
CREATE TABLE IF NOT EXISTS `statistics` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `houses` int(11) DEFAULT '0',
  `vehicles` int(11) DEFAULT '0',
  `gangs` int(11) DEFAULT '0',
  `players3` int(11) DEFAULT '0',
  `players7` int(11) DEFAULT '0',
  `players14` int(11) DEFAULT '0',
  `players30` int(11) DEFAULT '0',
  `playersTotal` int(11) DEFAULT '0',
  `playersAvgActivity` float DEFAULT '0',
  `kills24` int(11) DEFAULT '0',
  `cash_avg` float DEFAULT '0',
  `cash_total` float DEFAULT '0',
  `volume` int(11) DEFAULT '0',
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for procedure altis_life.updateActivity
DELIMITER //
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `updateActivity`(IN `player` VARCHAR(50))
BEGIN
  INSERT INTO playtime (pid, dekaticks) VALUES (player, 1) ON DUPLICATE KEY UPDATE dekaticks = dekaticks + 1;
  UPDATE gangs SET lastactivity = CURRENT_TIMESTAMP WHERE members LIKE CONCAT("%", player, "%");
  UPDATE houses SET lastUpdate  = CURRENT_TIMESTAMP WHERE pid = player;
END//
DELIMITER ;


-- Dumping structure for view altis_life.vcurrenttime
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vcurrenttime` (
	`Hour` INT(2) NULL,
	`Minute` INT(2) NULL,
	`Second` INT(2) NULL,
	`Day` INT(2) NULL,
	`Month` INT(2) NULL,
	`Year` INT(4) NULL,
	`DayOfWeek` INT(1) NULL
) ENGINE=MyISAM;


-- Dumping structure for table altis_life.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `side` varchar(15) NOT NULL,
  `classname` varchar(40) NOT NULL,
  `type` varchar(12) NOT NULL,
  `pid` varchar(32) NOT NULL,
  `alive` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `sold` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `color` int(20) NOT NULL,
  `trunk` text NOT NULL,
  `chip` tinyint(1) NOT NULL DEFAULT '0',
  `ts_bought` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `side` (`side`),
  KEY `pid` (`pid`),
  KEY `type` (`type`),
  KEY `alive` (`alive`),
  KEY `active` (`active`),
  KEY `sold` (`sold`),
  KEY `locked` (`locked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for view altis_life.vgangbanklog
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vgangbanklog` (
	`id` INT(11) NOT NULL,
	`name` TEXT NOT NULL COLLATE 'utf8_general_ci',
	`date` VARCHAR(21) NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(10) NOT NULL COLLATE 'utf8mb4_general_ci',
	`amount` INT(11) NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for table altis_life.volumelog
CREATE TABLE IF NOT EXISTS `volumelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(50) NOT NULL,
  `volume` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `resource` (`resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table altis_life.wanted
CREATE TABLE IF NOT EXISTS `wanted` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `playerid` char(20) NOT NULL,
  `message` text NOT NULL,
  `value` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for view altis_life.lockedvehicles
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `lockedvehicles`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` VIEW `lockedvehicles` AS select `v`.`id` AS `id`,`v`.`classname` AS `classname`,`v`.`color` AS `color`,(select `k`.`v` from `kvstore` `k` where ((`k`.`pid` = convert(`v`.`pid` using utf8)) and (`k`.`k` = 'name') and (`k`.`side` = 0))) AS `name`,`v`.`ts_modified` AS `ts` from `vehicles` `v` where ((`v`.`locked` = 1) and (`v`.`alive` = 1)) ;


-- Dumping structure for view altis_life.vcurrenttime
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vcurrenttime`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` VIEW `vcurrenttime` AS select hour(now()) AS `Hour`,minute(now()) AS `Minute`,second(now()) AS `Second`,dayofmonth(now()) AS `Day`,month(now()) AS `Month`,year(now()) AS `Year`,dayofweek(now()) AS `DayOfWeek` ;


-- Dumping structure for view altis_life.vgangbanklog
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vgangbanklog`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` VIEW `vgangbanklog` AS select `gangbanklog`.`ID_gang` AS `id`,`kvstore`.`v` AS `name`,date_format(`gangbanklog`.`ts`,'%e.%c.%Y %H:%i') AS `date`,if((`gangbanklog`.`type` = 2),'ABHEBUNG','EINZAHLUNG') AS `type`,`gangbanklog`.`amount` AS `amount` from (`gangbanklog` join `kvstore`) where ((`gangbanklog`.`pid` = `kvstore`.`pid`) and (`kvstore`.`k` = 'name') and (`kvstore`.`side` = '0')) order by `gangbanklog`.`ts` desc ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
