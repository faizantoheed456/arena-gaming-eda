CREATE DATABASE IF NOT EXISTS community_db;
USE community_db;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `GAME`;
DROP TABLE IF EXISTS `GENRE`;
DROP TABLE IF EXISTS `PLATFORM`;
DROP TABLE IF EXISTS `PLATFORM_TYPE`;
DROP TABLE IF EXISTS `SOCIAL_PLATFORM`;

SET FOREIGN_KEY_CHECKS = 1;



--Stores platform categories (e.g. Forum, Streaming
CREATE TABLE `PLATFORM_TYPE` (
    `platform_type_id`  INT          AUTO_INCREMENT PRIMARY KEY,
    `type_name`         VARCHAR(100) NOT NULL
);

-- Stores social platforms linked to a platform type
CREATE TABLE `PLATFORM` (
    `platform_id`       INT          AUTO_INCREMENT PRIMARY KEY,
    `primary_platform`  VARCHAR(100) NOT NULL,
    `platform_type_id`  INT,
    FOREIGN KEY (`platform_type_id`)
        REFERENCES `PLATFORM_TYPE`(`platform_type_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Store Game Genres
CREATE TABLE `GENRE` (
    `genre_id`          INT          AUTO_INCREMENT PRIMARY KEY,
    `genre_name`        VARCHAR(100) NOT NULL
);

-- Stores games linked to genre
CREATE TABLE `GAME` (
    `game_id`           INT          AUTO_INCREMENT PRIMARY KEY,
    `game_name`         VARCHAR(255) NOT NULL,
    `genre_id`          INT,
    FOREIGN KEY (`genre_id`)
        REFERENCES `GENRE`(`genre_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Stores social platform size metrics
CREATE TABLE `SOCIAL_PLATFORM` (
    `social_platform_id` INT          AUTO_INCREMENT PRIMARY KEY,
    `platform_name`      VARCHAR(100) NOT NULL
);



-- DATA INSERTIONS
INSERT INTO `PLATFORM_TYPE` (`platform_type_id`, `type_name`) VALUES
(1, 'Forum and Aggregator'),
(2, 'VoIP and Chat Hub'),
(3, 'Streaming Network'),
(4, 'Social Media Platform');

INSERT INTO `GENRE` (`genre_id`, `genre_name`) VALUES
(1, 'FPS'),
(2, 'MOBA'),
(3, 'Battle Royale'),
(4, 'Sports'),
(5, 'MMORPG'),
(6, 'Fighting');

INSERT INTO `SOCIAL_PLATFORM` (`social_platform_id`, `platform_name`) VALUES
(1, 'Discord Server Size'),
(2, 'Reddit Community Size');

INSERT INTO `PLATFORM` (`platform_id`, `primary_platform`, `platform_type_id`) VALUES
(1, 'Reddit',     1),
(2, 'Discord',    2),
(3, 'Twitch',     3),
(4, 'Twitter/X',  4),
(5, 'YouTube',    3);

INSERT INTO `GAME` (`game_id`, `game_name`, `genre_id`) VALUES
(1,  'Valorant',               1),
(2,  'PUBG: Battlegrounds',    3),
(3,  'League of Legends',      2),
(4,  'Rainbow Six Siege',      1),
(5,  'StarCraft II',           6),
(6,  'Fortnite',               3),
(7,  'Apex Legends',           3),
(8,  'Dota 2',                 2),
(9,  'CS2',                    1),
(10, 'Smite',                  2),
(11, 'Final Fantasy XIV',      5),
(12, 'Call of Duty Warzone',   1),
(13, 'Overwatch 2',            1),
(14, 'Rocket League',          4),
(15, 'Tekken 8',               6),
(16, 'World of Warcraft',      5),
(17, 'Street Fighter 6',       6);



-- VERIFICATION QUERIES
--platforms with their type
SELECT
    p.platform_id,
    p.primary_platform,
    pt.type_name AS platform_classification
FROM `PLATFORM` p
INNER JOIN `PLATFORM_TYPE` pt USING (platform_type_id)
ORDER BY p.platform_id ASC;

-- games with their genre
SELECT
    g.game_id,
    g.game_name,
    ge.genre_name
FROM `GAME` g
INNER JOIN `GENRE` ge USING (genre_id)
ORDER BY g.game_id ASC;

SELECT * FROM `SOCIAL_PLATFORM`;
