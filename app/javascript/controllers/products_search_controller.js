import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products-search"
export default class extends Controller {
  connect() {
    console.log("Products Search controller");
    // console.dir(this.searchInputTarget);
    // console.log(this.resultsTarget);

    const request_details = {
      "method": "POST",
      "headers": {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic bWVudWhhc21hbnltZWFscy01MDUzM2ViNDE3OTIwNzAxMjQ1NTQwZjUxYTNjNmNlZjkwMDY3NTM4MDM1Mzk2OTI0Mzc6NFNwWmpLNmkxcHJPX1F0NHpPcVkyZHRRczhUblJqZEFtNGNhQ2hXSw=="
      },
      "data": {
        "grant_type": "client_credentials",
        "scope": "product.compact"
      }
    }
    fetch("https://api-ce.kroger.com/v1/connect/oauth2/token", request_details)
    .then(response => response.json())
    .then(data => console.log(data))

  //   request = HTTParty.post("https://api-ce.kroger.com/v1/connect/oauth2/token",
  //                 :body => {
  //                     :grant_type => "client_credentials",
  //                     :scope => "product.compact"
  //                 }.to_json
  //                 :headers => {
  //                     :Authorization => "Basic bWVudWhhc21hbnltZWFscy01MDUzM2ViNDE3OTIwNzAxMjQ1NTQwZjUxYTNjNmNlZjkwMDY3NTM4MDM1Mzk2OTI0Mzc6NFNwWmpLNmkxcHJPX1F0NHpPcVkyZHRRczhUblJqZEFtNGNhQ2hXSw==",
  //                     :Content-Type => "application/json"
  //                 }
  //    response = JSON.parse(request.body)
  //   console.log(response)
  // }

  // KROGER search
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


  // KROGER get Token


  // Header: 'Content-Type: application/x-www-form-urlencoded'
  // Header: 'Authorization: Basic {{base64(“CLIENT_ID:CLIENT_SECRET”)}}'
  // grant_type=client_credentials&scope={{SCOPE}}
  //  clientCredentials
  // let token = fetch("https://api.kroger.com/v1/connect/oauth2/token",
  // {
  // "method": "GET",
  // "headers": {
  //   "Authorization": 'Basic bWVudWhhc21hbnltZWFscy01MDUzM2ViNDE3OTIwNzAxMjQ1NTQwZjUxYTNjNmNlZjkwMDY3NTM4MDM1Mzk2OTI0Mzc6NFNwWmpLNmkxcHJPX1F0NHpPcVkyZHRRczhUblJqZEFtNGNhQ2hXSwo=',
  //   "Content-type": 'application/x-www-form-urlencoded'
  //   },
  // "grant_type": "grant_type=client_credentials&scope=product.compact"})
  // .then(response => response.json())
  // .then(data => console.log(data))
}


}
