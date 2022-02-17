CREATE TABLE :schema.tmp_add_search_check (
    search_lat TEXT,
    search_lon TEXT,
    target_station_name TEXT,
    search_name TEXT,
    place_id TEXT,
    place_name TEXT,
    place_lat TEXT,
    place_lon TEXT,
    search_check_flag INTEGER,
    PRIMARY KEY(search_lat, search_lon, search_name, place_id)
);
