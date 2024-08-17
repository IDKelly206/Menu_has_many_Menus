import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-new-form"
export default class extends Controller {
  static targets = [
    "courseRadioInput","formCourseType", "formMealIds", "newRecipes"
  ]

  connect() {
    console.log("Course New Form controller")
    // console.dir(this.courseRadioInputTargets)
    this.setInitialSelection()
  }

  assignCourseType(event) {
    let value = event.target.attributes["for"].value
    this.setCourseType(value)
  }

  // Set radio button for course_type selection
  setInitialSelection() {
    const planner = document.getElementById("Meal Planner")
    const value = planner.dataset.courseType
    this.courseRadioInputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
  }

  //  Assign meal_ids to course#new form
  setMealIds() {
    console.log("set Meal IDs")
    const planner = document.getElementById("Meal Planner")
    const value = planner.dataset.mealIds
    this.formMealIdsTargets.forEach((el) => el.value = value)
  }

  // Assign course_type to course#new form
  setCourseType(value) {
    console.log("set Course Type")
    const planner = document.getElementById("Meal Planner")
    planner.dataset.courseType = value
    this.formCourseTypeTargets.forEach((el) => el.value = value)
  }

  newRecipesTargetConnected(target) {
    console.log("Set course form details for new recipes")
    const planner = document.getElementById("Meal Planner")
    console.log(planner)
    const value = planner.dataset.courseType
    console.log(value)
    this.setCourseType(value)
    this.setMealIds()
  }
}
