CREATE TABLE "category"
(
    "id_category" SERIAL PRIMARY KEY,
    "name"        varchar(50) NOT NULL,
    "description" varchar(255) NULL
);

CREATE TABLE "image"
(
    "id_image"    SERIAL PRIMARY KEY,
    "description" varchar(255) NULL,
    "id_category" integer NOT NULL,
    "url" varchar(255) NULL,
    "created_at"  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "FK_Image_IdCategory" FOREIGN KEY ( "id_category" ) REFERENCES "category" ( "id_category" )
);

CREATE TABLE "tag"
(
    "id_tag" SERIAL PRIMARY KEY,
    "name"   varchar(50) NOT NULL
);

CREATE TABLE "image_tag"
(
    "id_image" integer NOT NULL,
    "id_tag"   integer NOT NULL,
    CONSTRAINT "PK_Image_Tag" PRIMARY KEY ( "id_image", "id_tag" ),
    CONSTRAINT "FK_ImageTag_IdImage" FOREIGN KEY ( "id_image" ) REFERENCES "image" ( "id_image" ) ON DELETE CASCADE,
    CONSTRAINT "FK_ImageTag_IdTag" FOREIGN KEY ( "id_tag" ) REFERENCES "tag" ( "id_tag" ) ON DELETE CASCADE
);

CREATE INDEX "FK_ImageTag_IdImage" ON "image_tag" (
    "id_image"
);

CREATE INDEX "FK_ImageTag_IdTag" ON "image_tag" (
    "id_tag"
);

INSERT INTO "category" ("name", "description") VALUES 
    ('Wonders of the World', 'Description of the wonders of the World'),
    ('Wonders of nature', 'Description of the wonders of nature')
    ('Beautiful cities', 'Description of the beautiful cities')
    ('Cities at night', 'Description of the cities at night')
    ('Over the mountains', 'Description of over the mountains')
    ('Amazing lakes and bays', 'Description of the amazing lakes and bays')
    ('Historical places', 'Description of the historical places')
    ('Magical waterfalls', 'Description of the magical waterfalls')
    ('Best resorts', 'Description of the best resorts');

INSERT INTO "image" ("description", "id_category", "url") VALUES 
    ("Colosseum in Rome", 1, "http://localhost:1323/picture/colosseum.jpg"),
    ("Iguazu Falls in Argentina / Brazil", 2, "http://localhost:1323/picture/iguazu_falls.jpg"),
    ("Tokyo in Japan", 3, "http://localhost:1323/picture/tokyo.jpg"),
    ("London at night", 4, "http://localhost:1323/picture/edinburgh.jpg"),
    ("Everest", 5, "everest.jpg"),
    ("Puerto Galera bay", 6, "http://localhost:1323/picture/puerto_galera_bay.jpg"),
    ("Angkor Wat and the Siem Reap Temples", 7, "http://localhost:1323/picture/angkor.jpg"),
    ("Seljalandsfoss in Iceland", 8, "http://localhost:1323/picture/seljalandsfoss.jpg"),
    ("Bora Bora Pearl Beach Resort & Spa, French Polynesia", 9, "http://localhost:1323/picture/bora-bora.jpg");

INSERT INTO "tag" ("name") VALUES 
    ("Tag1"),
    ("Tag2"),
    ("Tag3"),
    ("Tag4"),
    ("Tag5"),
    ("Tag6")
    ("Tag7")
    ("Tag8");

INSERT INTO "image_tag" ("id_image", "id_tag") VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 1),
    (9, 2);
    