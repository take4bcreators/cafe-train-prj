-- 取得路線情報絞込テーブルへの挿入
INSERT INTO :schema.tmp_filtering_fetch_lineinfo (
    station_cd,             -- 駅コード
    station_g_cd,           -- 駅グループコード
    station_name,           -- 駅名称
    line_cd,                -- 路線コード
    lon,                    -- 経度
    lat,                    -- 緯度
    e_status                -- 状態
)
SELECT
    station_cd,             -- 駅コード
    station_g_cd,           -- 駅グループコード
    station_name,           -- 駅名称
    line_cd,                -- 路線コード
    lon,                    -- 経度
    lat,                    -- 緯度
    e_status                -- 状態
FROM
    :schema.ejp_station     -- 駅テーブル
WHERE
    e_status = 0            -- 状態 = 0 ：運用中
    AND (
        -- 取得対象路線テーブル から 路線コード 指定のもの取得
        line_cd IN (
            SELECT target_cd
            FROM   :schema.mst_fetch_target_line
            WHERE  type_cd = 2
        )
        OR
        -- 取得対象路線テーブル から 事業者コード 指定のものを取得
        line_cd IN (
            SELECT line_cd
            FROM   :schema.ejp_line
            WHERE  company_cd IN (
                SELECT target_cd
                FROM   :schema.mst_fetch_target_line
                WHERE  type_cd = 1
            )
        )
        OR
        -- 取得対象路線テーブル から 駅コード 指定のものを取得
        station_cd IN (
            SELECT target_cd
            FROM   :schema.mst_fetch_target_line
            WHERE  type_cd = 3
        )
        OR
        -- 取得対象路線テーブル から 駅グループコード 指定のものを取得
        station_g_cd IN (
            SELECT target_cd
            FROM   :schema.mst_fetch_target_line
            WHERE  type_cd = 4
        )
    )
;
