
 
SET FOREIGN_KEY_CHECKS = 0;
 
DROP TABLE IF EXISTS `COUNTRY_LOCATION`;
DROP TABLE IF EXISTS `COUNTRY`;
DROP TABLE IF EXISTS `LANGUAGE`;
 
SET FOREIGN_KEY_CHECKS = 1;
 
 

-- Stores supported languages
CREATE TABLE `LANGUAGE` (
    `language_id`   INT          AUTO_INCREMENT PRIMARY KEY,
    `language_name` VARCHAR(100) NOT NULL
);
 
-- Stores countries linked to a primary language
CREATE TABLE `COUNTRY` (
    `country_id`   INT          AUTO_INCREMENT PRIMARY KEY,
    `country_name` VARCHAR(100) NOT NULL,
    `language_id`  INT,
    FOREIGN KEY (`language_id`)
        REFERENCES `LANGUAGE`(`language_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 
-- Stores regional location data linked to a country
CREATE TABLE `COUNTRY_LOCATION` (
    `location_id`  INT          AUTO_INCREMENT PRIMARY KEY,
    `region`       VARCHAR(100) NOT NULL,
    `country_id`   INT,
    FOREIGN KEY (`country_id`)
        REFERENCES `COUNTRY`(`country_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
 

-- DATA INSERTIONS
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
 

INSERT INTO `COUNTRY` (`country_id`, `country_name`, `language_id`) VALUES
(1,  'Australia',       1),
(2,  'United States',   1),
(3,  'China',           6),
(4,  'Singapore',       1),
(5,  'South Korea',     2),
(6,  'Netherlands',     1),
(7,  'Denmark',         1),
(8,  'Chile',           8),   
(9,  'Canada',          1),
(10, 'Poland',          1),
(11, 'Argentina',       8),   
(12, 'Russia',          10),
(13, 'Turkey',          9),
(14, 'New Zealand',     1),
(15, 'Mexico',          8),
(16, 'Taiwan',          6),
(17, 'Brazil',          7),
(18, 'United Kingdom',  1),
(19, 'France',          4),   
(20, 'Sweden',          1),
(21, 'Spain',           8),   
(22, 'Colombia',        8),
(23, 'Saudi Arabia',    9),   
(24, 'Japan',           3);   
 
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
(13, 'EU',      13),  
(14, 'OC',      14),
(15, 'Unknown', 15),
(16, 'AS',      16),
(17, 'SA',      17),
(18, 'EU',      18),
(19, 'EU',      19),
(20, 'EU',      20),
(21, 'EU',      21),
(22, 'SA',      22),
(23, 'AS',      23),  
(24, 'AS',      24);
 
 
-- VERIFICATION QUERY
--full location hierarchy joined across all three tables 
SELECT
    cl.location_id,
    cl.region,
    c.country_name,
    l.language_name
FROM `COUNTRY_LOCATION` cl
INNER JOIN `COUNTRY` c  USING (country_id)
INNER JOIN `LANGUAGE` l USING (language_id)
ORDER BY cl.location_id ASC;

