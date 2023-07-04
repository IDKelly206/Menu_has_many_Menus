import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = [ "getMenuID", "getUserID", "getType", "setMenuID", "setUserID", "setType"]
  connect() {
    console.log("Meal New controller")
  }

  get menuIDs() {
    let menuIDs = []
    this.getMenuIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? menuIDs.push(element.value) : 0 )
    return menuIDs
  }

  get userIDs() {
    let userIDS = []
    this.getUserIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? userIDS.push(element.value) : 0 )
    return userIDS
  }

  get mealType() {
    let mealType = this.getTypeTarget.firstElementChild.value
    return mealType
  }


    setMeal(event) {
      event.preventDefault()
      console.log(this.menuIDs)
      this.menuIDs.forEach((menu_id) => {
        this.setMenuIDTarget.insertAdjacentHTML('afterbegin', `<input multiple="multiple" value=${menu_id} type="hidden" name="menu_ids[]" id="menu_ids">`);
      });

      console.log(this.userIDs)
      this.userIDs.forEach((user_id) => {
        this.setUserIDTarget.insertAdjacentHTML('afterbegin', `<input multiple="multiple" value=${user_id} type="hidden" name="user_ids[]" id="user_id">`);
      });

      this.setTypeTarget.value = this.mealType;
    }


}
