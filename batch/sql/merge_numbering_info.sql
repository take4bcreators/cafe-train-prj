-- 駅ナンバリング情報併合 テーブルへの挿入
INSERT INTO :schema.tmp_merge_numbering_info (
    station_cd,
    station_g_cd,
    numbering,
    station_name,
    station_name_k,
    station_name_r,
    new_line_cd,
    origin_line_cd,
    pref_cd,
    post,
    add,
    lon,
    lat,
    open_ymd,
    close_ymd,
    e_status,
    e_sort
)
SELECT
    T1.station_cd,
    T1.station_g_cd,
    T2.numbering,
    T1.station_name,
    T1.station_name_k,
    T1.station_name_r,
    T1.new_line_cd,
    T1.origin_line_cd,
    T1.pref_cd,
    T1.post,
    T1.add,
    T1.lon,
    T1.lat,
    T1.open_ymd,
    T1.close_ymd,
    T1.e_status,
    T1.e_sort
FROM
    :schema.tmp_merge_defined_stationinfo T1
LEFT OUTER JOIN
    :schema.mst_numbering_info T2
ON
    T1.station_cd = T2.station_cd
;
