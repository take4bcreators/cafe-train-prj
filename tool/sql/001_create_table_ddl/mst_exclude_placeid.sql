CREATE TABLE :schema.mst_exclude_placeid (
    exclude_place_id TEXT,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(exclude_place_id)
);
