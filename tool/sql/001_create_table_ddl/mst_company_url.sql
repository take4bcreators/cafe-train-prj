CREATE TABLE :schema.mst_company_url (
    company_cd INTEGER,
    company_url_str TEXT NOT NULL,
    note TEXT,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(company_cd)
);
