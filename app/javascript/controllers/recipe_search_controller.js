import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-search"
export default class extends Controller {
  static targets = ["searchInput", "results"]
  connect() {
    console.log("Recipe Search controller")
    console.dir(this.searchInputTarget)
    console.dir(this.resultsTarget);

  }




}
