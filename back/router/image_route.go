package router

import (
	"back/controller"

	"github.com/labstack/echo/v4"
)

func SetImageRoutes(e *echo.Echo) {
	e.GET("/image/:id", controller.GetImage, ParamValidation)
	e.GET("/image", controller.GetAllImage)
	e.POST("/image", controller.AddImage)
	e.PUT("/image/:id", controller.EditImage, ParamValidation)
	e.DELETE("/image/:id", controller.RemoveImage, ParamValidation)
}
