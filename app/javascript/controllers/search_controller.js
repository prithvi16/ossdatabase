import { Controller } from "@hotwired/stimulus";
let debounce = require("lodash/debounce");
import SlimSelect from "slim-select";

export default class extends Controller {
  static targets = ["form", "resultParent", "selectLicenseInput", "selectTechInput", "selectPlatformInput", "selectUsecaseInput"];
  connect() {
 

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

    new SlimSelect({
      select: this.selectLicenseInputTarget,
      onChange: this.submitForm.bind(this),
    });
    this.triggerSearch = debounce(this.triggerSearch, 500).bind(this);
  }
  
  submitForm() {
    this.formTarget.requestSubmit();
  }

  triggerSearch() {
    this.submitForm();
  }
}