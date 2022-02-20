CREATE TABLE :schema.mst_numbering_info (
    station_cd INTEGER,
    new_line_cd INTEGER,
    numbering TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(station_cd, new_line_cd)
);
