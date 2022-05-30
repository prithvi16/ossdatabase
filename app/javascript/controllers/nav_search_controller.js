import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from 'stimulus-use'
let debounce = require("lodash/debounce");


export default class extends Controller {
  static targets = ["form", "resultParent"];
  connect() 
  {
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }

  clickOutside(event) {
    // example to close a modal
    event.preventDefault()
    this.resultParentTarget.classList.add("opacity-0", "-z-10");
    this.resultParentTarget.classList.remove("opacity-100", "z-10");
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