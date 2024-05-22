import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "label", "input", "output"]

  connect() {
    console.log("Course Type Radio Selector")
    console.dir(this.inputTarget.attributes )
    console.dir(this.labelTarget)

  }

  selectRadioOption(event) {
    let value = event.target.innerText;
    // console.log(value)
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    this.outputTarget.attributes["value"].value = value;
  }
}
