-- 駅名情報付与 テーブルへ挿入
INSERT INTO :schema.tmp_add_station_name (
    search_lat,
    search_lon,
    target_station_name,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon
)
SELECT
    T1.search_lat,
    T1.search_lon,
    STRING_AGG(DISTINCT T2.station_name, '、') AS target_station_name,
    T1.search_name,
    T1.place_id,
    T1.place_name,
    T1.place_lat,
    T1.place_lon
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

