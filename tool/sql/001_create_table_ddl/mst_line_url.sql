CREATE TABLE :schema.mst_line_url (
    line_cd INTEGER,
    line_url_str TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_cd)
);
