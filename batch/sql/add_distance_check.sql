-- 独自関数の作成
CREATE OR REPLACE FUNCTION LATLON_TO_DIST(lat1 float,lon1 float,lat2 float,lon2 float)
RETURNS float AS $$
    -- 2地点間の距離を求める (Km)
    -- lat1,lon1:地点1の緯度,経度
    -- lat2,lon2:地点2の緯度,経度
    DECLARE diffLatitudeRad float;
    DECLARE diffLongitudeRad float;
    DECLARE r float;
    DECLARE diffLatitudeKm float;
    DECLARE diffLongitudeKm float;
BEGIN
    diffLatitudeRad  := (lat1 - lat2) * PI() / 180.0; -- 緯度差(RADIAN)
    diffLongitudeRad := (lon1 - lon2) * PI() / 180.0; -- 経度差(RADIAN)
    r := 6378.137; -- 地球の半径
    diffLatitudeKm  = diffLatitudeRad * r;
    diffLongitudeKm = COS( lon1 * PI() / 180.0) * r * diffLongitudeRad;               -- 緯度方向の距離(Km)
    RETURN SQRT(diffLatitudeKm * diffLatitudeKm + diffLongitudeKm * diffLongitudeKm); -- ２地点間の距離(Km)
END
$$ LANGUAGE plpgsql
;


-- 距離チェック付与 テーブルへ挿入
INSERT INTO :schema.tmp_add_distance_check (
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
    distance_check_flag
)
WITH tmp1 AS (
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
        LATLON_TO_DIST(
            CAST(search_lat AS DOUBLE PRECISION),
            CAST(search_lon AS DOUBLE PRECISION),
            CAST(place_lat  AS DOUBLE PRECISION),
            CAST(place_lon  AS DOUBLE PRECISION)
        ) * 1000 AS distance_meter
    FROM
        :schema.tmp_add_search_check
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
    CASE
        WHEN distance_meter <= 400 THEN 1
        ELSE 0 END AS distance_check_flag
FROM
    tmp1
;
