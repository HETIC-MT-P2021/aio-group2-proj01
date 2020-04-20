package router

import (
	"back/controller"
	"github.com/labstack/echo/v4"
	"net/http"
	"regexp"
)

func paramValidation(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		paramKey := c.ParamNames()
		paramValue := c.ParamValues()

		r := regexp.MustCompile("^[0-9]+$")

		for k, v := range paramValue {
			if !r.MatchString(v) {
				return c.JSON(http.StatusBadRequest, "param ("+paramKey[k]+") is not a number")
			}
		}

		return next(c)
	}
}

func SetCategoryRoutes(e *echo.Echo) {
	e.PUT("/category/:id", controller.EditCategory, paramValidation)
	e.GET("/category", controller.GetCategory)
	e.POST("/category", controller.AddCategory)
	e.DELETE("/category/:id", controller.RemoveCategory, paramValidation)
}

