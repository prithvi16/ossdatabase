import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["projectDescription"];

  toggleReadMore(event) {
    this.projectDescriptionTarget.classList.toggle("line-clamp-6");
    if (event.target.innerText === "Read more ↓") {
      event.target.innerText = "Read less ↑";
    } else {
      event.target.innerText = "Read more ↓";
    }
  }
}
