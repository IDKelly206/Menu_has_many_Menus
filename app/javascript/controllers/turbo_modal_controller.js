import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = [ "grocery" ]

  connect() {
    console.log("Turbo Modal controller")
    // const planner = document.getElementById("planner")
    // ids = planner.dataset.courseIds
    // this.openTurboFrame(this.idsValue)
    console.dir(this.element)
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.element.nextElementSibling.remove()
    this.element.remove()
  }

  groceryTargetConnected(target) {
    // console.log("grocery target acquired")
    const url = this.groceryTarget.dataset.path
    Turbo.visit(url, { frame: "new_grocery", turbo: true })
  }
}
