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
	e.GET("/category/:id", controller.GetCategory, paramValidation)
	e.GET("/category", controller.GetAllCategory)
	e.POST("/category", controller.AddCategory)
	e.PUT("/category/:id", controller.EditCategory, paramValidation)
	e.DELETE("/category/:id", controller.RemoveCategory, paramValidation)
}
