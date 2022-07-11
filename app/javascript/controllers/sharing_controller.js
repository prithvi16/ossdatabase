import { Controller } from "@hotwired/stimulus";
import globalModal from "../utils/constants";

export default class extends Controller {
  openShareWidget(event) {
    globalModal().setModalHtml(this.shareHTML(), "sm:max-w-md");
    globalModal().openModal();
  }

  shareHTML() {
    var template = `
    <div class="mt-3 text-center sm:mt-5">
    <h3 class="text-lg font-medium leading-6 text-gray-900" id="modal-title">
      Share this page
    </h3>
    <div class="mt-2">
      <p class="text-sm text-gray-500">
        Copy and paste the following link to share this profile.
      </p>
    </div>
  </div>
  <div data-controller="clipboard">
    <div class="mt-1">
      <input data-clipboard-target="source" class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" type="text" value="${window.location.href}" readonly>
    </div>
    <div class="mt-5 sm:mt-6">
      <button data-action="click->clipboard#copy" type="button" class="inline-flex justify-center w-full px-4 py-2 text-base font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:text-sm">
        Copy Profile URL
      </button>
    </div>
  </div>`;
    return template;
  }
}
