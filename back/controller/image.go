package controller

import (
	e "back/entity"
	"back/model"
	"net/http"
	"strconv"
	"io"
	"os"

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

func AddImage(c echo.Context) error {
	var image e.Image
	// maxFileSize := 1000000
	err := c.Bind(&image)
	if err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	// file, err := c.FormFile("file_image")
	// if err != nil {
	// 	return c.JSON(http.StatusBadRequest, err.Error())
	// }

	// if file.Header["Content-Type"][0] != "image/png" {
	// 	return c.JSON(http.StatusBadRequest, "Only able to upload png file")
	// }

	// if file.Size > int64(maxFileSize) {
	// 	return c.JSON(http.StatusBadRequest, "File size can't be more than 1 MB")
	// }

	// src, err := file.Open()
	// if err != nil {
	// 	return c.JSON(http.StatusBadRequest, err.Error())
	// }
	// defer src.Close()

	// uploadFilePath := "../tmp/" + file.Filename

	// image.URL = uploadFilePath

	err = model.InsertImage(&image)
	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	// dst, err := os.Create(uploadFilePath)
	// if err != nil {
	// 	return c.JSON(http.StatusBadRequest, err.Error())
	// }
	// defer dst.Close()

	// if _, err = io.Copy(dst, src); err != nil {
	// 	return c.JSON(http.StatusBadRequest, err.Error())
	// }

	return c.JSON(http.StatusCreated, e.SetResponse(http.StatusCreated, "ok", EmptyValue))

}

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
