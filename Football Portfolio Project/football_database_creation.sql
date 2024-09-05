
-- Setting up tables and primary keys
CREATE TABLE appearances
(
    appearance_id BIGINT,
    game_id INT,
    player_id INT,
    player_club_id INT,
    player_current_club_id INT,
    dt DATE,
    player_name TEXT,
    competition_id TEXT,
    yellow_cards INT,
    red_cards INT,
    goals INT,
    assists INT,
    minutes_played INT,
    PRIMARY KEY(appearance_id)
);


CREATE TABLE club_games
(
    game_id INT,
    club_id INT,
    own_goals INT,
    own_position INT,
    own_manager_name TEXT,
    opponent_id INT,
    opponent_goals INT,
    opponent_position INT,
    opponent_manager_name TEXT,
    hosting TEXT,
    is_win BOOLEAN
);


CREATE TABLE clubs
(
    club_id INT,
    club_code TEXT,
    club_name TEXT,
    domestic_competition_id TEXT,
    total_market_value TEXT,
    squad_size INT,
    average_age NUMERIC,
    foreigners_number INT,
    foreigners_percentage NUMERIC,
    national_team_players INT,
    stadium_name TEXT,
    stadium_seats INT,
    net_transfer_record TEXT,
    coach_name TEXT,
    last_season INT,
    filename TEXT,
    url TEXT,
    PRIMARY KEY(club_id) 
);


CREATE TABLE competitions
(
    competition_id TEXT,
    competition_code TEXT,
    competition_name TEXT,
    sub_type TEXT,
    competition_type TEXT,
    country_id INT,
    country_name TEXT,
    domestic_league_code TEXT,
    confederation TEXT,
    url TEXT,
    is_major_national_league BOOLEAN,
    PRIMARY KEY(competition_id)
);


CREATE TABLE game_events
(
    game_event_id TEXT,
    dt DATE,
    game_id INT,
    minute INT,
    event_type TEXT,
    club_id INT,
    player_id INT,
    event_description TEXT,
    player_in_id INT,
    player_assist_id INT,
    PRIMARY KEY(game_event_id)
);


CREATE TABLE game_lineups
(
    game_lineups_id TEXT,
    dt DATE,
    game_id INT,
    player_id INT,
    club_id INT,
    player_name TEXT,
    lineup_type TEXT,
    position TEXT,
    player_number TEXT,
    team_captain BOOLEAN,
    PRIMARY KEY(game_lineups_id)
);


CREATE TABLE games
(
    game_id INT,
    competition_id TEXT,
    season INT,
    game_round TEXT,
    dt DATE,
    home_club_id INT,
    away_club_id INT,
    home_club_goals INT,
    away_club_goals INT,
    home_club_position INT,
    away_club_position INT,
    home_club_manager_name TEXT,
    away_club_manager_name TEXT,
    stadium TEXT,
    attendance INT,
    referee TEXT,
    url TEXT,
    home_club_formation TEXT,
    away_club_formation TEXT,
    home_club_name TEXT,
    away_club_name TEXT,
    aggregate_score TEXT,
    competition_type TEXT,
    PRIMARY KEY(game_id)
);


CREATE TABLE player_valuations
(
    player_id INT,
    dt DATE,
    market_value_in_eur INT,
    current_club_id INT,
    player_club_domestic_competition_id TEXT
);


CREATE TABLE players
(
    player_id INT,
    first_name TEXT,
    last_name TEXT,
    full_name TEXT,
    last_season INT,
    current_club_id INT,
    player_code TEXT,
    country_of_birth TEXT,
    city_of_birth TEXT,
    country_of_citizenship TEXT,
    date_of_birth DATE,
    sub_position TEXT,
    position TEXT,
    foot TEXT,
    height_in_cm INT,
    contract_expiration_date TIMESTAMP,
    agent_name TEXT,
    image_url TEXT,
    url TEXT,
    current_club_domestic_competition_id TEXT,
    current_club_name TEXT,
    market_value_in_eur INT,
    highest_market_value_in_eur INT,
    PRIMARY KEY(player_id)
);


CREATE TABLE transfers
(
    player_id INT,
    transfer_date DATE,
    transfer_season TEXT,
    from_club_id INT,
    to_club_id INT,
    from_club_name TEXT,
    to_club_name TEXT,
    transfer_fee NUMERIC,
    market_value_in_eur NUMERIC,
    player_name TEXT
);




-- Adding foreign keys to tables
ALTER TABLE appearances
ADD FOREIGN KEY(game_id) REFERENCES public.games(game_id),
ADD FOREIGN KEY(player_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(player_current_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(competition_id) REFERENCES public.competitions(competition_id);


ALTER TABLE club_games
ADD FOREIGN KEY(game_id) REFERENCES public.games(game_id),
ADD FOREIGN KEY(club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(opponent_id) REFERENCES public.clubs(club_id);


ALTER TABLE clubs
ADD FOREIGN KEY(domestic_competition_id) REFERENCES public.competitions(competition_id);


ALTER TABLE game_events
ADD FOREIGN KEY(game_id) REFERENCES public.games(game_id),
ADD FOREIGN KEY(club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(player_id) REFERENCES public.players(player_id),
ADD FOREIGN KEY(player_in_id) REFERENCES public.players(player_id),
ADD FOREIGN KEY(player_assist_id) REFERENCES public.players(player_id);


ALTER TABLE game_lineups
ADD FOREIGN KEY(game_id) REFERENCES public.games(game_id),
ADD FOREIGN KEY(player_id) REFERENCES public.players(player_id),
ADD FOREIGN KEY(club_id) REFERENCES public.clubs(club_id);


ALTER TABLE games
ADD FOREIGN KEY(competition_id) REFERENCES public.competitions(competition_id),
ADD FOREIGN KEY(home_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(away_club_id) REFERENCES public.clubs(club_id);


ALTER TABLE player_valuations
ADD FOREIGN KEY(player_id) REFERENCES public.players(player_id),
ADD FOREIGN KEY(current_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(player_club_domestic_competition_id) REFERENCES public.competitions(competition_id);


ALTER TABLE players
ADD FOREIGN KEY(current_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(current_club_domestic_competition_id) REFERENCES public.competitions(competition_id);


ALTER TABLE transfers
ADD FOREIGN KEY(player_id) REFERENCES public.players(player_id),
ADD FOREIGN KEY(from_club_id) REFERENCES public.clubs(club_id),
ADD FOREIGN KEY(to_club_id) REFERENCES public.clubs(club_id);

