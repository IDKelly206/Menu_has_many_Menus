import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "input", "output", "setter", "assign" ]


  connect() {
    console.log("Course Type Radio Selector", this.element)
    this.setDefaultCourse()
    // console.log(this.assignTargets)
  }

  assignTargetConnected(target) {
    console.log("Assign target vefify")
    // console.dir(this.assignTarget)
    this.setDefaultCourse()
  }

  setDefaultCourse() {
    const value = this.setterTarget.attributes.value.value
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    this.outputTargets.forEach((el) => el.value = value
  )
  }

  selectRadioOption(event) {
    let value = event.target.attributes["for"].value
    console.log(value)
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    this.setterTarget.attributes["value"].value = value;
    this.outputTargets.forEach((el) =>
      el.value = value
    )
  }




}
