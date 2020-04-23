package model

import (
	"back/db"
	e "back/entity"
	"database/sql"
	"errors"
)

func GetTagById(tagID int) (e.Tag, error)  {
	var tag e.Tag
	const query = `SELECT * FROM tag WHERE id_tag = $1`
	err := db.DB.QueryRow(query, tagID).Scan(&tag.ID, &tag.Name)

	if err == sql.ErrNoRows {
		return tag, errors.New("Tag is not found")
	}

	if err != nil {
		return tag, err
	}

	return tag, nil
}

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

func CountTag() (int, error) {
	var countTag int

	err := db.DB.QueryRow("SELECT count(*) FROM tag").Scan(&countTag)

	if err == sql.ErrNoRows {
		return 0, errors.New("Tag is empty")
	}

	if err != nil {
		return 0, err
	}

	return countTag, nil
}

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
		return errors.New("Data is not found")
	}

	if rowsAffected > 1 {
		return errors.New("Strange behaviour. Total affected : " + string(rowsAffected))
	}

	tx.Commit()
	return nil
}

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
		return errors.New("Data is not found")
	}

	if rowsAffected > 1 {
		tx.Rollback()
		return errors.New("Strange behaviour. Total affected is : " + string(rowsAffected))
	}

	tx.Commit()

	return nil
}
