package model

import (
	"database/sql"
	"errors"
	"strconv"
	"strings"

	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/db"
	e "github.com/HETIC-MT-P2021/aio-group2-proj01/back/entity"
)

// GetImageByID returns data of a image.
func GetImageByID(imageID int) (e.Image, error) {
	var image e.Image

	const query = `SELECT *,
						(select concat('', string_agg(t.name, ','))
						FROM tag as t
								LEFT JOIN image_tag as it
										ON (it.id_tag = t.id_tag)
						WHERE id_image = $1) as tag
					FROM image as i
					WHERE id_image = $1`
	err := db.DB.QueryRow(query, imageID).Scan(&image.ID, &image.Description, &image.IDCategory, &image.URL, &image.CreatedAt, &image.Tag)

	if err == sql.ErrNoRows {
		return image, errors.New("image is not found")
	}

	if err != nil {
		return image, err
	}

	return image, nil
}

// GetAllImage returns list of data of all images.
func GetAllImage() ([]e.Image, error) {
	var image e.Image

	var imageList []e.Image

	rows, err := db.DB.Query(`SELECT *,
								(select concat('', string_agg(t.name, ','))
								FROM tag as t
										LEFT JOIN image_tag as it
												ON (it.id_tag = t.id_tag)
								WHERE id_image = i.id_image) as tag
							FROM image as i`)

	if err != nil {
		return imageList, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&image.ID, &image.Description, &image.IDCategory, &image.URL, &image.CreatedAt, &image.Tag)

		if err != nil {
			return imageList, err
		}

		imageList = append(imageList, image)
	}

	err = rows.Err()

	if err != nil {
		return imageList, err
	}

	return imageList, nil
}

// InsertImage insert new image in database.
func InsertImage(image *e.Image) error {
	const query = `INSERT INTO "image" ("description", "id_category", "url") VALUES ($1, $2, $3) RETURNING id_image`
	err := db.DB.QueryRow(query, &image.Description, &image.IDCategory, &image.URL).Scan(&image.ID)

	if err != nil {
		return err
	}

	if image.Tag != "" {
		t := strings.Split(image.Tag, ",")

		var aTag int

		for _, element := range t {
			aTag, err = strconv.Atoi(element)

			if err != nil {
				return err
			}

			queryImageTag := `INSERT INTO "image_tag" ("id_image", "id_tag") VALUES ($1, $2)`
			tx, err := db.DB.Begin()

			if err != nil {
				return err
			}

			_, err = tx.Exec(queryImageTag, &image.ID, aTag)

			if err != nil {
				tx.Rollback()
				return err
			}
			tx.Commit()

			if err != nil {
				return err
			}
		}
	}

	return nil
}

// DeleteImage delete a image of the database.
func DeleteImage(imageID int) error {
	const query = `DELETE FROM image WHERE id_image = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, imageID)
	if err != nil {
		tx.Rollback()
		return err
	}

	rowsAffected, err := res.RowsAffected()
	if err != nil {
		tx.Rollback()
		return err
	}

	if rowsAffected == 0 {
		tx.Rollback()
		return errors.New("data is not found")
	}

	if rowsAffected > 1 {
		return errors.New("strange behaviour. Total affected : " + string(rowsAffected))
	}

	tx.Commit()

	return nil
}

// UpdateImage update a image in the database.
func UpdateImage(image *e.Image) error {
	const query = `UPDATE image
				   SET description = $2, id_category = $3
				   WHERE id_image = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, image.ID, image.Description, image.IDCategory)

	if err != nil {
		tx.Rollback()
		return err
	}

	rowsAffected, err := res.RowsAffected()

	if err != nil {
		tx.Rollback()
		return err
	}

	if rowsAffected == 0 {
		tx.Rollback()
		return errors.New("data is not found")
	}

	if rowsAffected > 1 {
		tx.Rollback()
		return errors.New("strange behaviour. Total affected is : " + string(rowsAffected))
	}

	const queryDeleteImageTag = `DELETE FROM image_tag WHERE id_image = $1`
	_, err = tx.Exec(queryDeleteImageTag, image.ID)

	if err != nil {
		tx.Rollback()
		return err
	}

	tx.Commit()

	if image.Tag != "" {
		t := strings.Split(image.Tag, ",")

		var aTag int

		for _, element := range t {
			aTag, err = strconv.Atoi(element)

			if err != nil {
				return err
			}

			queryImageTag := `INSERT INTO "image_tag" ("id_image", "id_tag") VALUES ($1, $2)`
			tx, err := db.DB.Begin()

			if err != nil {
				return err
			}

			_, err = tx.Exec(queryImageTag, &image.ID, aTag)

			if err != nil {
				tx.Rollback()
				return err
			}
			tx.Commit()

			if err != nil {
				return err
			}
		}
	}

	return nil
}
