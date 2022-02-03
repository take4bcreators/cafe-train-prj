-- 取得路線情報重複削除テーブルへの挿入
INSERT INTO :schema.tmp_unique_fetch_lineinfo (
    lon,                                        -- 経度
    lat,                                        -- 緯度
    target_station_cd,                          -- 対象駅コード
    target_station_name                         -- 対象駅名称
)
SELECT
    lon,                                        -- 経度
    lat,                                        -- 緯度
    STRING_AGG(CAST(station_cd AS TEXT), '/'),  -- 駅コード を 横並びにする
    STRING_AGG(station_name, '/')               -- 駅名称 を 横並びにする
FROM
    :schema.tmp_filtering_fetch_lineinfo        -- 取得路線情報絞込テーブル
GROUP BY
    lon, lat
;
