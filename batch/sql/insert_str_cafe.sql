-- カフェ情報蓄積テーブルへの挿入
INSERT INTO :schema.str_cafe (
    search_lat,
    search_lon,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon,
    updated_at
)
SELECT
    search_lat,
    search_lon,
    search_name,
    place_id,
    place_name,
    place_lat,
    place_lon,
    updated_at
FROM
    :schema.gmp_cafe
;
