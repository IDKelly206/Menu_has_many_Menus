import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visability"
export default class extends Controller {
  static targets = [ "hideable" ]

  connect() {
    console.log("Visability controller")
    console.dir(this.hideableTargets)
  }

  showTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = false
    });
  }

  hideTargets() {
    this.hideableTargets.forEach ( el => {
      el.hidden = true
    });
  }

  toggleTargets() {
    console.log("Action - toggle")
    this.hideableTargets.forEach((el) => {
      el.hidden = !el.hidden
    });
  }
}
