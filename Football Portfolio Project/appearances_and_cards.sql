
-- Query to find players with the most appearances and their average minutes per appearance
SELECT 
    player_name, 
    COUNT(player_id) AS total_number_of_appearances, 
    SUM(minutes_played) AS total_minutes_played,
    ROUND(AVG(minutes_played), 0) AS average_minutes_per_appearance
FROM appearances
GROUP BY player_name
ORDER BY total_number_of_appearances DESC
LIMIT 100;


-- Query to find player with most goal involvements, with a breakdown of goals and assists
SELECT
    player_name,
    SUM(goals) + SUM(assists) AS total_goal_involvements,
    SUM(goals) AS total_goals_scored,
    SUM(assists) AS total_assists
FROM appearances
GROUP BY player_name
ORDER BY total_goal_involvements DESC
LIMIT 100;



-- Query to rank players by total goal involvements per 90 minutes played
-- Players with less than 5000 minutes played will be excluded, ~60 games played
SELECT
    player_name,
    ROUND(((SUM(goals) + SUM(assists)) * 1.0 / (SUM(minutes_played) / 90)) , 2) AS involvements_per_90,
    ROUND((SUM(minutes_played) * 1.0) / 90, 2) AS full_appearances,
    SUM(goals) + SUM(assists) AS total_goal_involvements,
    SUM(goals) AS total_goals_scored,
    SUM(assists) AS total_assists
FROM appearances
GROUP BY player_name
HAVING SUM(minutes_played) > 5000
ORDER BY involvements_per_90 DESC
LIMIT 100;


-- Query to find player with most cards received, with a breakdown of red and yellow cards receieved, and cards per appearance
SELECT
    player_name,
    SUM(yellow_cards) + SUM(red_cards) AS total_cards_received,
    SUM(red_cards) AS total_red_cards_received,
    SUM(yellow_cards) AS total_yellow_cards_received,
    COUNT(player_id) AS appearances,
    ROUND(((SUM(yellow_cards) + SUM(red_cards)) * 1.0) / COUNT(player_id), 2) AS cards_per_appearance
FROM appearances
GROUP BY player_name
ORDER BY total_cards_received DESC
LIMIT 100;


-- Query to find players that have more cards received than total number of appearances
SELECT
    player_name,
    SUM(yellow_cards) + SUM(red_cards) AS total_cards_received,
    COUNT(player_id) AS total_number_of_appearances
FROM appearances
GROUP BY player_name
HAVING COUNT(player_id) < (SUM(yellow_cards) + SUM(red_cards))
ORDER BY total_cards_received DESC;


-- Query to find how many cards were given for each year
-- Expect 2012 and 2024 to have roughly half the number of cards than other years as only half of those years are captured
SELECT
    EXTRACT (YEAR FROM dt) AS year,
    SUM(yellow_cards) + SUM(red_cards) AS total_cards_given
FROM appearances
GROUP BY year
ORDER BY total_cards_given DESC;

