// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"



// import { Turbo } from "@hotwired/turbo-rails"
// Turbo.session.drive = false

// Redirect out of turbo frame on-click
// turbo_stream.adv_redirect(XXXX_path )
Turbo.StreamActions.adv_redirect = function() {
  let url = this.getAttribute('url')
  // console.log(url)
  Turbo.visit(url)
}

// Confirmation Modal of Turbo
Turbo.setConfirmMethod((message, element) => {
  console.log(message, element)
  let dialog = document.getElementById('turbo-confirm')
  dialog.querySelector("p").textContent = message
  dialog.showModal();

  return new Promise((resolve, reject) => {
        dialog.addEventListener("close", () => {
              resolve(dialog.returnValue == 'confirm')
        }, { once: true })
  })
})
