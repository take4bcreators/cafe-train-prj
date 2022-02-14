-- ラインカラー情報併合テーブルへの挿入
INSERT INTO :schema.tmp_merge_linecolor_info (
    line_cd,
    join_line_cd,
    company_cd,
    line_name,
    line_name_k,
    line_name_h,
    def_line_name,
    line_symbol,
    line_color_cd,
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
    T1.line_cd,
    T1.join_line_cd,
    T1.company_cd,
    T1.line_name,
    T1.line_name_k,
    T1.line_name_h,
    T1.def_line_name,
    T1.line_symbol,
    T2.line_color_cd,
    T1.line_color_c,
    T1.line_color_t,
    T1.line_type,
    T1.lon,
    T1.lat,
    T1.zoom,
    T1.e_status,
    T1.e_sort
FROM
    :schema.tmp_merge_defined_lineinfo T1
LEFT OUTER JOIN
    :schema.mst_linecolor T2
ON
    T1.line_cd = T2.line_cd
;
