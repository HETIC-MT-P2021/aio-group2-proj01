package router

import (
	"back/controller"
	"github.com/labstack/echo/v4"
)

func SetTagRoutes(e *echo.Echo) {
	e.GET("/tag/:id", controller.GetTag, paramValidation)
	e.GET("/tag", controller.GetAllTag)
	e.POST("/tag", controller.AddTag)
	e.PUT("/tag/:id", controller.EditTag, paramValidation)
	e.DELETE("/tag/:id", controller.RemoveTag, paramValidation)
}
