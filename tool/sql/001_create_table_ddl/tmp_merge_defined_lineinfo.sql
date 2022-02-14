CREATE TABLE :schema.tmp_merge_defined_lineinfo (
    new_line_cd INTEGER,
    origin_line_cd INTEGER NOT NULL,
    company_cd INTEGER NOT NULL,
    new_line_name TEXT NOT NULL,
    origin_line_name TEXT NOT NULL,
    line_name_k TEXT,
    line_name_h TEXT,
    line_symbol TEXT,
    line_color_c TEXT,
    line_color_t TEXT,
    line_type INTEGER,
    lon TEXT,
    lat TEXT,
    zoom INTEGER,
    e_status INTEGER,
    e_sort INTEGER,
    PRIMARY KEY(new_line_cd)
);
