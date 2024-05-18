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
      // .then((data) => console.log(data))
      .then((data) => this.insertRecipes(data));
  }


  insertRecipes(data) {
    data.hits.forEach((r) => {
      // const recipe_id = `${r.recipe._links.self.href}`
      const recipeCard = `<li class="list-inline-item">
                            <div class="recipe-card">
                              <div class="card-header">
                                <p>Image insert</p>
                              </div>
                            <div class="card-body">
                            <p><small>Name: ${r.recipe.label}</small></p>
                            <p><small>Source: ${r.recipe.source}</small></p>
                            <p><small>Servings: ${r.recipe.yield}</small></p>
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
    const app_id = ;
    const api_key = ;
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
