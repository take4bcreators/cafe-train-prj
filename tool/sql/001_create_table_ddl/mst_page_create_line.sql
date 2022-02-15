CREATE TABLE :schema.mst_page_create_line (
    page_create_line_cd INTEGER,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(page_create_line_cd)
);
