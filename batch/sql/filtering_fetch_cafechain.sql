-- 取得対象チェーン絞込テーブルへの挿入
INSERT INTO :schema.mst_filtering_fetch_cafechain (
    chain_id,       -- チェーン識別番号
    chain_name,     -- チェーン名称
    search_name     -- 検索用名称
)
SELECT
    chain_id,       -- チェーン識別番号
    chain_name,     -- チェーン名称
    search_name     -- 検索用名称
FROM
    :schema.mst_cafe_chain  -- カフェチェーンマスタテーブル 
WHERE
    chain_id IN (
        SELECT  target_chain_id
        FROM    :schema.mst_fetch_target_chain
    )
;
