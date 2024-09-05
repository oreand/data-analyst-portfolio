
-- Query to find the club with the most wins
SELECT
    c.club_name,
    COUNT(CASE WHEN cg.is_win = TRUE THEN 1 END) AS total_wins,
    COUNT(cg.club_id) AS total_games
FROM club_games cg
LEFT JOIN clubs c ON cg.club_id = c.club_id
WHERE c.club_name IS NOT NULL
GROUP BY c.club_name
ORDER BY total_wins DESC;


-- Query to find the clubs with the highest win rate
SELECT
    c.club_name,
    COUNT(CASE WHEN cg.is_win = TRUE THEN 1 END) AS total_wins,
    COUNT(cg.club_id) AS total_games,
    ROUND((COUNT(CASE WHEN cg.is_win = TRUE THEN 1 END) * 1.0) / COUNT(cg.club_id), 2) AS win_rate
FROM club_games cg
LEFT JOIN clubs c ON cg.club_id = c.club_id
WHERE c.club_name IS NOT NULL
GROUP BY c.club_name
ORDER BY win_rate DESC, total_wins DESC;


-- Query to find the teams with the highest win rate when playing at home
SELECT
    c.club_name AS club_name,
    ROUND((COUNT(CASE WHEN g.home_club_goals > g.away_club_goals THEN 1 END) * 1.0) / COUNT(g.home_club_id), 2) AS home_win_rate
FROM games g 
LEFT JOIN clubs c ON g.home_club_id = c.club_id
WHERE c.club_name IS NOT NULL
GROUP BY c.club_name
ORDER BY home_win_rate DESC;


-- Query to find which teams have the highest difference in home and away win rates
-- Expect clubs with higher overall win rates to be closer to an even win rate difference between home and away games
-- Positive number shows higher away win rate than home win rate
WITH away_win_rates AS 
(
    SELECT
        c.club_name AS club_name,
        ROUND((COUNT(CASE WHEN g.home_club_goals < g.away_club_goals THEN 1 END) * 1.0) / COUNT(g.away_club_id), 2) AS away_win_rate
    FROM games g 
    LEFT JOIN clubs c ON g.away_club_id = c.club_id
    WHERE c.club_name IS NOT NULL
    GROUP BY c.club_name
),
home_win_rates AS
(
    SELECT
        c.club_name AS club_name,
        ROUND((COUNT(CASE WHEN g.home_club_goals > g.away_club_goals THEN 1 END) * 1.0) / COUNT(g.home_club_id), 2) AS home_win_rate
    FROM games g 
    LEFT JOIN clubs c ON g.home_club_id = c.club_id
    WHERE c.club_name IS NOT NULL
    GROUP BY c.club_name
)
SELECT
    a.club_name AS club_name,
    a.away_win_rate - h.home_win_rate AS win_rate_difference,
    h.home_win_rate,
    a.away_win_rate
FROM away_win_rates a
LEFT JOIN home_win_rates h ON a.club_name = h.club_name
GROUP BY a.club_name, a.away_win_rate, h.home_win_rate
ORDER BY win_rate_difference DESC;

-- Negative number shows higher home win rate than away win rate
-- Expect the majority of clubs to have a higher win rate at home
WITH away_win_rates AS 
(
    SELECT
        c.club_name AS club_name,
        ROUND((COUNT(CASE WHEN g.home_club_goals < g.away_club_goals THEN 1 END) * 1.0) / COUNT(g.away_club_id), 2) AS away_win_rate
    FROM games g 
    LEFT JOIN clubs c ON g.away_club_id = c.club_id
    WHERE c.club_name IS NOT NULL
    GROUP BY c.club_name
),
home_win_rates AS
(
    SELECT
        c.club_name AS club_name,
        ROUND((COUNT(CASE WHEN g.home_club_goals > g.away_club_goals THEN 1 END) * 1.0) / COUNT(g.home_club_id), 2) AS home_win_rate
    FROM games g 
    LEFT JOIN clubs c ON g.home_club_id = c.club_id
    WHERE c.club_name IS NOT NULL
    GROUP BY c.club_name
)
SELECT
    a.club_name AS club_name,
    a.away_win_rate - h.home_win_rate AS win_rate_difference,
    h.home_win_rate,
    a.away_win_rate
FROM away_win_rates a
LEFT JOIN home_win_rates h ON a.club_name = h.club_name
GROUP BY a.club_name, a.away_win_rate, h.home_win_rate
ORDER BY win_rate_difference;


