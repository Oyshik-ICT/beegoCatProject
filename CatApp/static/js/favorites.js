function displayFavorites() {
    $.get('/api/favorites', function(favorites) {
        let html = '';
        favorites.forEach(fav => {
            html += `
                <div class="col-md-4 mb-3">
                    <img src="${fav.image.url}" alt="Favorite Cat" class="img-fluid">
                </div>
            `;
        });
        $('#fav-content').html(html);
    }).fail(function() {
        alert('Failed to load favorites.');
    });
}

$(document).ready(function() {
    displayFavorites();
});