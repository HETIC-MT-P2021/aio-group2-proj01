package router

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func InitRoutes(e *echo.Echo) {
	SetCategoryRoutes(e)
	SetTagRoutes(e)
	SetImageRoutes(e)

	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, e.Routes())
	})

	e.Static("/picture", "uploads")
}
