import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-search-filter"
export default class extends Controller {
  static targets = ["courseSearchFilter", "mealSearchFilter"]
  connect() {
    // console.log("Recipe Search Filter controller")
    // console.dir(this.courseSearchFilterTargets)
  }

  assignCourseFilter(event) {
    let value = event.target.attributes["for"].value
    this.setCourseFilter(value)
  }

  setCourseFilter(value) {
    this.courseSearchFilterTargets.forEach((el) => el.value = value)
  }

  assignMealFilter(event) {
    let value = event.target.attributes["for"].value
    this.setMealFilter(value)
  }

  setMealFilter(value) {
    this.mealSearchFilterTargets.forEach((el) => el.value = value)
  }



}
