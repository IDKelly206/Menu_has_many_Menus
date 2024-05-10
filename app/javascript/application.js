// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"


import { Turbo } from "@hotwired/turbo-rails"
// Turbo.session.drive = false

// turbo_stream.action(:redirect, XXXX_path )
Turbo.StreamActions.adv_redirect = function() {
  console.log(this.target)
  Turbo.visit(this.target)
}
