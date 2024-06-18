import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visability"
export default class extends Controller {
  static targets = [ "hideable" ]

  connect() {
    console.log("Visability controller")
    console.dir(this.hideableTargets)
  }

  showTarget(el) {
    // el.removeEventListener('transitionend', listener);

    // el.hidden = false;
    el.removeAttribute('hidden')

    const reflow = el.offsetHeight;

    el.classList.add('is-open')

      // // Get natural height of element
      // var getHeight = function () {
      //   el.style.display = 'block'; //Make it visible
      //   var height = el.scrollHeight + 'px'; //Get it's height
      //   el.style.display = ''; //Hide display again
      //   return height
      // }

      // var height = getHeight(); //Get natural height
      // el.classList.remove('is-hidden'); // Make element visible
      // el.style.height = height; // Update max-height

      // window.setTimeout(function () {
      //   el.style.height = '';
      // }, 1000);
  };

  listener(el) {
    el.setAttribute('hidden', true)
    // el.hidden = true;
    el.removeEventListener('transitionend', listener)
  };

  hideTarget(el) {
    el.setAttribute('hidden', true)
    el.classList.remove('is-open')




      // el.style.height = el.scrollHeight + 'px'; // Give # to change from

      // // Set height back to zero
      // window.setTimeout(function() {
      //   el.style.height = '0';
      // }, 10);

      // //When transition compelte add class is-hidden
      // window.setTimeout(function () {
      //   el.classList.add('is-hidden');
      // }, 700);
  };

  toggleTargets() {
    console.log("Action - toggle")
    this.hideableTargets.forEach((el) => {
      // el.hidden = !el.hidden
      // this.hideTargets();

      if (el.classList.contains('is-open')) {
        this.hideTarget(el)
        return;
      }

      this.showTarget(el)

      // if (el.classList.contains('is-hidden')) {
      //   this.showTarget(el)
      //   return;
      // } else {
      //   this.hideTarget(el);
      // }

    });

  }
}
