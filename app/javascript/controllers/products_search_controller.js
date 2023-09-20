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
        "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vYXBpLWNlLmtyb2dlci5jb20vdjEvLndlbGwta25vd24vandrcy5qc29uIiwia2lkIjoidnl6bG52Y3dSUUZyRzZkWDBzU1pEQT09IiwidHlwIjoiSldUIn0.eyJhdWQiOiJtZW51aGFzbWFueW1lYWxzLTUwNTMzZWI0MTc5MjA3MDEyNDU1NDBmNTFhM2M2Y2VmOTAwNjc1MzgwMzUzOTY5MjQzNyIsImV4cCI6MTY5NTEzMzM3NSwiaWF0IjoxNjk1MTMxNTcwLCJpc3MiOiJhcGktY2Uua3JvZ2VyLmNvbSIsInN1YiI6ImVmZTE1YjI4LTdlNWUtNTQ5ZC1hMjcyLTA5YTY0OWE3Mjg3NSIsInNjb3BlIjoicHJvZHVjdC5jb21wYWN0IiwiYXV0aEF0IjoxNjk1MTMxNTc1NjQzNDA4MDQwLCJhenAiOiJtZW51aGFzbWFueW1lYWxzLTUwNTMzZWI0MTc5MjA3MDEyNDU1NDBmNTFhM2M2Y2VmOTAwNjc1MzgwMzUzOTY5MjQzNyJ9.HlVsfNtVwxKEdknyx86R5sXSWlVkhOkgWMphOii-0HICOR-eEHx5CjTFh0-mZMDfwNO8h8KzlIfGpkN3LMbdyom80MtTU5D-hl5vMAG77Xo3ZQI4xPyTNjB_m6jEb9wAv6J9qvn9NxRzXQNQcxMlFXVX8Pe1D8KlfOvljODbEYHX_L_-laS0IoVCrzqfrGBAFsyRbAHQcJ_sVgRlbMvOhcee-bgF3hr4fjhj9YkVamJToEo3FIIff9JQskPzWRGQj1h3156Si-sfFuTRwV5VAWD76p4mjl4-XgSg1xMvmGdBmdyrGMLyn7DgfpZYEhTupeOPT3WoCdqqlCGV85sS6Q"
      }
    };
    fetch("https://api-ce.kroger.com/v1/products?filter.term=ricotta&filter.locationId=01400943&filter.fulfillment=ais&filter.limit=40", request_info)
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
