const list = document.querySelector('#results');

const insertMovies = (data) => {
  data.Search.forEach((result) => {
    const movie = `<li>
      <img src="${result.Poster}" alt="" height="150px" />
    </li>`;
    list.insertAdjacentHTML('beforeend', movie);
  });
};

const fetchMovies = (query) => {
  fetch(`http://www.omdbapi.com/?s=${query}&apikey=adf1f2d7`)
    .then(response => response.json())
    .then(insertMovies);
};

const updateList = (event) => {
  event.preventDefault();
  list.innerHTML = '';
  const input = document.querySelector('#search-input');
  fetchMovies(input.value);
};

export { fetchMovies, updateList };
