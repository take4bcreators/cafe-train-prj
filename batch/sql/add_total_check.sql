-- 総合チェック付与 テーブルへ挿入
INSERT INTO :schema.tmp_add_total_check (
    search_lat,
    search_lon,
    target_station_name,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon,
    search_check_flag,
    distance_meter,
    distance_check_flag,
    total_check_flag
)
SELECT
    search_lat,
    search_lon,
    target_station_name,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon,
    search_check_flag,
    distance_meter,
    distance_check_flag,
    CASE
        WHEN search_check_flag = 1 AND  distance_check_flag = 1 THEN 1
        ELSE 0 END AS total_check_flag
FROM
    :schema.tmp_add_distance_check
;
