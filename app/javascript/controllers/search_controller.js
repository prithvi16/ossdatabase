import { Controller } from "stimulus";
import Rails from "@rails/ujs";
let debounce = require("lodash/debounce");
import SlimSelect from "slim-select";

export default class extends Controller {
  static targets = ["form", "resultParent", "loader", "selectInput"];
  initialize() {
    new SlimSelect({
      select: this.selectInputTarget,
      onChange: this.submitForm.bind(this),
    });
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