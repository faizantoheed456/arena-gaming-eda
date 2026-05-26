-- ============================================================
-- FILE 2 OF 3: LOCATIONS AND COUNTRIES
-- Purpose : Creates the full normalized location hierarchy
--           LANGUAGE -> COUNTRY -> COUNTRY_LOCATION
-- Run this file SECOND, after 01_platforms_and_games.sql
-- NOTE: Table is named COUNTRY_LOCATION (not LOCATION) to
--       avoid a naming conflict with the communities file
-- ============================================================
-- FIXES APPLIED:
--   COUNTRY data:
--     (8,  'Chile',        7→8) Portuguese→Spanish
--     (11, 'Argentina',    7→8) Portuguese→Spanish
--     (19, 'France',       8→4) Spanish→French
--     (21, 'Spain',       10→8) Russian→Spanish
--     (23, 'Saudi Arabia', 1→9) English→Arabic
--     (24, 'Japan',        6→3) Chinese→Japanese
--   COUNTRY_LOCATION data:
--     (13, 'AF'→'EU', 13) Turkey is in Europe, not Africa
--     (23, 'AF'→'AS', 23) Saudi Arabia is in Asia, not Africa
-- ============================================================
 
SET FOREIGN_KEY_CHECKS = 0;
 
DROP TABLE IF EXISTS `COUNTRY_LOCATION`;
DROP TABLE IF EXISTS `COUNTRY`;
DROP TABLE IF EXISTS `LANGUAGE`;
 
SET FOREIGN_KEY_CHECKS = 1;
 
 
-- ============================================================
-- TABLE DEFINITIONS
-- ============================================================
 
CREATE TABLE `LANGUAGE` (
    `language_id`   INT          AUTO_INCREMENT PRIMARY KEY,
    `language_name` VARCHAR(100) NOT NULL
);
 
CREATE TABLE `COUNTRY` (
    `country_id`   INT          AUTO_INCREMENT PRIMARY KEY,
    `country_name` VARCHAR(100) NOT NULL,
    `language_id`  INT,
    FOREIGN KEY (`language_id`)
        REFERENCES `LANGUAGE`(`language_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 
CREATE TABLE `COUNTRY_LOCATION` (
    `location_id`  INT          AUTO_INCREMENT PRIMARY KEY,
    `region`       VARCHAR(100) NOT NULL,
    `country_id`   INT,
    FOREIGN KEY (`country_id`)
        REFERENCES `COUNTRY`(`country_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 
 
-- ============================================================
-- DATA INSERTIONS
-- ============================================================
 
-- Parent table first: languages have no foreign keys
INSERT INTO `LANGUAGE` (`language_id`, `language_name`) VALUES
(1,  'English'),
(2,  'Korean'),
(3,  'Japanese'),
(4,  'French'),
(5,  'German'),
(6,  'Chinese'),
(7,  'Portuguese'),
(8,  'Spanish'),
(9,  'Arabic'),
(10, 'Russian');
 
-- Countries depend on LANGUAGE
-- FIX: corrected language_id for Chile (8), Argentina (11),
--      France (19), Spain (21), Saudi Arabia (23), Japan (24)
INSERT INTO `COUNTRY` (`country_id`, `country_name`, `language_id`) VALUES
(1,  'Australia',       1),
(2,  'United States',   1),
(3,  'China',           6),
(4,  'Singapore',       1),
(5,  'South Korea',     2),
(6,  'Netherlands',     1),
(7,  'Denmark',         1),
(8,  'Chile',           8),   -- FIX: was 7 (Portuguese), Chile speaks Spanish
(9,  'Canada',          1),
(10, 'Poland',          1),
(11, 'Argentina',       8),   -- FIX: was 7 (Portuguese), Argentina speaks Spanish
(12, 'Russia',          10),
(13, 'Turkey',          9),
(14, 'New Zealand',     1),
(15, 'Mexico',          8),
(16, 'Taiwan',          6),
(17, 'Brazil',          7),
(18, 'United Kingdom',  1),
(19, 'France',          4),   -- FIX: was 8 (Spanish), France speaks French
(20, 'Sweden',          1),
(21, 'Spain',           8),   -- FIX: was 10 (Russian), Spain speaks Spanish
(22, 'Colombia',        8),
(23, 'Saudi Arabia',    9),   -- FIX: was 1 (English), Saudi Arabia speaks Arabic
(24, 'Japan',           3);   -- FIX: was 6 (Chinese), Japan speaks Japanese
 
-- Locations depend on COUNTRY
-- FIX: corrected region codes for Turkey (13) and Saudi Arabia (23)
INSERT INTO `COUNTRY_LOCATION` (`location_id`, `region`, `country_id`) VALUES
(1,  'OC',      1),
(2,  'Unknown', 2),
(3,  'AS',      3),
(4,  'AS',      4),
(5,  'AS',      5),
(6,  'EU',      6),
(7,  'EU',      7),
(8,  'SA',      8),
(9,  'Unknown', 9),
(10, 'EU',      10),
(11, 'SA',      11),
(12, 'EU',      12),
(13, 'EU',      13),  -- FIX: was 'AF' (Africa), Turkey is in Europe
(14, 'OC',      14),
(15, 'Unknown', 15),
(16, 'AS',      16),
(17, 'SA',      17),
(18, 'EU',      18),
(19, 'EU',      19),
(20, 'EU',      20),
(21, 'EU',      21),
(22, 'SA',      22),
(23, 'AS',      23),  -- FIX: was 'AF' (Africa), Saudi Arabia is in Asia
(24, 'AS',      24);
 
 
-- ============================================================
-- VERIFICATION QUERY
-- ============================================================
 
SELECT
    cl.location_id,
    cl.region,
    c.country_name,
    l.language_name
FROM `COUNTRY_LOCATION` cl
INNER JOIN `COUNTRY` c  USING (country_id)
INNER JOIN `LANGUAGE` l USING (language_id)
ORDER BY cl.location_id ASC;