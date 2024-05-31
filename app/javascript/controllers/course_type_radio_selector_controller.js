import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "input", "course", "meal", "setter", "assign" ]


  connect() {
    // console.log("Course Type Radio Selector", this.element)
    // this.setDefaultCourse()
    // const planner = document.getElementById("planner")
    // console.log(planner)
  }

  assignTargetConnected(target) {
    // console.log("Assign target vefify")
    this.setDefaultCourse()
    this.setMealIds()
  }

  setDefaultCourse() {
    const planner = document.getElementById("planner")
    const value = planner.dataset.courseType
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    this.courseTargets.forEach((el) => el.value = value
  )
  }

  setMealIds() {
    const planner = document.getElementById("planner")
    const value = planner.dataset.mealIds
    this.mealTargets.forEach((el) =>
      el.value = value
    )
  }

  selectRadioOption(event) {
    let value = event.target.attributes["for"].value
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    const planner = document.getElementById("planner")
    planner.dataset.courseType = value;
    this.courseTargets.forEach((el) =>
      el.value = value
    )
  }




}
