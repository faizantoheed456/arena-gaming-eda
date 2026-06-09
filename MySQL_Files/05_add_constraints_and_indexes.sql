-- File 5 of 5: Add constraints and indexes
-- Run this file after files 01, 02, 03, and 04

SET FOREIGN_KEY_CHECKS = 0;

-- Part 1: Check constraints and default values

-- Restrict community tier to allowed values
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_community_tier 
CHECK (`community_tier` IN ('Amateur', 'Semi-Pro', 'Professional', 'Elite'));

-- Restrict average member age between 0 and 100
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_avg_member_age 
CHECK (`avg_member_age` BETWEEN 0 AND 100);

-- Restrict founded year between 1900 and 2100
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_year_founded 
CHECK (`year_founded` BETWEEN 1900 AND 2100);

-- Set default values for count columns
ALTER TABLE `COMMUNITY_MEMBERSHIP` 
MODIFY COLUMN `member_count` INT DEFAULT 0,
MODIFY COLUMN `active_players` INT DEFAULT 0;

ALTER TABLE `COMMUNITY_COMPETITION` 
MODIFY COLUMN `tournaments_hosted` INT DEFAULT 0;

ALTER TABLE `COMMUNITY_STAFF` 
MODIFY COLUMN `coaching_staff` INT DEFAULT 0,
MODIFY COLUMN `content_creators` INT DEFAULT 0;

-- Part 2: NOT NULL and UNIQUE constraints

-- Enforce NOT NULL on important columns
ALTER TABLE `PLATFORM_TYPE`     MODIFY COLUMN `type_name`     VARCHAR(100) NOT NULL;
ALTER TABLE `PLATFORM`          MODIFY COLUMN `primary_platform` VARCHAR(100) NOT NULL;
ALTER TABLE `GENRE`             MODIFY COLUMN `genre_name`     VARCHAR(100) NOT NULL;
ALTER TABLE `GAME`              MODIFY COLUMN `game_name`      VARCHAR(255) NOT NULL;
ALTER TABLE `COMMUNITY_REGION`  MODIFY COLUMN `region_name`    VARCHAR(100) NOT NULL;
ALTER TABLE `GAMING_PLATFORM`   MODIFY COLUMN `platform_name`  VARCHAR(100) NOT NULL;
ALTER TABLE `LANGUAGE`          MODIFY COLUMN `language_name`  VARCHAR(100) NOT NULL;
ALTER TABLE `COUNTRY`           MODIFY COLUMN `country_name`   VARCHAR(100) NOT NULL;
ALTER TABLE `COUNTRY_LOCATION`  MODIFY COLUMN `region`         VARCHAR(50)  NOT NULL;

-- Prevent duplicate lookup values
ALTER TABLE `PLATFORM_TYPE`     ADD CONSTRAINT uq_platform_type_name UNIQUE (`type_name`);
ALTER TABLE `PLATFORM`          ADD CONSTRAINT uq_platform_name      UNIQUE (`primary_platform`);
ALTER TABLE `GENRE`             ADD CONSTRAINT uq_genre_name         UNIQUE (`genre_name`);
ALTER TABLE `GAME`              ADD CONSTRAINT uq_game_name          UNIQUE (`game_name`);
ALTER TABLE `COMMUNITY_REGION`  ADD CONSTRAINT uq_region_name        UNIQUE (`region_name`);
ALTER TABLE `GAMING_PLATFORM`   ADD CONSTRAINT uq_gaming_platform    UNIQUE (`platform_name`);
ALTER TABLE `LANGUAGE`          ADD CONSTRAINT uq_language_name      UNIQUE (`language_name`);
ALTER TABLE `COUNTRY`           ADD CONSTRAINT uq_country_name       UNIQUE (`country_name`);

-- Enforce one-to-one for core community extensions
ALTER TABLE `COMMUNITY_MEMBERSHIP`  ADD CONSTRAINT uq_membership_comm  UNIQUE (`community_id`);
ALTER TABLE `COMMUNITY_COMPETITION` ADD CONSTRAINT uq_competition_comm UNIQUE (`community_id`);
ALTER TABLE `COMMUNITY_STAFF`       ADD CONSTRAINT uq_staff_comm       UNIQUE (`community_id`);

-- Part 3: Indexes for performance

-- Indexes on foreign key columns
CREATE INDEX idx_community_region ON `COMMUNITY`(`region_id`);
CREATE INDEX idx_community_platform ON `COMMUNITY`(`gaming_platform_id`);
CREATE INDEX idx_country_language ON `COUNTRY`(`language_id`);
CREATE INDEX idx_location_country ON `COUNTRY_LOCATION`(`country_id`);
CREATE INDEX idx_membership_comm ON `COMMUNITY_MEMBERSHIP`(`community_id`);
CREATE INDEX idx_competition_comm ON `COMMUNITY_COMPETITION`(`community_id`);
CREATE INDEX idx_community_staff_comm ON `COMMUNITY_STAFF`(`community_id`);
CREATE INDEX idx_community_social_comm ON `COMMUNITY_SOCIAL_MEDIA`(`community_id`);
CREATE INDEX idx_community_social_platform ON `COMMUNITY_SOCIAL_MEDIA`(`social_platform_id`);
CREATE INDEX idx_community_game_comm ON `COMMUNITY_GAME`(`community_id`);
CREATE INDEX idx_community_game_game ON `COMMUNITY_GAME`(`game_id`);

-- Indexes on columns used in WHERE filters
CREATE INDEX idx_community_tier ON `COMMUNITY`(`community_tier`);
CREATE INDEX idx_community_year ON `COMMUNITY`(`year_founded`);
CREATE INDEX idx_membership_member_count ON `COMMUNITY_MEMBERSHIP`(`member_count`);
CREATE INDEX idx_membership_active_players ON `COMMUNITY_MEMBERSHIP`(`active_players`);
CREATE INDEX idx_competition_tournaments ON `COMMUNITY_COMPETITION`(`tournaments_hosted`);
CREATE INDEX idx_competition_top_rank ON `COMMUNITY_COMPETITION`(`top_player_rank`);

-- Indexes on name columns for faster search
CREATE INDEX idx_region_name ON `COMMUNITY_REGION`(`region_name`);
CREATE INDEX idx_game_name ON `GAME`(`game_name`);
CREATE INDEX idx_genre_name ON `GENRE`(`genre_name`);
CREATE INDEX idx_country_name ON `COUNTRY`(`country_name`);
CREATE INDEX idx_language_name ON `LANGUAGE`(`language_name`);

-- Composite index for queries filtering by tier and age together
CREATE INDEX idx_comm_tier_age ON `COMMUNITY`(`community_tier`, `avg_member_age`);

SET FOREIGN_KEY_CHECKS = 1;