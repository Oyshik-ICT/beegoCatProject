<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cat Breeds</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/styles.css">
</head>
<body>
    <div class="container mt-5">
        <nav class="nav nav-pills nav-justified mb-3">
            <a class="nav-item nav-link" href="/voting">Voting</a>
            <a class="nav-item nav-link active" href="/breeds">Breeds</a>
            <a class="nav-item nav-link" href="/favorites">Favs</a>
        </nav>
        <div class="position-relative">
            <input type="text" id="breed-search" class="form-control mb-3" placeholder="Search breeds...">
            <div id="breed-list" class="list-group"></div>
        </div>
        <div id="breed-content"></div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="/static/js/breeds.js"></script>
</body>
</html>