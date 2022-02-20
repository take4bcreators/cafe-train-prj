CREATE TABLE :schema.mst_fetch_target_chain (
    target_chain_id INTEGER,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(target_chain_id)
);
