CREATE TABLE :schema.esp_station (
    line_code INTEGER,
    station_code TEXT,
    station_name TEXT NOT NULL,
    station_yomi TEXT,
    latitude TEXT NOT NULL,
    longitude TEXT NOT NULL,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_code, station_code)
);
