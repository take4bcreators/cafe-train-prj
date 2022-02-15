CREATE TABLE :schema.mst_defined_lineinfo (
    line_cd INTEGER NOT NULL,
    def_line_cd INTEGER UNIQUE,
    line_symbol TEXT,
    def_line_name TEXT,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(line_cd, def_line_cd)
);
