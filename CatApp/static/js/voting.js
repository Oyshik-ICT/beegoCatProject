let config = {};

function loadConfig() {
    return $.get('/api/config', function(data) {
        config = data;
    });
}

function addFavorite(imageId) {
    $.ajax({
        url: 'https://api.thecatapi.com/v1/favourites',
        type: 'POST',
        contentType: 'application/json',
        headers: {
            "Accept": "*/*",
            "x-api-key": config.catapi_key
        },
        data: JSON.stringify({
            image_id: imageId,
            sub_id: config.user_sub_id
        }),
        success: function(response) {
            if (response.id) {
                alert('Image added to favorites!');
                loadRandomImage();
            } else {
                alert('Failed to add image to favorites: ' + (response.error || 'Unknown error'));
            }
        },
        error: function(xhr, status, error) {
            alert('An error occurred while adding to favorites: ' + error);
        }
    });
}

function loadRandomImage() {
    $.get('/api/random-image', function(data) {
        $('#cat-image').attr('src', data.url).data('image-id', data.id);
    });
}

$(document).ready(function() {
    loadConfig().done(function() {
        loadRandomImage();
        $('#like-btn, #dislike-btn').click(loadRandomImage);
        $('#fav-btn').click(function() {
            var imageId = $('#cat-image').data('image-id');
            if (imageId) {
                addFavorite(imageId);
            } else {
                alert('No image to favorite');
            }
        });
    });
});
