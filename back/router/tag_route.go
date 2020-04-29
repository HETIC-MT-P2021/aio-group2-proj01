package router

import (
	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/controller"
	"github.com/labstack/echo/v4"
)

// SetTagRoutes define all tags routes.
func SetTagRoutes(e *echo.Echo) {
	e.GET("/tag/:id", controller.GetTag, ParamValidation)
	e.GET("/tag", controller.GetAllTag)
	e.POST("/tag", controller.AddTag)
	e.PUT("/tag/:id", controller.EditTag, ParamValidation)
	e.DELETE("/tag/:id", controller.RemoveTag, ParamValidation)
}
