package router

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

func InitRoutes(e *echo.Echo) {

	SetCategoryRoutes(e)
	SetTagRoutes(e)

	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, e.Routes())
	})
}
