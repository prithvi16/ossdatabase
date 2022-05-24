import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";
let debounce = require("lodash/debounce");
import SlimSelect from "slim-select";

export default class extends Controller {
  static targets = ["form", "resultParent", "loader", "selectLicenseInput", "selectTechInput", "selectPlatformInput", "selectUsecaseInput"];
  connect() {
    new SlimSelect({
      select: this.selectLicenseInputTarget,
      onChange: this.submitForm.bind(this),
    });

    new SlimSelect({
      select: this.selectTechInputTarget,
      onChange: this.submitForm.bind(this),
    });

    new SlimSelect({
      select: this.selectUsecaseInputTarget,
      onChange: this.submitForm.bind(this),
    });

    new SlimSelect({
      select: this.selectPlatformInputTarget,
      onChange: this.submitForm.bind(this),
    });
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }
  
  submitForm() {
    // this.loaderTarget.classList.remove("hidden");
    Rails.fire(this.formTarget, "submit");
  }

  triggerSearch() {
    
  }

  renderResults(event) {
    // this.loaderTarget.classList.add("hidden");
    const [data, status, xhr] = event.detail;
    this.resultParentTarget.innerHTML = xhr.response;
  }
}