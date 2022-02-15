-- 通常のトランケートと共に、RESTART IDENTITY で SERIAL型 の連番もリセットする
TRUNCATE TABLE :schema.page_contents RESTART IDENTITY;
