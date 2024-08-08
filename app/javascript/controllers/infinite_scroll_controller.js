import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infinite-scroll"
export default class extends Controller {
  static targets = ["entries", "pagination"]

  connect() {
    console.log("Infinite Scroll")
    console.log(this.paginationTarget)
    // this.scroll()
  }

  scroll() {
    console.log(window.scrollY)
    const body = document.body,
      html = document.documentElement
    const height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)
    if(window.scrollY >= height - window.innerHeight - 100) {
      console.log("Bottom")
      this.paginationTarget.click()
    }
  }
}
