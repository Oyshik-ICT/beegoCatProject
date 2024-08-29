<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cat Breeds App</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/styles.css">
</head>
<body>
    <div class="container mt-5">
        <nav class="nav nav-pills nav-justified mb-3">
            <a class="nav-item nav-link {{if eq .Page "voting"}}active{{end}}" href="/voting">Voting</a>
            <a class="nav-item nav-link {{if eq .Page "breeds"}}active{{end}}" href="/breeds">Breeds</a>
            <a class="nav-item nav-link {{if eq .Page "favorites"}}active{{end}}" href="/favorites">Favs</a>
        </nav>
        
        {{if eq .Page "voting"}}
        <div id="voting-content" class="text-center">
            <img id="cat-image" src="" alt="Random Cat" class="img-fluid mb-3">
            <div class="d-flex justify-content-between">
                <button id="fav-btn" class="btn btn-outline-danger">❤</button>
                <div>
                    <button id="like-btn" class="btn btn-success">👍</button>
                    <button id="dislike-btn" class="btn btn-danger">👎</button>
                </div>
            </div>
        </div>
        {{else if eq .Page "breeds"}}
        <div class="position-relative">
            <input type="text" id="breed-search" class="form-control mb-3" placeholder="Search breeds...">
            <div id="breed-list" class="list-group"></div>
        </div>
        <div id="breed-content"></div>
        {{else if eq .Page "favorites"}}
        <div id="fav-content" class="row"></div>
        {{else}}
        <div class="text-center">
            <h2>Welcome to the Cat Breeds App!</h2>
            <p>Click on one of the tabs above to get started.</p>
        </div>
        {{end}}
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    {{if eq .Page "voting"}}
    <script src="/static/js/voting.js"></script>
    {{else if eq .Page "breeds"}}
    <script src="/static/js/breeds.js"></script>
    {{else if eq .Page "favorites"}}
    <script src="/static/js/favorites.js"></script>
    {{end}}
    
</body>
</html>