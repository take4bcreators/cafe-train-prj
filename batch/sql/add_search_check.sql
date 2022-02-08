-- 検索チェック付与テーブルへ挿入
INSERT INTO :schema.tmp_add_search_check (
    search_lat,
    search_lon,
    target_station_name,
    search_name,
    place_id,
    place_name,
    search_check_flag
)
SELECT
    T1.search_lat,
    T1.search_lon,
    STRING_AGG(DISTINCT T2.station_name, '、') AS target_station_name,
    T1.search_name,
    T1.place_id,
    T1.place_name,
    CASE
        WHEN T1.place_name LIKE '%' || T1.search_name || '%' THEN 1
        ELSE 0 END AS search_check_flag
FROM
    :schema.gmp_cafe T1
INNER JOIN
    :schema.ejp_station T2
ON
    T1.search_lat       = T2.lat
    AND T1.search_lon   = T2.lon
GROUP BY
    T1.search_lat, T1.search_lon, T1.search_name, T1.place_id, T1.place_name
;

