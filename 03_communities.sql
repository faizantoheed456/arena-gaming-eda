 
DROP VIEW IF EXISTS 'vw_complete_community_profiles';
DROP VIEW IF EXISTS 'vw_community_metrics_dashboard';
DROP VIEW IF EXISTS 'vw_community_game_assignments';

DROP TABLE IF EXISTS 'COMMUNITY_GAME';
DROP TABLE IF EXISTS 'COMMUNITY_SOCIAL_MEDIA';
DROP TABLE IF EXISTS 'COMMUNITY_STAFF';
DROP TABLE IF EXISTS 'COMMUNITY_COMPETITION';
DROP TABLE IF EXISTS 'COMMUNITY_MEMBERSHIP';
DROP TABLE IF EXISTS 'COMMUNITY';
DROP TABLE IF EXISTS 'COMMUNITY_REGION';
DROP TABLE IF EXISTS 'GAMING_PLATFORM';

SET FOREIGN_KEY_CHECKS = 1;

-- Broad geographic region lookup for communities
CREATE TABLE 'COMMUNITY_REGION' (
  'region_id' INT AUTO_INCREMENT PRIMARY KEY,
  'region_name' VARCHAR(100) NOT NULL
);

-- Gaming console or PC platform used by communities
CREATE TABLE 'GAMING_PLATFORM' (
  'gaming_platform_id' INT AUTO_INCREMENT PRIMARY KEY,
  'platform_name' VARCHAR(100) NOT NULL
);

-- Core community profiles including tier, region, and platform
CREATE TABLE 'COMMUNITY' (
  'community_id' INT AUTO_INCREMENT PRIMARY KEY,
  'community_name' VARCHAR(255) NOT NULL,
  'year_founded' INT,
  'avg_member_age' DECIMAL(5, 2),
  'community_tier' VARCHAR(50),
  'region_id' INT,
  'gaming_platform_id' INT,
  FOREIGN KEY ('region_id')
    REFERENCES 'COMMUNITY_REGION'('region_id')
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY ('gaming_platform_id')
    REFERENCES 'GAMING_PLATFORM'('gaming_platform_id')
    ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tracks total members and active player counts per community
CREATE TABLE 'COMMUNITY_MEMBERSHIP' (
  'membership_id' INT AUTO_INCREMENT PRIMARY KEY,
  'community_id' INT NOT NULL,
  'member_count' INT DEFAULT 0,
  'active_players' INT DEFAULT 0,
  FOREIGN KEY ('community_id')
    REFERENCES 'COMMUNITY'('community_id')
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Records tournaments hosted and top player rankings per community
CREATE TABLE 'COMMUNITY_COMPETITION' (
  'competition_id' INT AUTO_INCREMENT PRIMARY KEY,
  'community_id' INT NOT NULL,
  'tournaments_hosted' INT DEFAULT 0,
  'top_player_rank' INT,
  FOREIGN KEY ('community_id')
    REFERENCES 'COMMUNITY'('community_id')
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Stores coaching staff and content creator counts per community
CREATE TABLE 'COMMUNITY_STAFF' (
  'staff_id' INT AUTO_INCREMENT PRIMARY KEY,
  'community_id' INT NOT NULL,
  'coaching_staff' INT DEFAULT 0,
  'content_creators' INT DEFAULT 0,
  FOREIGN KEY ('community_id')
    REFERENCES 'COMMUNITY' ('community_id')
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tracks community presence and size on each social platform
CREATE TABLE 'COMMUNITY_SOCIAL_MEDIA' (
  'community_social_id' INT AUTO_INCREMENT PRIMARY KEY,
  'community_id' INT NOT NULL,
  'social_platform_id' INT NOT NULL,
  'platform_size' INT DEFAULT 0,
  FOREIGN KEY ('community_id')
    REFERENCES 'COMMUNITY' ('community_id')
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ('social_platform_id')
    REFERENCES 'SOCIAL_PLATFORM' ('social_platform_id')
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Links communities to games with primary or secondary designation
CREATE TABLE 'COMMUNITY_GAME' (
  'community_id' INT NOT NULL,
  'game_id' INT NOT NULL,
  'play_designation' VARCHAR(100),
  PRIMARY KEY ('community_id', 'game_id'),
  FOREIGN KEY ('community_id')
    REFERENCES 'COMMUNITY' ('community_id')
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ('game_id')
    REFERENCES 'GAME' ('game_id')
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Region lookup values
INSERT INTO 'COMMUNITY_REGION' ('region_id', 'region_name') VALUES
(1, 'North America'), (2, 'Europe'), (3, 'Asia-Pacific'),
(4, 'South America'), (5, 'Africa'), (6, 'United States'),
(7, 'United Kingdom'), (8, 'Canada'), (9, 'Germany'),
(10, 'France'), (11, 'Australia'), (12, 'South Korea'),
(13, 'Japan'), (14, 'Brazil'), (15, 'Nordic'),
(16, 'Eastern Europe'), (17, 'Middle East'), (18, 'Southeast Asia'),
(19, 'Mexico'), (20, 'Oceania'), (21, 'Global East'),
(22, 'Global West'), (23, 'Central America'), (24, 'Iberia'),
(25, 'Benelux'), (26, 'Italy'), (27, 'Spain'),
(28, 'Portugal'), (29, 'Netherlands'), (30, 'Belgium');

-- Gaming platform lookup values
INSERT INTO 'GAMING_PLATFORM' ('gaming_platform_id', 'platform_name') VALUES
(1, 'PC Steam'),
(2, 'Discord Hub'),
(3, 'PlayStation Network'),
(4, 'Xbox Live'),
(5, 'Nintendo Switch Online');

-- 30 community profiles (trimmed from 357)
INSERT INTO 'COMMUNITY' (
  'community_id', 'community_name', 'year_founded',
  'avg_member_age', 'community_tier', 'region_id', 'gaming_platform_id'
) VALUES
(1, 'Nitro Wolves', 2020, 17.1, 'Amateur', 1, 1),
(2, 'Arcane Wolves', 2019, 21.9, 'Amateur', 2, 1),
(3, 'Storm Front', 2016, 26.1, 'Amateur', 3, 2),
(4, 'Frost Warriors', 2020, 17.3, 'Professional', 4, 2),
(5, 'Frozen North', 2019, 25.9, 'Semi-Pro', 5, 2),
(6, 'Eco Force', 2022, 22.5, 'Professional', 6, 3),
(7, 'Hellfire', 2020, 24.8, 'Professional', 7, 3),
(8, 'Iron Wolves', 2020, 17.2, 'Semi-Pro', 8, 2),
(9, 'Clutch Factor', 2020, 21.6, 'Amateur', 9, 2),
(10, 'Speed Demons', 2020, 26.4, 'Semi- Pro', 10, 3),
(11, 'Raging Bulls', 2022, 24.1, 'Semi- Pro', 11, 2),
(12, 'Iron Tide', 2021, 24.3, 'Amateur', 12, 2),
(13, 'Byte Force', 2016, 23.3, 'Semi- Pro', 13, 2),
(14, 'Ace Pack', 2020, 31.8, 'Amateur', 14, 4),
(15, 'Neon Riders', 2017, 26.0, 'Amateur', 15, 5),
(16, 'Neon Wolves', 2018, 22.6, 'Amateur', 16, 3),
(17, 'Thundercats', 2016, 26.0, 'Semi- Pro', 17, 2),
(18, 'Lunar Strike', 2016, 27.8, 'Amateur', 18, 2),
(19, 'Flash Clan', 2016, 21.4, 'Amateur', 19, 3),
(20, 'Sunfire', 2023, 20.5, 'Amateur', 20, 2),
(21, 'Black Hole Squad', 2023, 22.6, 'Semi- Pro', 21, 5),
(22, 'Solar Monks', 2016, 24.9, 'Semi- Pro', 22, 2),
(23, 'Packet Loss', 2016, 22.2, 'Amateur', 23, 2),
(24, 'Ghost Protocol', 2020, 22.6, 'Semi- Pro', 24, 1),
(25, 'Dusk Raiders', 2020, 15.7, 'Amateur', 25, 2),
(26, 'Sky Wolves', 2023, 22.6, 'Semi- Pro', 26, 1),
(27, 'Arcane Brotherhood', 2023, 16.5, 'Semi- Pro', 27, 3),
(28, 'Plateau Riders', 2016, 19.6, 'Amateur', 28, 2),
(29, 'Savage Storm', 2016, 29.3, 'Semi- Pro', 29, 2),
(30, 'Shadow Reapers', 2022, 20.5, 'Amateur', 30, 2);

-- Membership stats for 30 communities
INSERT INTO 'COMMUNITY_MEMBERSHIP' ('community_id', 'member_count', 'active_players') VALUES
(1, 421, 243), (2, 166, 77), (3, 115, 36), (4, 181, 104), (5, 2800, 1056),
(6, 1078, 345), (7, 332, 131), (8, 3085, 1149), (9, 1259, 614), (10, 8635, 2004),
(11, 3020, 975), (12, 913, 451), (13, 9665, 3270), (14, 50, 26), (15, 1099, 284),
(16, 560, 295), (17, 1663, 824), (18, 213, 157), (19, 178, 77), (20, 115, 61),
(21, 3842, 1341), (22, 1089, 500), (23, 1054, 505), (24, 1844, 670), (25, 147, 71),
(26, 533, 203), (27, 367, 164), (28, 656, 174), (29, 68819, 8596), (30, 92, 58);

-- Competition records for 30 communities
INSERT INTO 'COMMUNITY_COMPETITION' ('community_id', 'tournaments_hosted', 'top_player_rank') VALUES
(1, 2, 5), (2, 1, 12), (3, 0, 8), (4, 5, 3), (5, 1, 7),
(6, 3, 2), (7, 4, 1), (8, 2, 9), (9, 1, 14), (10, 3, 4),
(11, 2, 6), (12, 1, 11), (13, 4, 5), (14, 0, 20), (15, 1, 15),
(16, 0, 17), (17, 2, 8), (18, 1, 13), (19, 0, 16), (20, 0, 18),
(21, 3, 7), (22, 2, 9), (23, 0, 19), (24, 1, 10), (25, 0, 22),
(26, 2, 11), (27, 1, 14), (28, 0, 21), (29, 4, 6), (30, 1, 13);

-- Staff data for 30 communities
INSERT INTO 'COMMUNITY_STAFF' ('community_id', 'coaching_staff', 'content_creators') VALUES
(1, 0, 2), (2, 0, 1), (3, 0, 0), (4, 3, 14), (5, 0, 3),
(6, 3, 8), (7, 4, 6), (8, 1, 1), (9, 0, 1), (10, 0, 1),
(11, 1, 3), (12, 0, 0), (13, 0, 1), (14, 0, 1), (15, 0, 2),
(16, 0, 0), (17, 0, 0), (18, 0, 0), (19, 0, 1), (20, 0, 0),
(21, 1, 0), (22, 0, 0), (23, 0, 1), (24, 0, 1), (25, 0, 1),
(26, 0, 0), (27, 0, 2), (28, 0, 0), (29, 7, 0), (30, 2, 0);

-- Social media presence for 30 communities across 2 platforms
INSERT INTO 'COMMUNITY_SOCIAL_MEDIA' ('community_id', 'social_platform_id', 'platform_size') VALUES
(1, 1, 310), (1, 2, 180), (2, 1, 120), (2, 2, 50),
(3, 1, 80), (3, 2, 30), (4, 1, 140), (4, 2, 90),
(5, 1, 2100), (5, 2, 900), (6, 1, 820), (6, 2, 380),
(7, 1, 260), (7, 2, 120), (8, 1, 2400), (8, 2, 1000),
(9, 1, 950), (9, 2, 500), (10, 1, 6500), (10, 2, 2000),
(11, 1, 2300), (11, 2, 850), (12, 1, 700), (12, 2, 350),
(13, 1, 7300), (13, 2, 2800), (14, 1, 40), (14, 2, 15),
(15, 1, 830), (15, 2, 260), (16, 1, 430), (16, 2, 200),
(17, 1, 1260), (17, 2, 640), (18, 1, 160), (18, 2, 90),
(19, 1, 140), (19, 2, 65), (20, 1, 90), (20, 2, 45),
(21, 1, 2900), (21, 2, 1100), (22, 1, 830), (22, 2, 400),
(23, 1, 800), (23, 2, 390), (24, 1, 1400), (24, 2, 560),
(25, 1, 110), (25, 2, 50), (26, 1, 410), (26, 2, 170),
(27, 1, 280), (27, 2, 130), (28, 1, 500), (28, 2, 155),
(29, 1, 52000), (29, 2, 7800), (30, 1, 70), (30, 2, 35);

-- Game assignments for 30 communities
INSERT INTO 'COMMUNITY_GAME' ('community_id', 'game_id', 'play_designation') VALUES
(1, 1, 'Primary'), (1, 2, 'Secondary'),
(2, 3, 'Primary'),
(3, 4, 'Primary'), (3, 5, 'Secondary'),
(4, 1, 'Primary'), (4, 6, 'Secondary'),
(5, 7, 'Primary'), (5, 8, 'Secondary'),
(6, 9, 'Primary'), (6, 10, 'Secondary'),
(7, 1, 'Primary'), (7, 5, 'Secondary'),
(8, 1, 'Primary'),
(9, 7, 'Primary'),
(10, 11, 'Primary'), (10, 3, 'Secondary'),
(11, 12, 'Primary'), (11, 10, 'Secondary'),
(12, 13, 'Primary'),
(13, 14, 'Primary'), (13, 6, 'Secondary'),
(14, 1, 'Primary'), (14, 6, 'Secondary'),
(15, 8, 'Primary'),
(16, 4, 'Primary'), (16, 14, 'Secondary'),
(17, 13, 'Primary'), (17, 1, 'Secondary'),
(18, 11, 'Primary'), (18, 4, 'Secondary'),
(19, 3, 'Primary'), (19, 15, 'Secondary'),
(20, 12, 'Primary'),
(21, 1, 'Primary'), (21, 12, 'Secondary'),
(22, 13, 'Primary'), (22, 16, 'Secondary'),
(23, 3, 'Primary'),
(24, 15, 'Primary'), (24, 1, 'Secondary'),
(25, 4, 'Primary'),
(26, 13, 'Primary'), (26, 5, 'Secondary'),
(27, 7, 'Primary'), (27, 3, 'Secondary'),
(28, 1, 'Primary'), (28, 8, 'Secondary'),
(29, 9, 'Primary'), (29, 7, 'Secondary'),
(30, 12, 'Primary');

-- View: full community profile with region and platform names
CREATE OR REPLACE VIEW vw_complete_community_profiles AS
SELECT
  c.community_id,
  c.community_name,
  c.year_founded,
  c.avg_member_age,
  c.community_tier,
  r.region_name,
  gp.platform_name AS gaming_platform
FROM 'COMMUNITY' c
LEFT JOIN 'COMMUNITY_REGION' r ON c.region_id = r.region_id
LEFT JOIN 'GAMING_PLATFORM' gp ON c.gaming_platform_id = gp.gaming_platform_id;

-- View: community metrics combining membership, competition, and staff data
CREATE OR REPLACE VIEW vw_community_metrics_dashboard AS
SELECT
  c.community_id,
  c.community_name,
  r.region_name,
  gp.platform_name AS gaming_platform,
  m.member_count,
  m.active_players,
  comp.tournaments_hosted,
  comp.top_player_rank,
  s.coaching_staff,
  s.content_creators
FROM 'COMMUNITY' c
LEFT JOIN 'COMMUNITY_REGION' r ON c.region_id = r.region_id
LEFT JOIN 'GAMING_PLATFORM' gp ON c.gaming_platform_id = gp.gaming_platform_id
INNER JOIN 'COMMUNITY_MEMBERSHIP' m ON c.community_id = m.community_id
INNER JOIN 'COMMUNITY_COMPETITION' comp ON c.community_id = comp.community_id
INNER JOIN 'COMMUNITY_STAFF' s ON c.community_id = s.community_id;

-- View: maps each community to its assigned games
CREATE OR REPLACE VIEW vw_community_game_assignments AS
SELECT
  cg.community_id,
  c.community_name,
  cg.game_id,
  cg.play_designation
FROM 'COMMUNITY_GAME' cg
INNER JOIN 'COMMUNITY' c USING (community_id);

SET FOREIGN_KEY_CHECKS = 1;