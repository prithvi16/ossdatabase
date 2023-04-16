import { Controller } from "@hotwired/stimulus";
let debounce = require("lodash/debounce");
import morphdom from "morphdom";

export default class extends Controller {
  static targets = ["form", "resultParent"];
  connect() {
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }

  clickOutside(event) {
    event.preventDefault();
    this.resultParentTarget.classList.add("opacity-0", "-z-10");
    this.resultParentTarget.classList.remove("opacity-100", "z-10");
  }

  triggerSearch(event) {
    var query = event.target.value;
    if (query.length > 2) {
      $.ajax({
        url: "/projects/search_suggestions",
        data: { query: query },
        method: "POST",
        success: function (data) {
          morphdom(this.resultParentTarget, data);
          this.resultParentTarget.children[0].children[0].focus();
          this.resultParentTarget.classList.remove("opacity-0", "-z-10");
          this.resultParentTarget.classList.add("opacity-100", "z-10");

          // Add event listener for keyboard navigation
          this.resultParentTarget.addEventListener("keydown", (event) => {
            this.handleKeyNavigation(event);
          });
        }.bind(this),
      });
    }
  }

  handleKeyNavigation(event) {
    const { key } = event;
    const activeElement = document.activeElement;
    const isLink = activeElement.tagName === "A";

    if (key === "ArrowDown") {
      event.preventDefault();
      if (isLink && activeElement.parentElement.nextElementSibling) {
        activeElement.parentElement.nextElementSibling.children[0].focus();
      } else {
        this.resultParentTarget.children[0].children[0].focus();
      }
    } else if (key === "ArrowUp") {
      event.preventDefault();
      if (isLink && activeElement.parentElement.previousElementSibling) {
        activeElement.parentElement.previousElementSibling.children[0].focus();
      } else {
        this.resultParentTarget.lastElementChild.children[0].focus();
      }
    } else if (key === "Enter" && isLink) {
      window.location.href = activeElement.href;
    }
  }
}
