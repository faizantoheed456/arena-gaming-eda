-- FILE: 04_queries_intermediate.sql
-- Run this file after 01, 02, and 03 have been executed.

-- Query 1: Two-table INNER JOIN with filter and sort
-- Shows top 10 communities by active players (over 500)
SELECT 
    c.community_name,
    c.community_tier,
    m.member_count,
    m.active_players
FROM COMMUNITY c
INNER JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
WHERE m.active_players > 500
ORDER BY m.active_players DESC
LIMIT 10;

-- Query 2: LEFT JOIN to find missing data
-- Lists communities that have no region assigned
SELECT 
    c.community_name,
    r.region_name
FROM COMMUNITY c
LEFT JOIN COMMUNITY_REGION r ON c.region_id = r.region_id
WHERE r.region_name IS NULL;

-- Query 3: GROUP BY with COUNT and AVG
-- For each tier, counts communities and averages members/active players
SELECT 
    c.community_tier,
    COUNT(*) AS total_communities,
    AVG(m.member_count) AS avg_members,
    AVG(m.active_players) AS avg_active
FROM COMMUNITY c
INNER JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
GROUP BY c.community_tier
ORDER BY avg_members DESC;

-- Query 4: GROUP BY with HAVING (filter after aggregation)
-- Tiers where total tournaments hosted exceed 100
SELECT 
    c.community_tier,
    COUNT(*) AS num_communities,
    SUM(comp.tournaments_hosted) AS total_tournaments
FROM COMMUNITY c
INNER JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
GROUP BY c.community_tier
HAVING SUM(comp.tournaments_hosted) > 100;

-- Query 5: Simple subquery in WHERE (uncorrelated)
-- Communities with average member age above overall average
SELECT 
    community_name,
    year_founded,
    avg_member_age
FROM COMMUNITY
WHERE avg_member_age > (SELECT AVG(avg_member_age) FROM COMMUNITY);

-- Query 6: Subquery in SELECT (scalar correlated)
-- Shows how many games each community plays (top 10 by game count)
SELECT 
    c.community_name,
    c.community_tier,
    (SELECT COUNT(*) 
     FROM COMMUNITY_GAME cg 
     WHERE cg.community_id = c.community_id) AS number_of_games_played
FROM COMMUNITY c
ORDER BY number_of_games_played DESC
LIMIT 10;

-- Query 7: Basic window function – ROW_NUMBER (no PARTITION)
-- Ranks all communities by member count (largest first)
SELECT 
    community_name,
    member_count,
    ROW_NUMBER() OVER (ORDER BY member_count DESC) AS rank_by_size
FROM COMMUNITY c
INNER JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
ORDER BY rank_by_size
LIMIT 10;

-- Query 8: Window function with PARTITION BY
-- Ranks communities by active players within each tier
SELECT 
    c.community_name,
    c.community_tier,
    m.active_players,
    RANK() OVER (PARTITION BY c.community_tier ORDER BY m.active_players DESC) AS rank_in_tier
FROM COMMUNITY c
INNER JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
ORDER BY c.community_tier, rank_in_tier
LIMIT 30;

-- Query 9: Joining four tables with a condition
-- Shows each community’s primary game and its genre
SELECT 
    c.community_name,
    g.game_name AS primary_game,
    ge.genre_name
FROM COMMUNITY c
INNER JOIN COMMUNITY_GAME cg ON c.community_id = cg.community_id AND cg.play_designation = 'Primary'
INNER JOIN GAME g ON cg.game_id = g.game_id
INNER JOIN GENRE ge ON g.genre_id = ge.genre_id
LIMIT 20;

-- Query 10: Aggregate with multiple joins (region summary)
-- For each region: number of communities, total members, avg tournaments
SELECT 
    r.region_name,
    COUNT(DISTINCT c.community_id) AS num_communities,
    SUM(m.member_count) AS total_members_in_region,
    AVG(comp.tournaments_hosted) AS avg_tournaments_per_community
FROM COMMUNITY c
INNER JOIN COMMUNITY_REGION r ON c.region_id = r.region_id
INNER JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
INNER JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
GROUP BY r.region_name
ORDER BY total_members_in_region DESC
LIMIT 10;

-- Query 11: Using EXISTS to find communities with both tournaments and coaching staff
-- Shows communities that have hosted at least one tournament AND have coaching staff
SELECT 
    c.community_name,
    comp.tournaments_hosted,
    s.coaching_staff
FROM COMMUNITY c
INNER JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
INNER JOIN COMMUNITY_STAFF s ON c.community_id = s.community_id
WHERE EXISTS (SELECT 1 FROM COMMUNITY_COMPETITION comp2 
              WHERE comp2.community_id = c.community_id AND comp2.tournaments_hosted > 0)
  AND s.coaching_staff > 0
ORDER BY comp.tournaments_hosted DESC
LIMIT 15;

-- Query 12: Self-join to find pairs of communities that play the same primary game
-- Shows game name and two community names (alphabetical order, no duplicates)
SELECT 
    g.game_name,
    c1.community_name AS community_1,
    c2.community_name AS community_2
FROM COMMUNITY_GAME cg1
INNER JOIN COMMUNITY_GAME cg2 ON cg1.game_id = cg2.game_id AND cg1.community_id < cg2.community_id
INNER JOIN GAME g ON cg1.game_id = g.game_id
INNER JOIN COMMUNITY c1 ON cg1.community_id = c1.community_id
INNER JOIN COMMUNITY c2 ON cg2.community_id = c2.community_id
WHERE cg1.play_designation = 'Primary' AND cg2.play_designation = 'Primary'
ORDER BY g.game_name
LIMIT 25;

-- End of 12 intermediate queries