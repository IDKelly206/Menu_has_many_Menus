import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = ["option", "input"]

  connect() {
    console.log("Course Type Radio Selector")
    console.log(this.optionTargets)
  }

  selectRadioOption() {
    this.optionTargets.forEach((el, i) => {
      el.classList.toggle("checked", event.target == el)
    })
    this.inputTarget.value = event.target.innerText
  }
}
