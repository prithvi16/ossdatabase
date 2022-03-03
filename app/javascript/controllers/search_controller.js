import { Controller } from "stimulus";
import Rails from "@rails/ujs";
let debounce = require("lodash/debounce");

export default class extends Controller {
  static targets = ["form", "resultParent", "loader"];
  initialize() {
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }

  submitForm() {
    // this.loaderTarget.classList.remove("hidden");
    Rails.fire(this.formTarget, "submit");
  }

  triggerSearch() {
    this.submitForm();
  }

  renderResults(event) {
    // this.loaderTarget.classList.add("hidden");
    const [data, status, xhr] = event.detail;
    this.resultParentTarget.innerHTML = xhr.response;
  }
}