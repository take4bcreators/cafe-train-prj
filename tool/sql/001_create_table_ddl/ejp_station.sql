CREATE TABLE :schema.ejp_station (
    station_cd INTEGER,
    station_g_cd INTEGER NOT NULL,
    station_name TEXT NOT NULL,
    station_name_k TEXT,
    station_name_r TEXT,
    line_cd INTEGER,
    pref_cd INTEGER,
    post TEXT,
    add TEXT,
    lon TEXT,
    lat TEXT,
    open_ymd TEXT,
    close_ymd TEXT,
    e_status INTEGER,
    e_sort INTEGER,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(station_cd, line_cd)
);
