CREATE TABLE :schema.mst_cafe_chain (
    chain_id INTEGER,
    chain_name TEXT NOT NULL,
    api_search_word TEXT NOT NULL,
    res_judge_regexp TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(chain_id)
);
