CREATE TABLE :schema.line_info (
    line_code INTEGER,
    line_definition_code INTEGER,
    line_name TEXT NOT NULL,
    line_yomi TEXT,
    line_color TEXT NOT NULL,
    PRIMARY KEY(line_code)
);
