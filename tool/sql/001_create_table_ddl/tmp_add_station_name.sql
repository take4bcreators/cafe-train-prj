CREATE TABLE :schema.tmp_add_station_name (
    search_lat TEXT,
    search_lon TEXT,
    target_station_name TEXT,
    search_name TEXT,
    place_id TEXT,
    place_name TEXT,
    PRIMARY KEY(search_lat, search_lon, search_name, place_id)
);
