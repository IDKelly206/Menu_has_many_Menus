import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = ["setType", "setUser", "addMeal"]
  connect() {
    console.log("Meal New controller")
    console.log(this.setTypeTarget.firstElementChild.value)
    console.log(this.setUserTarget.value)
  }



}
