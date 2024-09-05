

-- Loading data from local .csv files acquired from Kaggle
-- https://www.kaggle.com/datasets/davidcariboo/player-scores/data
COPY appearances
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\appearances.csv'
DELIMITER ',' CSV HEADER;


COPY club_games
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\club_games.csv'
DELIMITER ',' CSV HEADER;


COPY clubs
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\clubs.csv'
DELIMITER ',' CSV HEADER;


COPY competitions
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\competitions.csv'
DELIMITER ',' CSV HEADER;


COPY game_events
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\game_events.csv'
DELIMITER ',' CSV HEADER;


COPY game_lineups
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\game_lineups.csv'
DELIMITER ',' CSV HEADER;


COPY games
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\games.csv'
DELIMITER ',' CSV HEADER;


COPY player_valuations
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\player_valuations.csv'
DELIMITER ',' CSV HEADER;


COPY players
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\players.csv'
DELIMITER ',' CSV HEADER;


COPY transfers
FROM 'C:\Users\oskar\OneDrive\Old OneDrive\Sharing\SQL Project\Football Data\transfers.csv'
DELIMITER ',' CSV HEADER;