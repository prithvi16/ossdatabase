import { Controller } from "stimulus";

export default class extends Controller {

  connect() {
    console.log("modal connected");
    this.element[this.identifier] = this;
  }

  static targets = ["panel", "background", "inset", "content"];
  openModal() {
    $(this.insetTarget).addClass("inset-0");

    this.backgroundTarget.classList.remove("opacity-0");
    this.backgroundTarget.classList.add(
      "bg-opacity-75",
      "inset-0",
      "ease-out",
      "duration-300"
    );

    this.panelTarget.classList.remove(
      "opacity-0",
      "translate-y-4",
      "sm:translate-y-0",
      "sm:scale-95"
    );
    this.panelTarget.classList.add(
      "ease-out",
      "duration-300",
      "translate-y-0",
      "sm:scale-100",
      "opacity-100"
    );
  }

  closeModal() {
    this.panelTarget.classList.remove(
      "opacity-100",
      "translate-y-0",
      "sm:scale-100",
      "ease-out",
      "duration-300"
    );
    this.panelTarget.classList.add(
      "opacity-0",
      "translate-y-4",
      "sm:translate-y-0",
      "sm:scale-95",
      "ease-in",
      "duration-200"
    );

    $(this.insetTarget).removeClass("inset-0");

    this.backgroundTarget.classList.remove(
      "bg-opacity-75",
      "inset-0",
      "ease-out",
      "duration-300"
    );
    this.backgroundTarget.classList.add("opacity-0", "ease-in", "duration-200");
  }

  clickOutside(event) {
    const isOutside = event.target.closest(".panel-closest-class");
    if (!isOutside) {
      this.closeModal();
    }
  }

  setModalHtml(html, sizeCss = "sm:max-w-lg") {
    this.panelTarget.classList.add(sizeCss);
    this.contentTarget.innerHTML = html;
  }
}