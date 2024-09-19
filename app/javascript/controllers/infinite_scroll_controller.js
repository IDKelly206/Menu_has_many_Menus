import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infinite-scroll"
export default class extends Controller {
  static targets = ["entries", "pagination"]

  connect() {
    console.log("Infinite Scroll")

    console.log(
      document.getElementById('recipes').scrollHeight,
      document.getElementById('recipes').offsetHeight,
      document.getElementById('recipes').clientHeight
    )
  }

  scroll() {
    // console.log("Scroll started")
    const body = document.getElementById('recipes'),
          html = document.documentElement
    const height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    // console.log(body.scrollTop)
    // !! ISSUE: runs multiple times b/c of a calc. Run once & stop.
    // if(body.scrollTop >= height - body.clientHeight - 200) {
    //   // console.log("Bottom")
    //   this.paginationTarget.click()
    // }
  }
}
