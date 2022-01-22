CREATE TABLE mst_original_definition_line (
    line_code TEXT ,
    line_definition_code TEXT ,
    line_definition_name TEXT ,
    line_definition_color TEXT ,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(line_code)
);
