import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"
export default class extends Controller {
  static targets = ["modal", "largeImage", "thumbnail"];

  displayImage(event) {
    const thumbnail = event.currentTarget.querySelector("img");
    const imageUrl = thumbnail.src;

    this.largeImageTarget.src = imageUrl;
    this.modalTarget.classList.remove("hidden");
  }

  closeModal() {
    this.modalTarget.classList.add("hidden");
    this.largeImageTarget.src = ""; // Clear the image to optimize memory
  }
}
