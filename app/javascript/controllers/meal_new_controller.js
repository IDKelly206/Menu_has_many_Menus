import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = ["setType", "setUserID", "setMenuID", "addMeal"]
  connect() {
    console.log("Meal New controller")
    console.log(this.setTypeTarget.firstElementChild.value)
    console.log(this.setUserIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => console.log(element.value)))
    console.log(this.setMenuIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => console.log(element.value)))
  }



}
