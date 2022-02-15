CREATE TABLE :schema.tmp_merge_defined_stationinfo (
    station_cd INTEGER,
    station_g_cd INTEGER NOT NULL,
    station_name TEXT NOT NULL,
    station_name_k TEXT,
    station_name_r TEXT,
    new_line_cd INTEGER,
    origin_line_cd INTEGER,
    pref_cd INTEGER,
    post TEXT,
    add TEXT,
    lon TEXT,
    lat TEXT,
    open_ymd TEXT,
    close_ymd TEXT,
    e_status INTEGER,
    e_sort INTEGER,
    PRIMARY KEY(station_cd, new_line_cd)
);
