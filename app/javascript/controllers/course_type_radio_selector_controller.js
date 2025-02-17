import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "input", "course", "meal"]

//   <div>
//   <%# <%= select_mealtypes(ft, types: @meal_types, type: @meal_type) %> %>
//   <%# <%= select_coursetypes(ft, types: @course_types, type: @course_type) %> %>
// </div>


  connect() {
    console.log("Course Type Radio Selector", this.element)
    // this.setDefaultCourse()
    // const planner = document.getElementById("planner")
    // console.log(planner)
    this.assignTargetConnected()
  }

  assignTargetConnected() {
    console.log("Assign target vefify")
    this.setDefaultCourse()
    this.setMealIds()
  }

  setDefaultCourse() {
    // Get Planner data
    const planner = document.getElementById("Meal Planner")
    // Assign course value
    const value = planner.dataset.courseType
    // Set radio button for course_type selection
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    // Assign course_type to course#new form
    this.courseTargets.forEach((el) => el.value = value
   )
  }

  setMealIds() {
    // Get Planner data
    const planner = document.getElementById("Meal Planner")
    // Assign meal_ids value
    const value = planner.dataset.mealIds
    // Assign meal_ids to course#new form
    this.mealTargets.forEach((el) =>
      el.value = value
    )
  }

  selectRadioOption(event) {
    // set value of selected input
    let value = event.target.attributes["for"].value
    // check option selcted and uncheck prior option
    this.inputTargets.forEach((el) => {
      el.value === value ? el.checked = true : el.checked = false
    })
    // Get Planner data
    const planner = document.getElementById("Meal Planner")
    // Set new course_type selection in Planner data
    planner.dataset.courseType = value;
    // Assign course_type to course#new form
    this.courseTargets.forEach((el) =>
      el.value = value
    )
  }
}
