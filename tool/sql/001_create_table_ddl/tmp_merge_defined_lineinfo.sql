CREATE TABLE :schema.tmp_merge_defined_lineinfo (
    line_cd INTEGER,
    join_line_cd INTEGER,
    company_cd INTEGER NOT NULL,
    line_name TEXT NOT NULL,
    line_name_k TEXT,
    line_name_h TEXT,
    def_line_name TEXT,
    line_symbol TEXT,
    line_color_c TEXT,
    line_color_t TEXT,
    line_type INTEGER,
    lon TEXT,
    lat TEXT,
    zoom INTEGER,
    e_status INTEGER,
    e_sort INTEGER,
    PRIMARY KEY(line_cd)
);
