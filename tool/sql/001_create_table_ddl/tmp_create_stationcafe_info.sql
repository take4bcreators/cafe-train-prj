CREATE TABLE :schema.tmp_create_stationcafe_info (
    search_lat TEXT,
    search_lon TEXT,
    target_station_name TEXT,
    cflag01 INTEGER,
    cflag02 INTEGER,
    cflag03 INTEGER,
    cflag04 INTEGER,
    cflag05 INTEGER,
    cflag06 INTEGER,
    cflag07 INTEGER,
    cflag08 INTEGER,
    cflag09 INTEGER,
    cflag10 INTEGER,
    cflag11 INTEGER,
    cflag12 INTEGER,
    cflag13 INTEGER,
    cflag14 INTEGER,
    cflag15 INTEGER,
    cflag16 INTEGER,
    cflag17 INTEGER,
    cflag18 INTEGER,
    cflag19 INTEGER,
    cflag20 INTEGER,
    cflag21 INTEGER,
    cflag22 INTEGER,
    cflag23 INTEGER,
    cflag24 INTEGER,
    cflag25 INTEGER,
    cflag26 INTEGER,
    cflag27 INTEGER,
    cflag28 INTEGER,
    cflag29 INTEGER,
    cflag30 INTEGER,
    cflag31 INTEGER,
    cflag32 INTEGER,
    cflag33 INTEGER,
    cflag34 INTEGER,
    cflag35 INTEGER,
    cflag36 INTEGER,
    cflag37 INTEGER,
    cflag38 INTEGER,
    cflag39 INTEGER,
    cflag40 INTEGER,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(search_lat, search_lon)
);