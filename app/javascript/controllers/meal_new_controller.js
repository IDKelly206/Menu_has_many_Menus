import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-new"
export default class extends Controller {
  static targets = [ "getType", "getUserID", "getMenuID", "setType", "setUserID", "setMenuID", "errorMessage"]
  connect() {
    // console.log("Meal New controller")
    console.dir(this.getTypeTarget)
    // console.log(this.getUserIDTarget)
    // console.log(this.getMenuIDTarget)
    // console.log(this.setTypeTraget)
    // console.log(this.setUserIDTarget)
    // console.log(this.setMenuIDTarget)
    // console.log(this.errorMessageTarget)
    this.showModal;
  }

  get mealType() {
    let mealType = this.getTypeTarget.firstElementChild.value
    return mealType
  }

  get userIDs() {
    let userIDS = []
    this.getUserIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? userIDS.push(element.value) : 0 )
    return userIDS
  }

  get menuIDs() {
    let menuIDs = []
    this.getMenuIDTarget.querySelectorAll("input[type='checkbox']").forEach(element => element.checked ? menuIDs.push(element.value) : 0 )
    return menuIDs
  }

  get setMealType() {
    return this.setTypeTarget.value = this.mealType;
  }

  get setUserIDs() {
    this.userIDs.map((user_id) => {
      return this.setUserIDTarget.insertAdjacentHTML('afterbegin', `<input multiple="multiple" value=${user_id} type="hidden" name="user_ids[]" id="user_id">`)
    });
  }

  get setMenuIDs() {
    this.menuIDs.forEach((menu_id) => {
      return this.setMenuIDTarget.insertAdjacentHTML('beforeend', `<input multiple="multiple" value=${menu_id} type="hidden" name="menu_ids[]" id="menu_ids">`)
    });
  }

  get deleteMessages() {
    this.errorMessageTarget.innerHTML = "";
  }

  setMeal(event) {
    event.preventDefault()
    // console.log(this.mealType)
    // console.log(this.menuIDs.length)
    // console.log(this.userIDs.length)


    if ( this.mealType == "" ) {
        this.errorMessageTarget.insertAdjacentHTML('beforeend', `<p style="color:red">Selection of meal required</p>`);
      } else if ( this.userIDs.length == 0 ) {
          this.deleteMessages;
          this.errorMessageTarget.insertAdjacentHTML('beforeend', `<p style="color:red">Selection of user(s) required</p>`);
      } else if ( this.menuIDs.length == 0 ) {
          this.deleteMessages;
          this.errorMessageTarget.insertAdjacentHTML('beforeend', `<p style="color:red">Selection of date(s) required</p>`);
      } else {
          this.setMealType; this.setUserIDs; this.setMenuIDs;
          document.getElementById("closeMeal").click();
          this.hideModal;
      }
    }

    get hideModal() {
      document.getElementById("closeMeal").click();
    }

    get showModal() {
      document.getElementById("openMeal").click();

    }


  }

      // Need to reset form as blank.
    // Why two showing when directed to page?
