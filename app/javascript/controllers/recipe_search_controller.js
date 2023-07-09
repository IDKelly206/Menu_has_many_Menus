import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-search"
export default class extends Controller {
  static targets = ["searchInput", "results"]
  static value = { url: String }

  connect() {
    console.log("Recipe Search controller");
    console.dir(this.searchInputTarget);
    console.log(this.resultsTarget);
    fetch(`https://api.edamam.com/api/recipes/v2?type=public&q=chicken%20&app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c&mealType=Dinner&imageSize=REGULAR`)
      .then(response => response.json())
      .then((data) => console.log(data));

  }


  insertRecipes(data) {
    data.hits.forEach((recipe) => {
      const recipeCard = `<li class="list-inline-item">
                            <img src=${recipe.recipe.image} alt="">
                            <p>${recipe.recipe.label}</p>
                            <p>${recipe.recipe.source}</p>
                          </li>`
    this.resultsTarget.insertAdjacentHTML('beforeend', recipeCard)
    })
  }

  findMovies(query) {
    const type = 'type=public';
    const url = "https://api.edamam.com/api/recipes/v2";
    const api_key = "7cb8c06cdedbc2d089957cc57703423c";
    const api_id = "bb5e4702";
    fetch(`${url}?${type}&q=${query}%20&${api_id}&${api_key}`)
    .then(response => response.json())
    .then(this.insertRecipes())
  }

  submitSearch(event) {
    event.preventDefault()
    this.resultsTarget.innerHTML = "";
    const input = this.searchInputTarget;
    console.log(input.value)
    this.findMovies(input.value)
  }

}
