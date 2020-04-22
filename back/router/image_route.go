package router

import (
	"back/controller"
	"github.com/labstack/echo/v4"
)

func SetImageRoutes(e *echo.Echo) {
	e.GET("/image/:id", controller.GetImage, paramValidation)
	e.GET("/image", controller.GetAllImage)
	// e.POST("/image", controller.AddImage)
	// e.PUT("/image/:id", controller.EditImage, paramValidation)
	e.DELETE("/image/:id", controller.RemoveImage, paramValidation)
}
