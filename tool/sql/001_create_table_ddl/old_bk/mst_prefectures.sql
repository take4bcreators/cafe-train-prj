CREATE TABLE :schema.mst_prefectures (
    prefecture_code INTEGER,
    prefecture_name TEXT NOT NULL,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(prefecture_code)
);