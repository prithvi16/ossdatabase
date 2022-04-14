import { Controller } from "stimulus";
import globalModal  from "../utils/constants";

export default class extends Controller {
  static values = {
    projectId: String
  }

  openProjectPreview(event) {
    $.ajax({
      type: "GET",
      url: `/projects/${this.projectIdValue}/preview`,
      success: function (response) {
        globalModal().setModalHtml(response, "sm:max-w-3xl");
        globalModal().openModal();
      }.bind(this),
      error: function (response) {},
    });
  }
}