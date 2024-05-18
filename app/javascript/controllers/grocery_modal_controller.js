import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grocery-modal"
export default class extends Controller {
  static values = {
    ids: []
  }
  connect() {
    // console.log("Grocery - Modal")
    // console.log(this.element.attributes)
    // console.log(this.element.attributes[2].value)
    // console.dir(this.element)
    this.openGList(this.idsValue)
  }

  // need src of new_grocery_path
  // need turbo_frame: dom_id(Grocery.new)
  // need ids to send through - course / user / menu / meal_type
  //


  openGList(ids) {
    const url = this.element.attributes[2].value;
    console.log(`turbo visiting ${url}`);
    // const path = new_grocery_path;
    // console.log(`turbo visiting ${path}`);
    if (!ids.length == 0) Turbo.visit(url, { frame: "new_grocery", turbo: true })

  };
}
