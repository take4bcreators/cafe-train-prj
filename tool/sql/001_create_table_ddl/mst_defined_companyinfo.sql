CREATE TABLE :schema.mst_defined_companyinfo (
    company_cd INTEGER,
    def_company_name TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(company_cd)
);
