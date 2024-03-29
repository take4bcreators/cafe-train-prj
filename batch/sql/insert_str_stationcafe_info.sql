-- 駅カフェ情報蓄積テーブルへの挿入
INSERT INTO :schema.str_stationcafe_info (
    search_lat,
    search_lon,
    target_station_name,
    cflag01,
    cflag02,
    cflag03,
    cflag04,
    cflag05,
    cflag06,
    cflag07,
    cflag08,
    cflag09,
    cflag10,
    cflag11,
    cflag12,
    cflag13,
    cflag14,
    cflag15,
    cflag16,
    cflag17,
    cflag18,
    cflag19,
    cflag20,
    cflag21,
    cflag22,
    cflag23,
    cflag24,
    cflag25,
    cflag26,
    cflag27,
    cflag28,
    cflag29,
    cflag30,
    cflag31,
    cflag32,
    cflag33,
    cflag34,
    cflag35,
    cflag36,
    cflag37,
    cflag38,
    cflag39,
    cflag40,
    update_datetime
)
SELECT
    search_lat,
    search_lon,
    target_station_name,
    cflag01,
    cflag02,
    cflag03,
    cflag04,
    cflag05,
    cflag06,
    cflag07,
    cflag08,
    cflag09,
    cflag10,
    cflag11,
    cflag12,
    cflag13,
    cflag14,
    cflag15,
    cflag16,
    cflag17,
    cflag18,
    cflag19,
    cflag20,
    cflag21,
    cflag22,
    cflag23,
    cflag24,
    cflag25,
    cflag26,
    cflag27,
    cflag28,
    cflag29,
    cflag30,
    cflag31,
    cflag32,
    cflag33,
    cflag34,
    cflag35,
    cflag36,
    cflag37,
    cflag38,
    cflag39,
    cflag40,
    update_datetime
FROM :schema.tmp_create_stationcafe_info
;
