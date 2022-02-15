-- 定義路線情報併合テーブルへの挿入
INSERT INTO :schema.tmp_merge_defined_lineinfo (
    new_line_cd,
    origin_line_cd,
    company_cd,
    new_line_name,
    origin_line_name,
    line_name_k,
    line_name_h,
    line_symbol,
    line_color_c,
    line_color_t,
    line_type,
    lon,
    lat,
    zoom,
    e_status,
    e_sort
)
SELECT
    COALESCE(T2.def_line_cd, T1.line_cd) AS new_line_cd,
    T1.line_cd AS origin_line_cd,
    T1.company_cd,
    COALESCE(T2.def_line_name, T1.line_name) AS new_line_name,
    T1.line_name AS origin_line_name,
    T1.line_name_k,
    T1.line_name_h,
    T2.line_symbol,
    T1.line_color_c,
    T1.line_color_t,
    T1.line_type,
    T1.lon,
    T1.lat,
    T1.zoom,
    T1.e_status,
    T1.e_sort
FROM
    :schema.ejp_line T1
LEFT OUTER JOIN
    :schema.mst_defined_lineinfo T2
ON
    T1.line_cd = T2.line_cd
;
