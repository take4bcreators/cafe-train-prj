CREATE TABLE :schema.mst_defined_lineinfo (
    line_cd INTEGER,
    join_line_cd INTEGER,
    line_symbol TEXT,
    def_line_name TEXT,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_cd)
);
