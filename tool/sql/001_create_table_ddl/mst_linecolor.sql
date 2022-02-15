CREATE TABLE :schema.mst_linecolor (
    line_cd INTEGER,
    line_color_cd TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_cd)
);
