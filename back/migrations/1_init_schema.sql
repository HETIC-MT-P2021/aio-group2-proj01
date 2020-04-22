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
    CONSTRAINT "FK_ImageTag_IdImage" FOREIGN KEY ( "id_image" ) REFERENCES "image" ( "id_image" ),
    CONSTRAINT "FK_ImageTag_IdTag" FOREIGN KEY ( "id_tag" ) REFERENCES "tag" ( "id_tag" )
);

CREATE INDEX "FK_ImageTag_IdImage" ON "image_tag" (
    "id_image"
);

CREATE INDEX "FK_ImageTag_IdTag" ON "image_tag" (
    "id_tag"
);
