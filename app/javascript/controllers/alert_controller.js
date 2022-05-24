import { Controller } from "@hotwired/stimulus";
import { Notyf } from "notyf";
import "notyf/notyf.min.css"; // for React, Vue and Svelte

export default class extends Controller {
  static targets = ["origin"];
  connect() {
    var message = this.originTarget.dataset.message;
    var messageType = this.originTarget.dataset.messageType;
    const notyf = new Notyf({
      duration: 4000,
      position: { x: "center", y: "top" },
      dismissible: true,
    });
    if (messageType == "alert") {
      notyf.error(message);
    } else {
      notyf.success(message);
    }
  }
}
