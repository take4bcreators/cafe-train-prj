CREATE TABLE mst_target_prefectures (
    target_prefecture_code TEXT,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(target_prefecture_code)
);
