import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh-frame"
export default class extends Controller {
  static values = {
    src: String
  }
  static targets = [ "plannerCourses", "refreshCourses" ]

  connect() {
    console.log("Refresh Frame controller")
    // console.dir(this.plannerCoursesTarget)
    // console.log(this.plannerCoursesTarget.src)

    // this.refresh()
  }

  // refresh() {
  //   this.plannerCoursesTarget.reload()
  // }

  refreshCoursesTargetConnected(target) {
    console.log("Refresh Courses target acquired")
    this.plannerCoursesTarget.reload()
  }

}
