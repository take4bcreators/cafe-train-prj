CREATE TABLE :schema.mst_cafe_chain (
    chain_id INTEGER,
    chain_name TEXT NOT NULL,
    search_name TEXT NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(chain_id)
);
