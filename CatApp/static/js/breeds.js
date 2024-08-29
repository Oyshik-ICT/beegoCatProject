let breeds = [];

function loadBreeds() {
    $.get('/api/breeds', function(data) {
        breeds = data;
        updateBreedList();
    });
}

function updateBreedList(query = '') {
    const filteredBreeds = breeds.filter(breed => 
        breed.name.toLowerCase().includes(query.toLowerCase())
    );

    let html = '';
    filteredBreeds.forEach(breed => {
        html += `<a href="#" class="list-group-item list-group-item-action" data-breed-id="${breed.id}">${breed.name}</a>`;
    });
    $('#breed-list').html(html);
}

function displayBreed(breedId) {
    const breed = breeds.find(b => b.id === breedId);
    if (breed) {
        $.get(`https://api.thecatapi.com/v1/images/search?limit=8&breed_id=${breedId}`, function(images) {
            let imageSlider = '<div id="breedImageCarousel" class="carousel slide" data-ride="carousel">';
            imageSlider += '<div class="carousel-inner">';
            images.forEach((image, index) => {
                imageSlider += `
                    <div class="carousel-item ${index === 0 ? 'active' : ''}">
                        <img src="${image.url}" class="d-block w-100" alt="${breed.name}">
                    </div>
                `;
            });
            imageSlider += '</div>';
            imageSlider += `
                <a class="carousel-control-prev" href="#breedImageCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#breedImageCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            `;
            imageSlider += '</div>';

            let html = `
                <div class="card mb-3">
                    ${imageSlider}
                    <div class="card-body">
                        <h5 class="card-title">${breed.name}</h5>
                        <p class="card-text">${breed.description}</p>
                        <a href="${breed.wikipedia_url}" target="_blank" class="btn btn-primary">Wikipedia</a>
                    </div>
                </div>
            `;
            $('#breed-content').html(html);
            $('#breedImageCarousel').carousel();
        });
    }
}

$(document).ready(function() {
    loadBreeds();

    $('#breed-search').on('focus', function() {
        $('#breed-list').show();
    });

    $('#breed-search').on('input', function() {
        updateBreedList($(this).val());
        $('#breed-list').show();
    });

    $(document).on('click', function(e) {
        if (!$(e.target).closest('#breed-search, #breed-list').length) {
            $('#breed-list').hide();
        }
    });

    $('#breed-list').on('click', '.list-group-item', function(e) {
        e.preventDefault();
        const breedId = $(this).data('breed-id');
        $('#breed-search').val($(this).text());
        $('#breed-list').hide();
        displayBreed(breedId);
    });
});