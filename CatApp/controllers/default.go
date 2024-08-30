package controllers

import (
	"encoding/json"
	"fmt"

	"github.com/beego/beego/v2/client/httplib"
	beego "github.com/beego/beego/v2/server/web"
)

type MainController struct {
	beego.Controller
}

// New function to make API calls using channels
func makeAPIRequest(url string, apiKey string, result interface{}) error {
	responseChan := make(chan error, 1)

	go func() {
		req := httplib.Get(url)
		req.Header("x-api-key", apiKey)
		err := req.ToJSON(&result)
		responseChan <- err
	}()

	return <-responseChan
}

func (c *MainController) Get() {
	c.Data["Page"] = "index"
	c.TplName = "index.tpl"
}

func (c *MainController) ShowVoting() {
	c.Data["Page"] = "voting"
	c.TplName = "index.tpl"
}

func (c *MainController) ShowBreeds() {
	c.Data["Page"] = "breeds"
	c.TplName = "index.tpl"
}

func (c *MainController) ShowFavorites() {
	c.Data["Page"] = "favorites"
	c.TplName = "index.tpl"
}

func (c *MainController) GetBreeds() {
	apiKey, _ := beego.AppConfig.String("catapi_key")
	var breeds interface{}

	err := makeAPIRequest("https://api.thecatapi.com/v1/breeds", apiKey, &breeds)
	if err != nil {
		c.Data["json"] = map[string]interface{}{"error": err.Error()}
	} else {
		c.Data["json"] = breeds
	}
	c.ServeJSON()
}

func (c *MainController) GetBreedImages() {
	breedID := c.GetString("breed_id")
	if breedID == "" {
		c.Data["json"] = map[string]interface{}{"error": "breed_id is required"}
		c.ServeJSON()
		return
	}

	apiKey, _ := beego.AppConfig.String("catapi_key")
	url := fmt.Sprintf("https://api.thecatapi.com/v1/images/search?limit=8&breed_id=%s", breedID)

	var breedImages []interface{}
	err := makeAPIRequest(url, apiKey, &breedImages)
	if err != nil {
		c.Data["json"] = map[string]interface{}{"error": err.Error()}
	} else {
		c.Data["json"] = breedImages
	}
	c.ServeJSON()
}

func (c *MainController) GetConfig() {
	apiKey, _ := beego.AppConfig.String("catapi_key")
	subID, _ := beego.AppConfig.String("user_sub_id")

	config := map[string]string{
		"catapi_key":  apiKey,
		"user_sub_id": subID,
	}

	c.Data["json"] = config
	c.ServeJSON()
}

func (c *MainController) GetRandomImage() {
	apiKey, _ := beego.AppConfig.String("catapi_key")

	var images []map[string]interface{}
	err := makeAPIRequest("https://api.thecatapi.com/v1/images/search", apiKey, &images)
	if err != nil || len(images) == 0 {
		c.Data["json"] = map[string]interface{}{"error": "Failed to get random image"}
	} else {
		c.Data["json"] = images[0]
	}
	c.ServeJSON()
}

func (c *MainController) AddFavorite() {
	var favorite struct {
		ImageID string `json:"image_id"`
	}
	if err := json.Unmarshal(c.Ctx.Input.RequestBody, &favorite); err != nil {
		c.Data["json"] = map[string]interface{}{"error": "Invalid request body: " + err.Error()}
		c.ServeJSON()
		return
	}

	apiKey, _ := beego.AppConfig.String("catapi_key")
	subID, _ := beego.AppConfig.String("user_sub_id")

	responseChan := make(chan struct {
		ID    int64  `json:"id"`
		Error string `json:"message"`
	}, 1)

	go func() {
		req := httplib.Post("https://api.thecatapi.com/v1/favourites")
		req.Header("x-api-key", apiKey)
		req.Header("Content-Type", "application/json")
		req.JSONBody(map[string]string{
			"image_id": favorite.ImageID,
			"sub_id":   subID,
		})

		var response struct {
			ID    int64  `json:"id"`
			Error string `json:"message"`
		}
		err := req.ToJSON(&response)
		if err != nil {
			response.Error = "Failed to parse API response: " + err.Error()
		}
		responseChan <- response
	}()

	response := <-responseChan

	if response.ID != 0 {
		c.Data["json"] = map[string]interface{}{"id": response.ID}
	} else {
		c.Data["json"] = map[string]interface{}{"error": response.Error}
	}
	c.ServeJSON()
}

func (c *MainController) GetFavorites() {
	apiKey, _ := beego.AppConfig.String("catapi_key")
	subID, _ := beego.AppConfig.String("user_sub_id")

	url := fmt.Sprintf("https://api.thecatapi.com/v1/favourites?sub_id=%s", subID)

	var favorites []struct {
		ID    int `json:"id"`
		Image struct {
			ID  string `json:"id"`
			URL string `json:"url"`
		} `json:"image"`
	}

	err := makeAPIRequest(url, apiKey, &favorites)
	if err != nil {
		c.Data["json"] = map[string]interface{}{"error": err.Error()}
	} else {
		c.Data["json"] = favorites
	}
	c.ServeJSON()
}
