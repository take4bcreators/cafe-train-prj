-- 検索チェック付与 テーブルへ挿入
INSERT INTO :schema.tmp_add_search_check (
    search_lat,
    search_lon,
    target_station_name,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon,
    search_check_flag
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
    CASE
        WHEN T1.place_name ~ COALESCE(T2.res_judge_regexp, T1.search_name) THEN 1
        ELSE 0 END AS search_check_flag
FROM
    :schema.tmp_add_station_name T1
LEFT OUTER JOIN
    :schema.mst_cafe_chain T2
ON
    T1.search_name = T2.api_search_word
;
