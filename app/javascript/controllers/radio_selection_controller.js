import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="radio-selection"
export default class extends Controller {
  static targets = [ "radioInput"]

  connect() {
    console.log("Radio Selection controller")
  }

  selectRadioOption(event) {
    // set value of selected input
    let value = event.target.attributes["for"].value
    // check option selcted and uncheck prior option
    this.radioInputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
  }
}
