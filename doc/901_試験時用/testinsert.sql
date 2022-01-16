CREATE TABLE dev.sample_table_001 (
    animal_id TEXT,
    animal_name TEXT,
    area_name TEXT,
    osumesu TEXT,
    age INTEGER,
    country TEXT,
    comment TEXT,
    PRIMARY KEY (animal_id)
);


INSERT INTO dev.sample_table_001(
    animal_id,
    animal_name,
    area_name,
    osumesu,
    age,
    country,
    comment
)
VALUES ('001','ペンギン','水','オス',3,'南極','元気いっぱい'),
       ('002','ペンギン','水','メス',6,'南極','食いしんぼう'),
       ('003','パンダ','陸','メス',5,'中国','リンリンって名前'),
       ('004','パンダ','陸','オス',10,'中国','レイレイって名前'),
       ('005','ライオン','陸','オス',5,'サバンナ','コワイ'),
       ('006','ライオン','陸','メス',3,'サバンナ','かわいい'),
       ('007','ワシ','空','オス',5,'日本','かしこい'),
       ('008','ワシ','空','メス',6,'日本','りりしい'),
       ('009','さんま','水','オス',1,'日本','おいしい'),
       ('010','さんま','水','メス',4,'日本','おいしい'),
       ('011','ゴリラ','陸','オス',10,'ジャングル','uhouho')
;


SELECT COUNT(*) FROM dev.sample_table_001;
