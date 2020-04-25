package controller

import (
	e "back/entity"
	"back/model"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

// GetTag returns a JSON object for one tag.
func GetTag(c echo.Context) error {
	tagID, err := strconv.Atoi(c.Param("id"))

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	res, err := model.GetTagByID(tagID)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

// GetAllTag returns a JSON list of tags.
func GetAllTag(c echo.Context) error {
	res, err := model.GetAllTag()

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if len(res) == 0 {
		return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "Tag is empty", EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

// AddTag creates a new tag from JSON request.
func AddTag(c echo.Context) error {
	var tag e.Tag

	if err := c.Bind(&tag); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if err := model.InsertTag(&tag); err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusCreated, e.SetResponse(http.StatusCreated, "Ok", EmptyValue))
}

// RemoveTag Delete tag from JSON request.
func RemoveTag(c echo.Context) error {
	tagID, err := strconv.Atoi(c.Param("id"))

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	err = model.DeleteTag(tagID)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusAccepted, "Ok")
}

// EditTag updates a tag from JSON request.
func EditTag(c echo.Context) error {
	var tag e.Tag

	tagID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if err := c.Bind(&tag); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusUnprocessableEntity, err.Error(), EmptyValue))
	}

	tag.ID = tagID

	if err := model.UpdateTag(&tag); err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "Edited", EmptyValue))
}
