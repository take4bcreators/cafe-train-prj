CREATE TABLE :schema.tmp_add_include_flag (
    search_lat TEXT,
    search_lon TEXT,
    target_station_name TEXT,
    search_name TEXT,
    place_id TEXT,
    place_name TEXT,
    place_lat TEXT,
    place_lon TEXT,
    search_check_flag INTEGER NOT NULL,
    distance_meter DOUBLE PRECISION NOT NULL,
    distance_check_flag INTEGER NOT NULL,
    include_flag INTEGER NOT NULL,
    PRIMARY KEY(search_lat, search_lon, search_name, place_id)
);
