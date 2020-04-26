package router

import (
	"net/http"
	"regexp"

	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/controller"
	"github.com/labstack/echo/v4"
)

// ParamValidation validate the paramater of the request.
func ParamValidation(next echo.HandlerFunc) echo.HandlerFunc {
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

// SetCategoryRoutes define all cateogries routes.
func SetCategoryRoutes(e *echo.Echo) {
	e.GET("/category/:id", controller.GetCategory, ParamValidation)
	e.GET("/category", controller.GetAllCategory)
	e.POST("/category", controller.AddCategory)
	e.PUT("/category/:id", controller.EditCategory, ParamValidation)
	e.DELETE("/category/:id", controller.RemoveCategory, ParamValidation)
}
