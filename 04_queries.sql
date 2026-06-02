
-- 12 SELECT queries: joins, aggregation, filtering, subqueries, window functions.
-- List all communities with their region and primary gaming platform
SELECT 
    c.community_name,
    c.community_tier,
    r.region_name,
    gp.platform_name AS gaming_platform
FROM COMMUNITY c
LEFT JOIN COMMUNITY_REGION r ON c.region_id = r.region_id
LEFT JOIN GAMING_PLATFORM gp ON c.gaming_platform_id = gp.gaming_platform_id
ORDER BY c.community_name
LIMIT 20;

-- Average member count and total tournaments hosted per community tier
SELECT 
    c.community_tier,
    COUNT(*) AS num_communities,
    AVG(m.member_count) AS avg_members,
    SUM(comp.tournaments_hosted) AS total_tournaments
FROM COMMUNITY c
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
GROUP BY c.community_tier
ORDER BY avg_members DESC;

-- Communities with more than 5000 active players and at least 10 tournaments hosted
SELECT 
    c.community_name,
    m.active_players,
    comp.tournaments_hosted
FROM COMMUNITY c
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
WHERE m.active_players > 5000 AND comp.tournaments_hosted >= 10
ORDER BY m.active_players DESC;

-- Show communities, their primary game, genre, and social media reach
SELECT 
    c.community_name,
    g.game_name AS primary_game,
    ge.genre_name,
    MAX(CASE WHEN sm.social_platform_id = 1 THEN sm.platform_size ELSE 0 END) AS discord_size,
    MAX(CASE WHEN sm.social_platform_id = 2 THEN sm.platform_size ELSE 0 END) AS reddit_size
FROM COMMUNITY c
JOIN COMMUNITY_GAME cg ON c.community_id = cg.community_id AND cg.play_designation = 'Primary'
JOIN GAME g ON cg.game_id = g.game_id
JOIN GENRE ge ON g.genre_id = ge.genre_id
LEFT JOIN COMMUNITY_SOCIAL_MEDIA sm ON c.community_id = sm.community_id
GROUP BY c.community_id, c.community_name, g.game_name, ge.genre_name
LIMIT 20;

-- Communities with member count above the average member count of their region
SELECT 
    c.community_name,
    r.region_name,
    m.member_count,
    (SELECT AVG(m2.member_count) 
     FROM COMMUNITY c2 
     JOIN COMMUNITY_MEMBERSHIP m2 ON c2.community_id = m2.community_id
     WHERE c2.region_id = c.region_id) AS region_avg
FROM COMMUNITY c
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
JOIN COMMUNITY_REGION r ON c.region_id = r.region_id
WHERE m.member_count > (
    SELECT AVG(m2.member_count)
    FROM COMMUNITY c2
    JOIN COMMUNITY_MEMBERSHIP m2 ON c2.community_id = m2.community_id
    WHERE c2.region_id = c.region_id
)
ORDER BY m.member_count DESC
LIMIT 20;

-- Communities that have hosted more tournaments than the average of their tier
SELECT 
    c.community_name,
    c.community_tier,
    comp.tournaments_hosted,
    (SELECT AVG(comp2.tournaments_hosted) 
     FROM COMMUNITY_COMPETITION comp2 
     JOIN COMMUNITY c2 ON comp2.community_id = c2.community_id
     WHERE c2.community_tier = c.community_tier) AS tier_avg_tournaments
FROM COMMUNITY c
JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
WHERE comp.tournaments_hosted > (
    SELECT AVG(comp2.tournaments_hosted)
    FROM COMMUNITY_COMPETITION comp2
    JOIN COMMUNITY c2 ON comp2.community_id = c2.community_id
    WHERE c2.community_tier = c.community_tier
)
ORDER BY comp.tournaments_hosted DESC;

-- Regions with average community age > 25 and total members > 500,000
SELECT 
    r.region_name,
    AVG(c.avg_member_age) AS avg_age,
    SUM(m.member_count) AS total_members
FROM COMMUNITY c
JOIN COMMUNITY_REGION r ON c.region_id = r.region_id
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
GROUP BY r.region_name
HAVING AVG(c.avg_member_age) > 25 AND SUM(m.member_count) > 500000
ORDER BY total_members DESC;

-- Rank communities by active players within each tier
SELECT 
    c.community_name,
    c.community_tier,
    m.active_players,
    RANK() OVER (PARTITION BY c.community_tier ORDER BY m.active_players DESC) AS rank_in_tier
FROM COMMUNITY c
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
ORDER BY c.community_tier, rank_in_tier
LIMIT 30;

-- Top 10 communities by total social media presence (Discord + Reddit)
SELECT 
    c.community_name,
    COALESCE(discord.size, 0) + COALESCE(reddit.size, 0) AS total_social,
    discord.size AS discord_size,
    reddit.size AS reddit_size
FROM COMMUNITY c
LEFT JOIN COMMUNITY_SOCIAL_MEDIA discord ON c.community_id = discord.community_id AND discord.social_platform_id = 1
LEFT JOIN COMMUNITY_SOCIAL_MEDIA reddit ON c.community_id = reddit.community_id AND reddit.social_platform_id = 2
ORDER BY total_social DESC
LIMIT 10;

-- For each community, show number of games they play (primary + secondary)
SELECT 
    c.community_name,
    (SELECT COUNT(*) FROM COMMUNITY_GAME cg WHERE cg.community_id = c.community_id) AS total_games_played
FROM COMMUNITY c
ORDER BY total_games_played DESC
LIMIT 20;

-- Communities that have at least one tournament hosted and also have coaching staff
SELECT 
    c.community_name,
    comp.tournaments_hosted,
    s.coaching_staff
FROM COMMUNITY c
JOIN COMMUNITY_COMPETITION comp ON c.community_id = comp.community_id
JOIN COMMUNITY_STAFF s ON c.community_id = s.community_id
WHERE EXISTS (SELECT 1 FROM COMMUNITY_COMPETITION comp2 WHERE comp2.community_id = c.community_id AND comp2.tournaments_hosted > 0)
  AND s.coaching_staff > 0
ORDER BY comp.tournaments_hosted DESC
LIMIT 20;

-- Communities that share the same primary game
SELECT 
    g.game_name,
    c1.community_name AS community_1,
    c2.community_name AS community_2
FROM COMMUNITY_GAME cg1
JOIN COMMUNITY_GAME cg2 ON cg1.game_id = cg2.game_id AND cg1.community_id < cg2.community_id
JOIN GAME g ON cg1.game_id = g.game_id
JOIN COMMUNITY c1 ON cg1.community_id = c1.community_id
JOIN COMMUNITY c2 ON cg2.community_id = c2.community_id
WHERE cg1.play_designation = 'Primary' AND cg2.play_designation = 'Primary'
ORDER BY g.game_name
LIMIT 30;

-- End of queries