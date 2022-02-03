CREATE TABLE :schema.tmp_unique_fetch_lineinfo (
    lon TEXT,
    lat TEXT,
    target_station_cd TEXT NOT NULL,
    target_station_name TEXT NOT NULL,
    PRIMARY KEY(lon, lat)
);
