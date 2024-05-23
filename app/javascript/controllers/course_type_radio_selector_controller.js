import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "input", "output" ]


  connect() {
    // console.log("Course Type Radio Selector")
    this.setDefaultCourse()
  }

  setDefaultCourse() {
    const value = this.outputTarget.attributes.value.value
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
  }

  selectRadioOption(event) {
    let value = event.target.attributes["for"].value
    console.log(value)
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    // this.outputTarget.attributes["value"].value = value;
    this.outputTargets.forEach((el) =>
      el.value = value
    )
  }
}
