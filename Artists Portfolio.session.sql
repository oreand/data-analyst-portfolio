-- Initialize table to import .csv into
CREATE TABLE artists (
    name VARCHAR(255),  -- Name of artist(band, group or collaboration)
    playcount BIGINT,   -- Number of total playcounts per artist
    listeners BIGINT,   -- Number of unique listeners for artist
    mbid VARCHAR(255),  -- MusicBrainz Identifier, not all artists have one
    url VARCHAR(255),   -- URL for each artists last.fm page
    tags VARCHAR(255)   -- Top user generated tag for each artist on last.fm
);

-- Load data from .csv file into table
LOAD DATA INFILE "artists.csv" 
INTO TABLE artists
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Generic select all statement for table inspection
SELECT * FROM artists;

-- Checking for duplicate rows
SELECT name, COUNT(name)
FROM artists
GROUP BY name
HAVING COUNT(name) > 1;

-- Identifying duplicate rows and deleting the duplicate row from table
DELETE FROM artists
WHERE name IN (
   SELECT name FROM (
      SELECT name, ROW_NUMBER() OVER (
         PARTITION BY name
         ORDER BY name
      )
      AS row_num
      FROM artists
   ) AS temp
   WHERE row_num > 1
);

-- Cleaning up the string values for tags to remove [] and ''
UPDATE artists
SET tags = REPLACE(tags, '[\'','');

UPDATE artists
SET tags = REPLACE(tags, '\']','');




-- Finding artists with highest playcount in table
SELECT name, playcount, listeners
FROM artists
ORDER BY playcount DESC;

-- Finding artists with most amount of individual listeners in table
SELECT name, playcount, listeners
FROM artists
ORDER BY listeners DESC;

-- Finding the highest ratio of listeners to playcount by artist
SELECT name,
   playcount,
   listeners,
   (listeners / playcount) AS playcount_listener_ratio
FROM artists
ORDER BY playcount_listener_ratio DESC;

-- Ratio is interesting information, adding permanently to table
ALTER TABLE artists
ADD COLUMN listener_playcount_ratio FLOAT;   -- Low ratio = more playcounts per unique listener, max = 1, min = 0

UPDATE artists
SET listener_playcount_ratio = ROUND((listeners / playcount), 3);




-- ALTER TABLE artists
-- DROP COLUMN listener_playcount_ratio;


-- Find most popular artists
SELECT *
FROM artists
ORDER BY playcount DESC;

-- Number of unique artists per tag
SELECT tags,
   COUNT(name) as number_of_unique_artists
FROM artists
GROUP BY tags
ORDER BY number_of_unique_artists DESC;

-- Number of total listeners per tag 
SELECT tags,
   SUM(listeners) AS total_listeners
FROM artists
GROUP BY tags
ORDER BY SUM(listeners) DESC;

-- Average listener to playcount ratio for each tag
SELECT tags,
   ROUND(AVG(listener_playcount_ratio), 3) AS average_l_p_ratio
FROM artists
GROUP BY tags
ORDER BY average_l_p_ratio DESC;

-- Listener to playcount ratio sorted from low to high
SELECT name,
   playcount,
   listeners,
   listener_playcount_ratio
FROM artists
ORDER BY listener_playcount_ratio;

-- Finding average playcounts for each for each tenth percentile of ratio
SELECT ROUND(listener_playcount_ratio, 1) AS listener_playcount_ratio_percentile,
   ROUND(AVG(playcount), 0) as playcounts
FROM artists
GROUP BY listener_playcount_ratio_percentile
ORDER BY listener_playcount_ratio_percentile;