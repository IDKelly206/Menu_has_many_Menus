import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visability"
export default class extends Controller {
  static targets = [ "hideableDiv", "hideableFlex" ]

  connect() {
    console.log("Visability controller")
  }

  showDivTarget(el) {
    // Get natural height of element
    var getHeight = function () {
      el.style.display = 'block'; //Make it visible
      var height = el.scrollHeight + 'px'; //Get it's height
      el.style.display = ''; //Hide display again
      return height
    }
    var height = getHeight(); //Get natural height
    el.classList.remove("div-hidden"); // Make element visible
    el.style.height = height; // Update max-height
    window.setTimeout(function () {
      el.style.height = '';
    }, 1500);

  // // Attemp (2nd) [is-oepn] using hidden + transform(translateY())
    // el.removeEventListener('transitionend', listener);
    // el.hidden = false;
    // el.removeAttribute('hidden')
    // const reflow = el.offsetHeight;
    // el.classList.add('is-open')
  };

  hideDivTarget(el) {
    // Attempt (1st) [div-hidden] using height set and decrease
    el.style.height = el.scrollHeight + 'px'; // Give # to change from
    // Set height back to zero
    window.setTimeout(function() {
      el.style.height = '0';
    }, 1500);
    //When transition compelte add class div-hidden
    window.setTimeout(function () {
      el.classList.add("div-hidden");
    }, 1500);

    // // Attemp (2nd) [is-oepn] using hidden + transform(translateY())
    // listener(el) {
    //   el.setAttribute('hidden', true)
    //   // el.hidden = true;
    //   el.removeEventListener('transitionend', listener)
    // };
    // el.setAttribute('hidden', true)
    // el.classList.remove('is-open')
  };

  toggleTargets() {
    // console.log("Action - toggle")

    // Div collapse toggle
    // target: hideableDiv & class: hideable-div & div-hidden
    this.hideableDivTargets.forEach((el) => {
      if (el.classList.contains("div-hidden")) {
        this.showDivTarget(el)
        return;
      }
      this.hideDivTarget(el);
    });

    // Flexbox collapse toggle
    // target: hideableFlex & class: hideable-flex + flex-collapsed
    this.hideableFlexTargets.forEach((el) => {
      el.classList.toggle("flex-collapsed")
    });


      // // Attemp (2nd) [is-oepn] using hidden + transform(translateY())
      // el.hidden = !el.hidden
      // this.hideTargets();
      // if (el.classList.contains('is-open')) {
      //   this.hideTarget(el)
      //   return;
      // }
      // this.showTarget(el)
  }
}
