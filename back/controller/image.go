package controller

import (
	e "back/entity"
	"back/model"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
	"math/rand"

	"github.com/labstack/echo/v4"
)

func GetImage(c echo.Context) error {
	imageID, err := strconv.Atoi(c.Param("id"))

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	res, err := model.GetImageByID(imageID)

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

func AddImage(c echo.Context) (err error) {
	var image e.Image
	hash := randomString(15)

	if err = c.Bind(&image); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	file, err := c.FormFile("file")

	if err != nil {
		return c.JSON(http.StatusBadRequest, err.Error())
	}

	// Source
	src, err := file.Open()

	if err != nil {
		return c.JSON(http.StatusBadRequest, err.Error())
	}
	defer src.Close()

	// Destination
	uploadFilePath := "/uploads/" + hash + "." + file.Filename
	dst, err := os.Create(uploadFilePath)

	if err != nil {
		return c.JSON(http.StatusBadRequest, err.Error())
	}
	defer dst.Close()

	// Copy
	if _, err = io.Copy(dst, src); err != nil {
		return c.JSON(http.StatusBadRequest, err.Error())
	}

	image.URL = "http://localhost:1323/picture/" + hash + "." + file.Filename

	err = model.InsertImage(&image)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusCreated, e.SetResponse(http.StatusCreated, "Ok", EmptyValue))
}

func RemoveImage(c echo.Context) error {
	imageID, err := strconv.Atoi(c.Param("id"))

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	res, err := model.GetImageByID(imageID)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	err = model.DeleteImage(imageID)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	s := strings.Split(res.URL, "/picture/")
	fileName := s[1]

	err = os.Remove("/uploads/" + fileName)

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusAccepted, "Ok")
}

func EditImage(c echo.Context) error {
	var image e.Image

	imageID, err := strconv.Atoi(c.Param("id"))

	if err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	if err := c.Bind(&image); err != nil {
		return c.JSON(http.StatusUnprocessableEntity, e.SetResponse(http.StatusUnprocessableEntity, err.Error(), EmptyValue))
	}

	image.ID = imageID

	if err := model.UpdateImage(&image); err != nil {
		return c.JSON(http.StatusBadRequest, e.SetResponse(http.StatusBadRequest, err.Error(), EmptyValue))
	}

	return c.JSON(http.StatusOK, e.SetResponse(http.StatusOK, "Edited", EmptyValue))
}


// Returns an int >= min, < max
func randomInt(min, max int) int {
    return min + rand.Intn(max-min)
}

func randomString(len int) string {
    bytes := make([]byte, len)
    for i := 0; i < len; i++ {
        bytes[i] = byte(randomInt(97, 122))
    }
    return string(bytes)
}
