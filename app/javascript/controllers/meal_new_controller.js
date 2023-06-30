import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = [ "getMenuID", "getUserID", "getType", "setMenuID", "setUserID", "setType"]
  connect() {
    console.log("Meal New controller")
    console.log(this.getMenuIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => console.log(element.value)))
    console.log(this.getUserIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => console.log(element.value)))
    console.log(this.getTypeTarget.firstElementChild.value)
    console.log(this.setTypeTarget.value)

  }

  setMeal(event) {
    event.preventDefault()
    this.setMenuIDTarget.value = this.menuIDs;
    this.setUserIDTarget.value = this.userIDs;
    this.setTypeTarget.value = this.mealType;
  }

  get menuIDs() {
    let menuIDs = []
    this.getMenuIDTarget.querySelectorAll("input[type='checkbox'][checked=true]").forEach(element => menuIDs.push(element.value))
    return menuIDs
  }

  get userIDs() {
    let userIDS = []
    this.getUserIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => userIDS.push(element.value))
    return userIDS
  }

  get mealType() {
    let mealType = this.getTypeTarget.firstElementChild.value
    return mealType
  }



}
