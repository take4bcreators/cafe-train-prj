CREATE TABLE mst_fetch_target_line (
    target_line_code TEXT ,
    update_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(target_line_code)
);
