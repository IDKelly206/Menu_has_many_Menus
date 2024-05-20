import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-type-radio-selector"
export default class extends Controller {
  static targets = [ "input"]

  connect() {
    console.log("Course Type Radio Selector")
  }

  selectRadioOption() {
    let value = event.target.innerText;
    this.inputTarget.attributes["value"].value = value;
  }
}
