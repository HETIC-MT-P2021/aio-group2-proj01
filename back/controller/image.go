package controller

import (
	e "back/entity"
	"back/model"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

func GetImage(c echo.Context) error {
	imageID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}
	res, err := model.GetImageById(imageID)
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

func GetAllImage(c echo.Context) error {

	res, err := model.GetAllImage()
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if len(res) == 0 {
		return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "image is empty", EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "", res))
}

// TODO

// func AddImage(c echo.Context) error {
// 	var image e.Image
// 	err := c.Bind(&image)
// 	if err != nil {
// 		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
// 	}

// 	err = model.InsertImage(&image)
// 	if err != nil {
// 		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
// 	}

// 	return c.JSON(http.StatusCreated, e.SetResponse(http.StatusCreated, "ok", EmptyValue))

// }

func RemoveImage(c echo.Context) error {
	imageID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	err = model.DeleteImage(imageID)
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusAccepted, "ok")
}

// TODO

// func EditImage(c echo.Context) error {
// 	var image e.Image
// 	imageID, err := strconv.Atoi(c.Param("id"))
// 	if err != nil {
// 		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
// 	}

// 	err = c.Bind(&image)
// 	if err != nil {
// 		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusUnprocessableEntity, err.Error(), EmptyValue))
// 	}

// 	image.ID = imageID

// 	err = model.UpdateImage(&image)
// 	if err != nil {
// 		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
// 	}

// 	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "edited", EmptyValue))
// }
