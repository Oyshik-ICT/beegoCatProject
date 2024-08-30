# CatApp

CatApp is a web application that allows users to explore cat images, learn about different cat breeds, and save their favorite cat pictures. The application is built using the Beego framework for Go and integrates with The Cat API.

## Features

- **Voting**: View random cat images and vote (like or dislike) on them. You can also add images to your favorites.
- **Breeds**: Search for cat breeds and view detailed information about each breed, including multiple images when available.
- **Favorites**: View all the cat images you've marked as favorites.
- **Efficient API Calls**: Utilizes Go channels for concurrent API requests, improving performance.

## Prerequisites

Before you begin, ensure you have the following installed:

- Go (version 1.16 or later)
- Beego framework
- Bee tool

## Setup

1. Clone the repository:

   ```
   git clone https://github.com/Oyshik-ICT/beegoCatProject.git

   cd beegoCatProject/CatApp
   ```

2. Install the Beego framework and the Bee tool:

   ```
   go get github.com/beego/beego/v2@latest

   go install github.com/beego/bee/v2@latest
   ```

3. Install dependencies:

   ```
   go mod tidy
   ```

4. Set up your configuration:

   - Copy `conf/app.conf.example` to `conf/app.conf`
   - Edit `conf/app.conf` and replace `your_api_key_here` with your actual Cat API key
   - Replace `your_user_sub_id_here` with a unique identifier for your app. This can be any combination of letters, numbers, or both—essentially any string you choose.

   Example `app.conf`:

   ```
   appname = CatApp
   httpport = 8080
   runmode = dev
   catapi_key = live_your_actual_api_key_here
   user_sub_id = your_chosen_user_sub_id
   ```

   You can obtain an API key from [The Cat API](https://thecatapi.com/) by signing up for a free account.

## Running the Application

To run the application, navigate to the project directory and use the `bee run` command:

```
cd beegoCatProject/CatApp
bee run
```

The application will start, and you can access it by opening a web browser and navigating to `http://localhost:8080`.

## Project Structure

- `controllers/`: Contains the logic for handling HTTP requests and includes channel-based API calls for improved concurrency
- `routers/`: Defines the routing for the application
- `static/`: Contains CSS and JavaScript files
- `views/`: Contains the HTML templates for the application
- `conf/`: Contains configuration files

## Router Information

The application uses the following routes:

- `/`: Home page
- `/voting`: Voting page for cat images
- `/breeds`: Page to search and view cat breeds
- `/favorites`: Page to view favorite cat images
- `/api/breeds`: API endpoint to get breed information
- `/api/breed-images`: API endpoint to get images for a specific breed
- `/api/random-image`: API endpoint to get a random cat image
- `/api/favorites`: API endpoint to add or get favorite images
- `/api/config`: API endpoint to get configuration information

These routes are defined in the `routers/router.go` file.

## API Usage

This application uses The Cat API for various functionalities. Here's a breakdown of the specific API endpoints used and their purposes:

1. **Get Breeds**

   - Endpoint: `https://api.thecatapi.com/v1/breeds`
   - Purpose: Fetches a list of all cat breeds
   - Used in: `GetBreeds` function in `controllers/default.go`

2. **Get Breed Images**

   - Endpoint: `https://api.thecatapi.com/v1/images/search?limit=8&breed_id={breedId}`
   - Purpose: Fetches images for a specific cat breed
   - Used in: `GetBreedImages` function in `controllers/default.go`

3. **Get Random Image**

   - Endpoint: `https://api.thecatapi.com/v1/images/search`
   - Purpose: Fetches a random cat image
   - Used in: `GetRandomImage` function in `controllers/default.go`

4. **Add Favorite**

   - Endpoint: `https://api.thecatapi.com/v1/favourites`
   - Method: POST
   - Purpose: Adds an image to the user's favorites
   - Used in: `AddFavorite` function in `controllers/default.go`

5. **Get Favorites**
   - Endpoint: `https://api.thecatapi.com/v1/favourites?sub_id={subId}`
   - Purpose: Fetches the user's favorite images
   - Used in: `GetFavorites` function in `controllers/default.go`

Each of these API calls requires the API key for authentication, which is included in the request headers.

## API Key Usage

The Cat API key is used in various parts of the application to authenticate requests to The Cat API. It's crucial to keep this key secure and not share it publicly. The key is stored in the `app.conf` file and is accessed in the code using Beego's configuration management.

In the controllers, the API key is retrieved using:

```go
apiKey, _ := beego.AppConfig.String("catapi_key")
```

This key is then used in API requests to The Cat API, such as when fetching random images or breed information.
