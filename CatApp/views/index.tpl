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
            <a class="nav-item nav-link {{if eq .Page "voting"}}active{{end}}" href="/voting">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20v-6M6 20V10M18 20V4"></path></svg>
            Voting</a>
            <a class="nav-item nav-link {{if eq .Page "breeds"}}active{{end}}" href="/breeds">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            Breeds</a>
            <a class="nav-item nav-link {{if eq .Page "favorites"}}active{{end}}" href="/favorites">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
            Favs</a>
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