CREATE TABLE :schema.tmp_merge_company_url (
    company_cd INTEGER,
    rr_cd INTEGER NOT NULL,
    company_name TEXT NOT NULL,
    company_name_k TEXT,
    company_name_h TEXT,
    company_name_r TEXT,
    def_company_name TEXT,
    company_url TEXT,
    company_url_str TEXT,
    company_type INTEGER,
    e_status INTEGER,
    e_sort INTEGER,
    PRIMARY KEY(company_cd)
);
