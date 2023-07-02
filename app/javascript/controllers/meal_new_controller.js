import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = [ "getMenuID", "getUserID", "getType", "setMenuID", "setUserID", "setType"]
  connect() {
    console.log("Meal New controller")

    // let menuIDs = []
    // this.getMenuIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? menuIDs.push(element.value) : 0 )
    // console.log(this.menuIDs)

    // console.log(this.getMenuIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? console.log(element.value) : 0 ))
    // console.log(this.getMenuIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => console.log(element.value)))
    // console.log(this.getUserIDTarget.querySelectorAll("input[type='checkbox'][checked='checked']").forEach(element => console.log(element.value)))
    // console.log(this.getTypeTarget.firstElementChild.value)
    console.log(this.setMenuIDTarget)

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
      this.menuIDs.forEach(menu_id =>
        let formField = <%= f.hidden_field :menu_ids, multiple: true, value: (menu_id) %>

        this.setMenuIDTarget.insertAdjacentElement("afterbegin", formField))



      // this.setMenuIDTarget.value = this.menuIDs;
      this.setUserIDTarget.value = this.userIDs;
      this.setTypeTarget.value = this.mealType;
    }


}
