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
    console.log(event.target)
    console.dir(event.target)
    // console.log(event.target.checked.value)
    // console.dir(event.target.parentElement.style["background"])
    const element = event.target
    // console.log(event.target.parentElement.dataset.groceryItemTarget)
    // if (element.parentElement.dataset.groceryItemTarget == 'gItemNew') {
    //   if (element.checked == true) {
    //     event.target.parentElement.style["background"] = 'gray';
    //     } else {
    //     event.target.parentElement.style["background"] = '';
    //   }

    //   else {
    //   if (element.checked == false) {
    //     event.target.parentElement.style["background"] = 'gray';
    //     } else {
    //     event.target.parentElement.style["background"] = '';
    //     }
    //   }
    // }

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


    // if equals gItemNew

    // console.log(event.target.checked)
    // if true <below>= gray
    // console.log(event.target.parentElement.style["background"])
    // else = ""





    // this.gItemListTargets.forEach((item) => {
    //   console.log(item.children)
    // })
  }

}
