import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-search-filter"
export default class extends Controller {
  static targets = ["courseSearchFilter", "mealSearchFilter", "healthSearchFilter"]
  connect() {
    console.log("Recipe Search Filter controller")
    console.dir(this.mealSearchFilterTargets)
    console.dir(this.healthSearchFilterTargets)
  }

  assignCourseFilter(event) {
    let value = event.target.attributes["for"].value
    console.log(value)
    this.setCourseFilter(value)
  }

  setCourseFilter(value) {
    this.courseSearchFilterTargets.forEach((el) => el.value = value)
  }

  assignMealFilter(event) {
    let value = event.target.attributes["for"].value
    // console.log(value)
    this.setMealFilter(value)
  }

  setMealFilter(value) {
    this.mealSearchFilterTargets.forEach((el) => el.value = value)
  }


  assignHealthFilter(event) {
    let value = event.target.attributes["for"].value
    this.setHealthFilter(value)
  }

  setHealthFilter(value) {
    let filter_value  = this.healthSearchFilterTargets[0].value;

    let filters = []

    if (filter_value.length > 1) {
      filters = filter_value.split(" ")
    } else {
      filters = []
    }

    if (filters.includes(value)) {
      let i = filters.indexOf(value);
      filters.splice(i, 1);
      this.healthSearchFilterTargets[0].value = filters.join(" ")
    } else {
      filters.push(value)
      this.healthSearchFilterTargets[0].value = filters.join(" ")
    }
  }




}
