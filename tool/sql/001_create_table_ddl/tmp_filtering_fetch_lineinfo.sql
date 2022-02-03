CREATE TABLE :schema.tmp_filtering_fetch_lineinfo (
    station_cd INTEGER,
    station_g_cd INTEGER NOT NULL,
    station_name TEXT NOT NULL,
    line_cd INTEGER,
    lon TEXT,
    lat TEXT,
    e_status INTEGER,
    PRIMARY KEY(station_cd, line_cd)
);
