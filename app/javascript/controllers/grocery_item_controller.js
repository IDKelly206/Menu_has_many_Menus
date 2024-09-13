import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grocery-item"
export default class extends Controller {
  static targets = [ "gItemNew", "gItemList"]


  connect() {
    console.log("Grocery Item controller")
    // console.dir(this.gItemNewTargets)
    // console.dir(this.gItemListTargets)
    // const toggleTargets = document.getElementsByClassName("toggle");
    // console.log(toggleTargets)
    // this.selectGListItem()
  }


  selectGListItem(event) {
    console.log("gList Item event")
    // console.log(event.target)
    // console.dir(event.target)

    const element = event.target
    if (element.checked == true) {
      if (element.parentElement.dataset.groceryItemTarget == 'gItemList') {
        event.target.parentElement.style["background"] = 'gray';
      }
      if (element.parentElement.dataset.groceryItemTarget == 'gItemNew') {
        event.target.parentElement.style["background"] = '';
      }

    } else {
      if (element.parentElement.dataset.groceryItemTarget == 'gItemList') {
        event.target.parentElement.style["background"] = '';
      }
      if (element.parentElement.dataset.groceryItemTarget == 'gItemNew') {
        event.target.parentElement.style["background"] = 'gray';
      }
    }
  }

}
