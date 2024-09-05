
-- Query to check for duplicates in appearances
-- Expect no duplicates
SELECT
    appearance_id,
    COUNT(appearance_id)
FROM appearances
GROUP BY appearance_id
HAVING COUNT(appearance_id) > 1;


-- Query to check for duplicates or missing data in club_games
-- Expect to find exactly two entries for each game_id, as there are always two teams in one game
SELECT
    game_id,
    COUNT(game_id)
FROM club_games
GROUP BY game_id
HAVING COUNT(game_id) < 2 OR COUNT(game_id) > 2;

-- Query to find all duplicate rows, returns 68499 rows
SELECT
    game_id,
    COUNT(game_id)
FROM club_games
GROUP BY game_id
HAVING COUNT(game_id) = 2;

-- Query to show full table, returns 136998 rows
-- 68499 * 2 = 136998, again confirming two entries for each game played
SELECT * FROM club_games;


-- Query to check for duplicates in clubs
-- Expect no duplicates
SELECT
    club_id,
    COUNT(club_id)
FROM clubs
GROUP BY club_id
HAVING COUNT(club_id) > 1;


-- Query to check for duplicates in competitions
-- Expect no duplicates
SELECT
    competition_id,
    COUNT(competition_id)
FROM competitions
GROUP BY competition_id
HAVING COUNT(competition_id) > 1;


-- Query to check for duplicates in game_events
-- Expect no duplicates
SELECT
    game_event_id,
    COUNT(game_event_id)
FROM game_events
GROUP BY game_event_id
HAVING COUNT(game_event_id) > 1;


-- Query to check for duplicates in game_lineups
-- Expect no duplicates
SELECT
    game_lineups_id,
    COUNT(game_lineups_id)
FROM game_lineups
GROUP BY game_lineups_id
HAVING COUNT(game_lineups_id) > 1;


-- Query to check for duplicates in games
-- Expect no duplicates
SELECT
    game_id,
    COUNT(game_id)
FROM games
GROUP BY game_id
HAVING COUNT(game_id) > 1;


-- Query to check for duplicates in player_valuations
-- Expect no more than one entry per player per date
SELECT
    player_id,
    dt,
    COUNT(*)
FROM player_valuations
GROUP BY player_id, dt
HAVING COUNT(*) > 1;


-- Query to check for duplicates in players
-- Expect no duplicates
SELECT
    player_id,
    COUNT(player_id)
FROM players
GROUP BY player_id
HAVING COUNT(player_id) > 1;


-- Query to check for duplicates in transfers
-- Expect players may move more than once on the same day, but never to the same club twice
SELECT
    player_id,
    transfer_date,
    to_club_id,
    COUNT(*)
FROM transfers
GROUP BY player_id, transfer_date, to_club_id
HAVING COUNT(*) > 1;