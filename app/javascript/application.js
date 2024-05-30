// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"



import { Turbo } from "@hotwired/turbo-rails"
// Turbo.session.drive = false

// turbo_stream.adv_redirect(XXXX_path )
Turbo.StreamActions.adv_redirect = function() {
  // console.log(this.target)
  let url = this.getAttribute('url')
  // console.log(url)
  Turbo.visit(url)
}
