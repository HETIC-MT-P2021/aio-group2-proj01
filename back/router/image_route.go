package router

import (
	"github.com/HETIC-MT-P2021/aio-group2-proj01/back/controller"
	"github.com/labstack/echo/v4"
)

// SetImageRoutes define all images routes.
func SetImageRoutes(e *echo.Echo) {
	e.GET("/image/:id", controller.GetImage, ParamValidation)
	e.GET("/image", controller.GetAllImage)
	e.POST("/image", controller.AddImage)
	e.PUT("/image/:id", controller.EditImage, ParamValidation)
	e.DELETE("/image/:id", controller.RemoveImage, ParamValidation)
}
