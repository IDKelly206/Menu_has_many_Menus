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
  // console.log(message, element)
  // console.dir(element)
  let cancel_text = element.dataset.turboConfirmCancelLabel
  let confirm_text = element.dataset.turboConfirmConfirmLabel
  let dialog = document.getElementById('turbo-confirm')

  dialog.querySelector("h3").textContent = message
  dialog.querySelector('button[value="confirm"]').textContent = confirm_text
  dialog.querySelector('button[value="cancel"]').textContent = cancel_text
  dialog.showModal();

  return new Promise((resolve, reject) => {
        dialog.addEventListener("close", () => {
              resolve(dialog.returnValue == 'confirm')
        }, { once: true })
  })
})
