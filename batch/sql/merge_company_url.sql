-- 事業者URL情報併合テーブルへの挿入
INSERT INTO :schema.tmp_merge_company_url (
    company_cd,
    rr_cd,
    company_name,
    company_name_k,
    company_name_h,
    company_name_r,
    def_company_name,
    company_url,
    company_url_str,
    company_type,
    e_status,
    e_sort
)
SELECT
    T1.company_cd,
    T1.rr_cd,
    T1.company_name,
    T1.company_name_k,
    T1.company_name_h,
    T1.company_name_r,
    T1.def_company_name,
    T1.company_url,
    T2.company_url_str,
    T1.company_type,
    T1.e_status,
    T1.e_sort
FROM
    :schema.tmp_merge_defined_companyinfo T1
LEFT OUTER JOIN
    :schema.mst_company_url T2
ON
    T1.company_cd = T2.company_cd
;
