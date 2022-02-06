CREATE TABLE :schema.str_cafe (
    search_lat TEXT,
    search_lon TEXT,
    search_name TEXT NOT NULL,
    place_id TEXT,
    place_name TEXT,
    place_lat TEXT,
    place_lon TEXT,
    updated_at TIMESTAMP,
    PRIMARY KEY(search_lat, search_lon, search_name, place_id, updated_at)
);
