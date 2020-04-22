package model

import (
	"back/db"
	e "back/entity"
	"database/sql"
	"errors"
)

func GetImageById(imageID int) (e.Image, error)  {
	var image e.Image
	const query = `SELECT * FROM image WHERE id_image = $1`
	err := db.DB.QueryRow(query, imageID).Scan(&image.ID, &image.Description, &image.IDCategory, &image.AddedDate)

	if err == sql.ErrNoRows {
		return image, errors.New("Image is not found")
	}

	if err != nil {
		return image, err
	}

	return image, nil
}

func GetAllImage() ([]e.Image, error) {
	var image e.Image
	var imageList []e.Image

	rows, err := db.DB.Query(`SELECT * FROM image order by id_image`)
	if err != nil {
		return imageList, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&image.ID, &image.Description, &image.IDCategory, &image.AddedDate)
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

//TODO

// func InsertImage(image *e.Image) error {
// 	const query = `INSERT INTO "image" ("name", "description, id_category, added_date") VALUES ($1, $2, $3, $4)`
// 	tx, err := db.DB.Begin()
// 	if err != nil {
// 		return err
// 	}

// 	_, err = tx.Exec(query, image.Description, &image.IDCategory, &image.AddedDate)
// 	if err != nil {
// 		tx.Rollback()
// 		return err
// 	}

// 	tx.Commit()
// 	return nil
// }

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
		return errors.New("Strange behaviour. Total affected : " + string(rowsAffected))
	}

	tx.Commit()
	return nil
}
// TODO

// func UpdateImage(image *e.Image) error {

// 	const query = `UPDATE image SET name = $2, description = $3, id_category = $4 WHERE id_image = $1`
// 	tx, err := db.DB.Begin()
// 	if err != nil {
// 		return err
// 	}

// 	res, err := tx.Exec(query, image.ID, image.Description, &image.IDCategory)
// 	if err != nil {
// 		tx.Rollback()
// 		return err
// 	}

// 	rowsAffected, err := res.RowsAffected()
// 	if err != nil {
// 		tx.Rollback()
// 		return err
// 	}

// 	if rowsAffected == 0 {
// 		tx.Rollback()
// 		return errors.New("data is not found")
// 	}

// 	if rowsAffected > 1 {
// 		tx.Rollback()
// 		return errors.New("Strange behaviour. Total affected is : " + string(rowsAffected))
// 	}

// 	tx.Commit()

// 	return nil
// }
