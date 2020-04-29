package model

import (
	"database/sql"
	"errors"

	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/db"
	e "github.com/HETIC-MT-P2021/aio-group2-proj01/back/entity"
)

// GetTagByID returns data of a tag.
func GetTagByID(tagID int) (e.Tag, error) {
	var tag e.Tag

	const query = `SELECT * FROM tag WHERE id_tag = $1`
	err := db.DB.QueryRow(query, tagID).Scan(&tag.ID, &tag.Name)

	if err == sql.ErrNoRows {
		return tag, errors.New("tag is not found")
	}

	if err != nil {
		return tag, err
	}

	return tag, nil
}

// GetAllTag returns list of data of all tags.
func GetAllTag() ([]e.Tag, error) {
	var tag e.Tag

	var tagList []e.Tag

	rows, err := db.DB.Query(`SELECT * FROM tag order by id_tag`)

	if err != nil {
		return tagList, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&tag.ID, &tag.Name)

		if err != nil {
			return tagList, err
		}

		tagList = append(tagList, tag)
	}

	err = rows.Err()

	if err != nil {
		return tagList, err
	}

	return tagList, nil
}

// InsertTag insert new image in tag.
func InsertTag(tag *e.Tag) error {
	const query = `INSERT INTO "tag" ("name") VALUES ($1)`

	tx, err := db.DB.Begin()
	if err != nil {
		return err
	}

	_, err = tx.Exec(query, tag.Name)
	if err != nil {
		tx.Rollback()
		return err
	}

	tx.Commit()

	return nil
}

// DeleteTag delete a tag of the database.
func DeleteTag(tagID int) error {
	const query = `DELETE FROM tag WHERE id_tag = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, tagID)
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

// UpdateTag update a tag in the database.
func UpdateTag(tag *e.Tag) error {
	const query = `UPDATE tag SET name = $2 WHERE id_tag = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, tag.ID, tag.Name)

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

	tx.Commit()

	return nil
}
