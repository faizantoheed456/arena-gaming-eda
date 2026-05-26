-- ============================================================
-- FILE 5 OF 5: ADD CONSTRAINTS AND INDEXES (3 phases)
-- Purpose : Add CHECK constraints, DEFAULT values, NOT NULL,
--           UNIQUE constraints, and indexes to optimize queries.
-- Run this file AFTER 01, 02, 03, and 04.
-- ============================================================
-- FIXES APPLIED:
--   Phase 2: Removed invalid inline comment from PLATFORM_TYPE
--            ALTER statement (was causing a syntax error).
--   Phase 2B (new): Added UNIQUE constraints on community_id
--            for COMMUNITY_MEMBERSHIP, COMMUNITY_COMPETITION,
--            and COMMUNITY_STAFF to enforce the intended 1-to-1
--            relationship and prevent duplicate/double-counted rows.
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- PHASE 1: ADD CHECK CONSTRAINTS & DEFAULT VALUES
-- ============================================================

-- 1.1 Add CHECK to COMMUNITY.community_tier
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_community_tier 
CHECK (`community_tier` IN ('Amateur', 'Semi-Pro', 'Professional', 'Elite'));

-- 1.2 Add CHECK to COMMUNITY.avg_member_age (must be between 0 and 100)
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_avg_member_age 
CHECK (`avg_member_age` BETWEEN 0 AND 100);

-- 1.3 Add CHECK to COMMUNITY.year_founded (between 1900 and current year + 1)
ALTER TABLE `COMMUNITY`
ADD CONSTRAINT chk_year_founded 
CHECK (`year_founded` BETWEEN 1900 AND YEAR(CURDATE()) + 1);

-- 1.4 Add CHECK to COMMUNITY_MEMBERSHIP.member_count and active_players (non-negative)
ALTER TABLE `COMMUNITY_MEMBERSHIP`
ADD CONSTRAINT chk_member_count_nonneg CHECK (`member_count` >= 0),
ADD CONSTRAINT chk_active_players_nonneg CHECK (`active_players` >= 0);

-- 1.5 Add CHECK to COMMUNITY_COMPETITION.tournaments_hosted and top_player_rank
ALTER TABLE `COMMUNITY_COMPETITION`
ADD CONSTRAINT chk_tournaments_hosted_nonneg CHECK (`tournaments_hosted` >= 0),
ADD CONSTRAINT chk_top_player_rank_nonneg CHECK (`top_player_rank` >= 0);

-- 1.6 Add CHECK to COMMUNITY_STAFF columns
ALTER TABLE `COMMUNITY_STAFF`
ADD CONSTRAINT chk_coaching_staff_nonneg CHECK (`coaching_staff` >= 0),
ADD CONSTRAINT chk_content_creators_nonneg CHECK (`content_creators` >= 0);

-- 1.7 Add CHECK to COMMUNITY_SOCIAL_MEDIA.platform_size
ALTER TABLE `COMMUNITY_SOCIAL_MEDIA`
ADD CONSTRAINT chk_platform_size_nonneg CHECK (`platform_size` >= 0);

-- 1.8 Add CHECK to COMMUNITY_GAME.play_designation
ALTER TABLE `COMMUNITY_GAME`
ADD CONSTRAINT chk_play_designation 
CHECK (`play_designation` IN ('Primary', 'Secondary'));

-- 1.9 Set DEFAULT values for some columns (already set in table definition, but ensure)
ALTER TABLE `COMMUNITY_MEMBERSHIP`
ALTER `member_count` SET DEFAULT 0,
ALTER `active_players` SET DEFAULT 0;

ALTER TABLE `COMMUNITY_COMPETITION`
ALTER `tournaments_hosted` SET DEFAULT 0;

ALTER TABLE `COMMUNITY_STAFF`
ALTER `coaching_staff` SET DEFAULT 0,
ALTER `content_creators` SET DEFAULT 0;

ALTER TABLE `COMMUNITY_SOCIAL_MEDIA`
ALTER `platform_size` SET DEFAULT 0;

-- ============================================================
-- PHASE 2: ADD MISSING NOT NULL CONSTRAINTS
-- ============================================================

-- 2.1 COMMUNITY table
ALTER TABLE `COMMUNITY`
MODIFY `community_name` VARCHAR(255) NOT NULL,
MODIFY `year_founded` INT NOT NULL,
MODIFY `avg_member_age` DECIMAL(5,2) NOT NULL,
MODIFY `community_tier` VARCHAR(50) NOT NULL;

-- 2.2 COMMUNITY_MEMBERSHIP (already NOT NULL on community_id, member_count, active_players)
ALTER TABLE `COMMUNITY_MEMBERSHIP`
MODIFY `member_count` INT NOT NULL,
MODIFY `active_players` INT NOT NULL;

-- 2.3 COMMUNITY_COMPETITION
ALTER TABLE `COMMUNITY_COMPETITION`
MODIFY `tournaments_hosted` INT NOT NULL,
MODIFY `top_player_rank` INT NOT NULL;

-- 2.4 COMMUNITY_STAFF
ALTER TABLE `COMMUNITY_STAFF`
MODIFY `coaching_staff` INT NOT NULL,
MODIFY `content_creators` INT NOT NULL;

-- 2.5 COMMUNITY_SOCIAL_MEDIA
ALTER TABLE `COMMUNITY_SOCIAL_MEDIA`
MODIFY `platform_size` INT NOT NULL;

-- 2.6 COMMUNITY_GAME
ALTER TABLE `COMMUNITY_GAME`
MODIFY `play_designation` VARCHAR(100) NOT NULL;

-- 2.7 Lookup tables (ensure names are NOT NULL)
ALTER TABLE `COMMUNITY_REGION`
MODIFY `region_name` VARCHAR(100) NOT NULL;

ALTER TABLE `GAMING_PLATFORM`
MODIFY `platform_name` VARCHAR(100) NOT NULL;

-- From file 01:
ALTER TABLE `PLATFORM_TYPE`
MODIFY `type_name` VARCHAR(100) NOT NULL;

ALTER TABLE `PLATFORM`
MODIFY `primary_platform` VARCHAR(100) NOT NULL;

ALTER TABLE `GENRE`
MODIFY `genre_name` VARCHAR(100) NOT NULL;

ALTER TABLE `GAME`
MODIFY `game_name` VARCHAR(255) NOT NULL;

ALTER TABLE `SOCIAL_PLATFORM`
MODIFY `platform_name` VARCHAR(100) NOT NULL;

ALTER TABLE `LANGUAGE`
MODIFY `language_name` VARCHAR(100) NOT NULL;

ALTER TABLE `COUNTRY`
MODIFY `country_name` VARCHAR(100) NOT NULL;

ALTER TABLE `COUNTRY_LOCATION`
MODIFY `region` VARCHAR(100) NOT NULL;

-- ============================================================
-- PHASE 2B: ADD UNIQUE CONSTRAINTS TO ENFORCE 1-TO-1 RELATIONSHIPS
-- ============================================================

-- 2.8 Prevent multiple rows per community in satellite tables
--     (without these, a community could have duplicate membership/competition/staff
--      rows, causing double-counting in aggregate queries)
ALTER TABLE `COMMUNITY_MEMBERSHIP`
ADD CONSTRAINT uq_membership_community UNIQUE (`community_id`);

ALTER TABLE `COMMUNITY_COMPETITION`
ADD CONSTRAINT uq_competition_community UNIQUE (`community_id`);

ALTER TABLE `COMMUNITY_STAFF`
ADD CONSTRAINT uq_staff_community UNIQUE (`community_id`);

-- ============================================================
-- PHASE 3: ADD INDEXES FOR PERFORMANCE
-- ============================================================

-- 3.1 Indexes on foreign keys (speeds up joins)
CREATE INDEX idx_community_region ON `COMMUNITY`(`region_id`);
CREATE INDEX idx_community_gaming_platform ON `COMMUNITY`(`gaming_platform_id`);
CREATE INDEX idx_community_membership_comm ON `COMMUNITY_MEMBERSHIP`(`community_id`);
CREATE INDEX idx_community_competition_comm ON `COMMUNITY_COMPETITION`(`community_id`);
CREATE INDEX idx_community_staff_comm ON `COMMUNITY_STAFF`(`community_id`);
CREATE INDEX idx_community_social_comm ON `COMMUNITY_SOCIAL_MEDIA`(`community_id`);
CREATE INDEX idx_community_social_platform ON `COMMUNITY_SOCIAL_MEDIA`(`social_platform_id`);
CREATE INDEX idx_community_game_comm ON `COMMUNITY_GAME`(`community_id`);
CREATE INDEX idx_community_game_game ON `COMMUNITY_GAME`(`game_id`);

-- 3.2 Indexes on frequently filtered columns
CREATE INDEX idx_community_tier ON `COMMUNITY`(`community_tier`);
CREATE INDEX idx_community_year ON `COMMUNITY`(`year_founded`);
CREATE INDEX idx_membership_member_count ON `COMMUNITY_MEMBERSHIP`(`member_count`);
CREATE INDEX idx_membership_active_players ON `COMMUNITY_MEMBERSHIP`(`active_players`);
CREATE INDEX idx_competition_tournaments ON `COMMUNITY_COMPETITION`(`tournaments_hosted`);
CREATE INDEX idx_competition_top_rank ON `COMMUNITY_COMPETITION`(`top_player_rank`);

-- 3.3 Indexes on lookup table names (for search)
CREATE INDEX idx_region_name ON `COMMUNITY_REGION`(`region_name`);
CREATE INDEX idx_game_name ON `GAME`(`game_name`);
CREATE INDEX idx_genre_name ON `GENRE`(`genre_name`);
CREATE INDEX idx_country_name ON `COUNTRY`(`country_name`);
CREATE INDEX idx_language_name ON `LANGUAGE`(`language_name`);

-- 3.4 Composite index for common WHERE clauses (tier + region)
CREATE INDEX idx_community_tier_region ON `COMMUNITY`(`community_tier`, `region_id`);

SET FOREIGN_KEY_CHECKS = 1;

-- End of constraints and indexes