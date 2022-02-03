CREATE TABLE :schema.ejp_join (
    line_cd INTEGER,
    station_cd1 INTEGER,
    station_cd2 INTEGER,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_cd, station_cd1, station_cd2)
);
