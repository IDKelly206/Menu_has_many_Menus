import { Controller } from "@hotwired/stimulus"
// import { get, post } from '@rails/request.js'
// Connects to data-controller="fetch-recipes-turbo"
export default class extends Controller {
  connect() {
    console.log("Fetch Recipes turbo controller")
  }
  
  getTurboSteam(event) {
    event.preventDefault()
    get(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }
  postTurboSteam(event) {
    event.preventDefault()
    post(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }
}
