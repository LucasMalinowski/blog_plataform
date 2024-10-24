import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = ["postForm"]

  toggleForm() {
    this.postFormTarget.classList.toggle("hidden");

    if (!this.postFormTarget.classList.contains("hidden")) {
      this.postFormTarget.scrollIntoView({ behavior: 'smooth' });
    }
  }
}
