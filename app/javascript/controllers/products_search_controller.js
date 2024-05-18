import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products-search"
export default class extends Controller {
  static targets = ["searchInput", "results"]

  connect() {
    console.log("Products Search controller");
    console.dir(this.searchInputTarget);
    console.log(this.resultsTarget);
    // this.fetchToken();

    this.fetchProducts();
  }

  //  get Kroger Auth Token
  fetchToken() {
    const formBody = "grant_type=client_credentials&scope=product.compact"
    const request_details = {
      "method": "POST",
      "headers": {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic bWVudWhhc21hbnltZWFscy01MDUzM2ViNDE3OTIwNzAxMjQ1NTQwZjUxYTNjNmNlZjkwMDY3NTM4MDM1Mzk2OTI0Mzc6NFNwWmpLNmkxcHJPX1F0NHpPcVkyZHRRczhUblJqZEFtNGNhQ2hXSw=="
      },
      "body": formBody
    }
    fetch("https://api-ce.kroger.com/v1/connect/oauth2/token", request_details)
    .then(response => response.json())
    // .then((data) => console.log(data));
    .then(data => {
      console.log(data.access_token)
    });
  }




  fetchProducts() {
    // const token = this.fetchToken()
    // const formBody = "filter.term=milk&filter.locationId=01400943&filter.brand=Kroger&filter.fulfillment=ais&filter.limit=20";
    const request_info = {
      "method": "GET",
      "headers": {
        "Content-Type": "application/json",
        "Authorization": ""
      }
    };
    fetch("https://api-ce.kroger.com/v1/products?filter.term=yogurt%20pack&filter.locationId=01400943&filter.fulfillment=ais&filter.limit=40", request_info)
    .then(response => response.json())
    .then(data => console.log(data))

  }







    // fetchProducts(query) {
    //   const url = "https://api-ce.kroger.com/v1/"
    // }





  // var settings = {
  //   "async": true,
  // "https://api-ce.kroger.com/v1/";
  //   "crossDomain": true,
  //   "url": "https://api.kroger.com/v1/products?filter.brand={{BRAND}}&filter.term={{TERM}}&filter.locationId={{LOCATION_ID}}",
  //   "method": "GET",
  //   "headers": {
  //     "Accept": "application/json",
  //     "Authorization": "Bearer #{token}"
  //   }
  // }
  // $.ajax(settings).done(function (response) {
  //   console.log(response);
  // })

  // AJAX request
  // fetch(url, {headers: { "Accept": "text/plain"}})
  //   .then(response => response.text())
  //   .then ((data) => {
  //     console.log(data)
  //   })





  // 'https://api-ce.kroger.com/v1/products?filter.term=milk&filter.locationId=01400943&filter.brand=Kroger&filter.fulfillment=ais&filter.limit=20' \
  // -H 'accept: application/json'

  // https://api-ce.kroger.com/v1/products?
  // HEADER: accept: application/json
  // HEADER: Access Token
  // filter.term=sandwich%20bread&
  // filter.locationId=01400943&
  // filter.brand=Kroger
  // filter.limit=50
  // "Accept": "application/json",







}
