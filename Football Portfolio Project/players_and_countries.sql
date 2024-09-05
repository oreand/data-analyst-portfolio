
-- Query to rank countries by the number of players born there
SELECT
    country_of_birth,
    COUNT(country_of_birth) AS total_players
FROM players
GROUP BY country_of_birth
ORDER BY total_players DESC;


-- Query to rank countries by the number of player that have a citizenship there
SELECT
    country_of_citizenship,
    COUNT(country_of_citizenship) AS total_players
FROM players
GROUP BY country_of_citizenship
ORDER BY total_players DESC;


-- Query to rank countries by goals scored by players born in the country
SELECT
    p.country_of_birth,
    COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals
FROM players p
LEFT JOIN game_events g ON p.player_id = g.player_id
WHERE p.country_of_birth IS NOT NULL
GROUP BY p.country_of_birth
ORDER BY total_goals DESC;


-- Query to rank countries by goals scored by players with citizenship in the country
SELECT
    p.country_of_citizenship,
    COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals
FROM players p
LEFT JOIN game_events g ON p.player_id = g.player_id
GROUP BY p.country_of_citizenship
ORDER BY total_goals DESC;


-- Query that find the difference between goals scored by country of birth and citizenship
-- The difference highlights the goals scored by players who have changed federation from where they were born and where they are now citizens
-- Large positive values show countries that have gained goals by players that have joined their federation
WITH birth_country AS
(
    SELECT
        p.country_of_birth,
        COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals_by_birth
    FROM players p
    LEFT JOIN game_events g ON p.player_id = g.player_id
    GROUP BY p.country_of_birth
),
citizenship_country AS
(
    SELECT
        p.country_of_citizenship,
        COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals_by_citizenship
    FROM players p
    LEFT JOIN game_events g ON p.player_id = g.player_id
    GROUP BY p.country_of_citizenship
)
SELECT 
    c.country_of_citizenship,
    c.total_goals_by_citizenship - b.total_goals_by_birth AS goal_difference,
    c.total_goals_by_citizenship,
    b.total_goals_by_birth
FROM birth_country b
JOIN citizenship_country c ON c.country_of_citizenship = b.country_of_birth
GROUP BY c.country_of_citizenship, c.total_goals_by_citizenship, b.total_goals_by_birth
ORDER BY goal_difference DESC;

-- Large negative values show countries that have lost goals to players that have chosen to join a different federation
-- This suggests that the country produces a large amount of talented players that cannot be accomodated by the national team, leading to players choosing a different federation to represent
-- These numbers are heavily influenced by how many players there are that qualify to play for multiple federations
-- Database can be augmented to include which federations each player qualify to play for to expand the analysis
WITH birth_country AS
(
    SELECT
        p.country_of_birth,
        COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals_by_birth
    FROM players p
    LEFT JOIN game_events g ON p.player_id = g.player_id
    GROUP BY p.country_of_birth
),
citizenship_country AS
(
    SELECT
        p.country_of_citizenship,
        COUNT(CASE WHEN g.event_type = 'Goals' THEN 1 END) AS total_goals_by_citizenship
    FROM players p
    LEFT JOIN game_events g ON p.player_id = g.player_id
    GROUP BY p.country_of_citizenship
)
SELECT 
    c.country_of_citizenship,
    c.total_goals_by_citizenship - b.total_goals_by_birth AS goal_difference,
    c.total_goals_by_citizenship,
    b.total_goals_by_birth
FROM birth_country b
JOIN citizenship_country c ON c.country_of_citizenship = b.country_of_birth
GROUP BY c.country_of_citizenship, c.total_goals_by_citizenship, b.total_goals_by_birth
ORDER BY goal_difference;

