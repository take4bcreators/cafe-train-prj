CREATE TABLE :schema.mst_original_definition_line (
    line_code TEXT,
    line_definition_code TEXT,
    line_definition_name TEXT,
    line_definition_color TEXT,
    line_page_url TEXT UNIQUE,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_code)
);
