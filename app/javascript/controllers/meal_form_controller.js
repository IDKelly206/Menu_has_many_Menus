import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-form"
export default class extends Controller {
  connect() {
    console.log("Meal Form controller")
  }
}
