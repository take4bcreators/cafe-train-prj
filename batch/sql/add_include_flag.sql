-- 包含フラグ付与 テーブルへ挿入
INSERT INTO :schema.tmp_add_include_flag (
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
    include_flag
)
SELECT
    T1.search_lat,
    T1.search_lon,
    T1.target_station_name,
    T1.search_name,
    T1.place_id,
    T1.place_name,
    T1.place_lat,
    T1.place_lon,
    T1.search_check_flag,
    T1.distance_meter,
    T1.distance_check_flag,
    COALESCE(T2.include_flag, 1) AS include_flag
FROM
    :schema.tmp_add_distance_check T1
LEFT OUTER JOIN (
    SELECT
        exclude_place_id,
        0 AS include_flag
    FROM
        :schema.mst_exclude_placeid
) T2
ON
    T1.place_id = T2.exclude_place_id
;
