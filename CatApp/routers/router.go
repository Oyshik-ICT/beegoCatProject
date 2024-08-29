package routers

import (
	"CatApp/controllers"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	beego.Router("/", &controllers.MainController{})
	beego.Router("/voting", &controllers.MainController{}, "get:ShowVoting")
	beego.Router("/breeds", &controllers.MainController{}, "get:ShowBreeds")
	beego.Router("/favorites", &controllers.MainController{}, "get:ShowFavorites")
	beego.Router("/api/breeds", &controllers.MainController{}, "get:GetBreeds")
	beego.Router("/api/breed-images", &controllers.MainController{}, "get:GetBreedImages")
	beego.Router("/api/random-image", &controllers.MainController{}, "get:GetRandomImage")
	beego.Router("/api/favorites", &controllers.MainController{}, "post:AddFavorite")
	beego.Router("/api/favorites", &controllers.MainController{}, "get:GetFavorites")
	beego.Router("/api/config", &controllers.MainController{}, "get:GetConfig")
}
