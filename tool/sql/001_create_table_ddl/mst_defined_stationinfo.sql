CREATE TABLE :schema.mst_defined_stationinfo (
    station_cd INTEGER,
    def_line_cd INTEGER,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(station_cd, def_line_cd)
);
