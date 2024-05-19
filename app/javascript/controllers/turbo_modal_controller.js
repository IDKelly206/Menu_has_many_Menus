import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static values = {
    ids: []
  }

  connect() {
    // console.log("Turbo Modal controller")
    // console.log(this.element.parentElement)
    this.openTurboFrame(this.idsValue)
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
  }

  openTurboFrame(ids) {
    const url = this.element.attributes["data-path"].value;
    console.log(`turbo visiting ${url}`);
    if (!ids.length == 0) Turbo.visit(url, { frame: "new_grocery", turbo: true })
  };
}
