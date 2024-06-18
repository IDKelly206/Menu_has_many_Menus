import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visability"
export default class extends Controller {
  static targets = [ "hideable" ]

  connect() {
    console.log("Visability controller")
    console.dir(this.hideableTargets)
  }

  showTarget(el) {
      // Get natural height of element
      var getHeight = function () {
        el.style.display = 'block'; //Make it visible
        var height = el.scrollHeight + 'px'; //Get it's height
        el.style.display = ''; //Hide display again
        return height
      }

      var height = getHeight(); //Get natural height
      el.classList.remove('is-hidden'); // Make element visible
      el.style.height = height; // Update max-height

      window.setTimeout(function () {
        el.style.height = '';
      }, 1000);
  }

  hideTarget(el) {
      el.style.height = el.scrollHeight + 'px'; // Give # to change from

      // Set height back to zero
      window.setTimeout(function() {
        el.style.height = '0';
      }, 10);

      //When transition compelte add class is-hidden
      window.setTimeout(function () {
        el.classList.add('is-hidden');
      }, 700);
  }

  toggleTargets() {
    console.log("Action - toggle")
    this.hideableTargets.forEach((el) => {
      // el.hidden = !el.hidden
      // this.hideTargets();

      if (el.classList.contains('is-hidden')) {
        this.showTarget(el)
        return;
      } else {
        this.hideTarget(el);
      }

    });

  }
}
