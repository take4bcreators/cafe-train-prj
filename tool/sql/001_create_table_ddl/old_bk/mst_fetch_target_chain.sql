CREATE TABLE :schema.mst_fetch_target_chain (
    target_chain_id TEXT,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(target_chain_id)
);
