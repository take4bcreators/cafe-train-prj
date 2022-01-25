CREATE TABLE :schema.esp_line (
    company_code INTEGER NOT NULL,
    line_code INTEGER,
    line_name TEXT NOT NULL,
    line_yomi TEXT,
    line_color TEXT NOT NULL,
    PRIMARY KEY(line_code)
);
