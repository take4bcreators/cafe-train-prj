CREATE TABLE :schema.mst_fetch_target_line (
    type_cd INTEGER,
    target_cd INTEGER,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(type_cd, target_cd)
);
