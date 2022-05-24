import { Controller } from "stimulus";
import Rails from "@rails/ujs";
let debounce = require("lodash/debounce");


export default class extends Controller {
  static targets = ["form", "resultParent"];
  connect() 
  {
    console.log("nav search")
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }
  


  triggerSearch(event) {
    var query = event.target.value;
    $.ajax({ 
      url: "/projects/search_suggestions",
      data: { query: query },
      method: "POST",
      success: function(data) {
        this.resultParentTarget.innerHTML = data;
        this.resultParentTarget.classList.remove("opacity-0", "-z-10");
        this.resultParentTarget.classList.add("opacity-100", "z-10");
      }.bind(this)
    });
  }

}