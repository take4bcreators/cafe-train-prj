CREATE TABLE :schema.esp_station (
    line_code TEXT,
    station_code TEXT,
    station_name TEXT,
    station_yomi TEXT,
    latitude TEXT,
    longitude TEXT,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_code, station_code)
);
