import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = [ "grocery" ]

  connect() {
    // console.log("Turbo Modal controller", this.element)
    // const planner = document.getElementById("planner")
    // ids = planner.dataset.courseIds
    // this.openTurboFrame(this.idsValue)
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
  }

  groceryTargetConnected(target) {
    const url = this.groceryTarget.dataset.path
    Turbo.visit(url, { frame: "new_grocery", turbo: true })
  }
}
