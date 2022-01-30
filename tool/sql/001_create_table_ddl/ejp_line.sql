CREATE TABLE :schema.ejp_line (
    line_cd INTEGER,
    company_cd INTEGER NOT NULL,
    line_name TEXT NOT NULL,
    line_name_k TEXT,
    line_name_h TEXT,
    line_color_c TEXT,
    line_color_t TEXT,
    line_type INTEGER,
    lon TEXT,
    lat TEXT,
    zoom INTEGER,
    e_status INTEGER,
    e_sort INTEGER,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_cd)
);
