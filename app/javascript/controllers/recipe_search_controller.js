import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-search"
export default class extends Controller {
  static targets = ["searchInput", "results"]
  static value = { url: String }

  connect() {
    console.log("Recipe Search controller");
    console.dir(this.searchInputTarget);
    console.log(this.resultsTarget);
    fetch(`https://api.edamam.com/api/recipes/v2?type=public&q=duck&app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c&imageSize=SMALL`)
      .then(response => response.json())
      .then((data) => this.insertRecipes(data));
  }


  insertRecipes(data) {
    data.hits.forEach((r) => {
      const recipeCard = `<li class="list-inline-item">
                            <div class="recipe-card">
                              <div class="card-header">
                               <img src=${r.recipe.images.SMALL.url} alt="">
                              </div>
                            <div class="card-body">
                            <p><small>${r.recipe.label}</small></p>
                            <p><small>${r.recipe.source}</small></p>
                            </div>
                            <div class="card-footer">
                            </div>
                          </div>
                          </li>`
    this.resultsTarget.insertAdjacentHTML('beforeend', recipeCard)
    })
  }

  fetchRecipes(query) {
    const type = "type=public";
    const url = "https://api.edamam.com/api/recipes/v2";
    const app_id = "app_id=bb5e4702";
    const api_key = "app_key=7cb8c06cdedbc2d089957cc57703423c";
    const image = "imageSize=THUMBNAIL";
    fetch(`${url}?${type}&q=${query}%20&${app_id}&${api_key}&${image}`)
    .then(response => response.json())
    .then((data) => this.insertRecipes(data))

  }


  submitSearch(event) {
    event.preventDefault()
    this.resultsTarget.innerHTML = "";
    const input = this.searchInputTarget;
    console.log(input.value)
    const query = input.value;
    this.fetchRecipes(query)

  }

}
