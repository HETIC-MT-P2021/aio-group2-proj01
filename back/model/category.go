package model

import (
	"database/sql"
	"errors"

	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/db"
	e "github.com/HETIC-MT-P2021/aio-group2-proj01/back/entity"
)

// GetCategoryByID returns data of a category.
func GetCategoryByID(categoryID int) (e.Category, error) {
	var category e.Category

	const query = `SELECT * FROM category WHERE id_category = $1`
	err := db.DB.QueryRow(query, categoryID).Scan(&category.ID, &category.Name, &category.Description)

	if err == sql.ErrNoRows {
		return category, errors.New("category is not found")
	}

	if err != nil {
		return category, err
	}

	return category, nil
}

// GetAllCategory returns list of data of all categories.
func GetAllCategory() ([]e.Category, error) {
	var category e.Category

	var categoryList []e.Category

	rows, err := db.DB.Query(`SELECT * FROM category order by id_category`)

	if err != nil {
		return categoryList, err
	}
	defer rows.Close()

	for rows.Next() {
		err = rows.Scan(&category.ID, &category.Name, &category.Description)

		if err != nil {
			return categoryList, err
		}

		categoryList = append(categoryList, category)
	}

	err = rows.Err()

	if err != nil {
		return categoryList, err
	}

	return categoryList, nil
}

// InsertCategory insert new category in database.
func InsertCategory(category *e.Category) error {
	const query = `INSERT INTO "category" ("name", "description") VALUES ($1, $2)`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	_, err = tx.Exec(query, category.Name, category.Description)

	if err != nil {
		tx.Rollback()
		return err
	}

	tx.Commit()

	return nil
}

// DeleteCategory delete a category of the database.
func DeleteCategory(categoryID int) error {
	const query = `DELETE FROM category WHERE id_category = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, categoryID)

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

// UpdateCategory update a category in the database.
func UpdateCategory(category *e.Category) error {
	const query = `UPDATE category SET name = $2, description = $3 WHERE id_category = $1`

	tx, err := db.DB.Begin()

	if err != nil {
		return err
	}

	res, err := tx.Exec(query, category.ID, category.Name, category.Description)

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
