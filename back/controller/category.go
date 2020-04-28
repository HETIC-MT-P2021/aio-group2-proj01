package controller

import (
	"net/http"
	"strconv"

	e "github.com/HETIC-MT-P2021/aio-group2-proj01/back/entity"
	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/model"
	"github.com/labstack/echo/v4"
)

var (
	EmptyValue = make([]int, 0)
)

// GetCategory returns a JSON object for one category.
func GetCategory(c echo.Context) error {
	categoryID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	res, err := model.GetCategoryByID(categoryID)
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

// GetAllCategory returns a JSON list of categories.
func GetAllCategory(c echo.Context) error {
	res, err := model.GetAllCategory()
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if len(res) == 0 {
		return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "category is empty", EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

// AddCategory creates a new category from JSON request.
func AddCategory(c echo.Context) error {
	var category e.Category

	if err := c.Bind(&category); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if err := model.InsertCategory(&category); err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusCreated, e.SetResponse(http.StatusCreated, "Ok", EmptyValue))
}

// RemoveCategory Delete category from JSON request.
func RemoveCategory(c echo.Context) error {
	categoryID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	err = model.DeleteCategory(categoryID)
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusAccepted, "Ok")
}

// EditCategory updates a category from JSON request.
func EditCategory(c echo.Context) error {
	var category e.Category

	categoryID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if err := c.Bind(&category); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusUnprocessableEntity, err.Error(), EmptyValue))
	}

	category.ID = categoryID
	if err := model.UpdateCategory(&category); err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "Edited", EmptyValue))
}
