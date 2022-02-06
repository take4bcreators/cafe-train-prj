CREATE TABLE :schema.gmp_cafe (
    search_lat TEXT,
    search_lon TEXT,
    search_name TEXT NOT NULL,
    place_id TEXT,
    place_name TEXT,
    place_lat TEXT,
    place_lon TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(search_lat, search_lon)
);
