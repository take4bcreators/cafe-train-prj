-- 路線URL情報併合テーブルへの挿入
INSERT INTO :schema.tmp_merge_line_url (
    new_line_cd,
    origin_line_cd,
    company_cd,
    new_line_name,
    origin_line_name,
    line_name_k,
    line_name_h,
    line_symbol,
    line_color_cd,
    line_color_c,
    line_color_t,
    line_type,
    line_url_str,
    lon,
    lat,
    zoom,
    e_status,
    e_sort
)
SELECT
    T1.new_line_cd,
    T1.origin_line_cd,
    T1.company_cd,
    T1.new_line_name,
    T1.origin_line_name,
    T1.line_name_k,
    T1.line_name_h,
    T1.line_symbol,
    T1.line_color_cd,
    T1.line_color_c,
    T1.line_color_t,
    T1.line_type,
    T2.line_url_str,
    T1.lon,
    T1.lat,
    T1.zoom,
    T1.e_status,
    T1.e_sort
FROM
    :schema.tmp_merge_linecolor_info T1
LEFT OUTER JOIN
    :schema.mst_line_url T2
ON
    T1.new_line_cd = T2.line_cd
;
