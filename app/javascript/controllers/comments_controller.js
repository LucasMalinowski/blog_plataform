import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments"
export default class extends Controller {
  static targets = ["commentsList", "commentForm"]

  toggleComments() {
    this.commentsListTarget.classList.toggle("hidden");
  }

  toggleForm() {
    this.commentFormTarget.classList.toggle("hidden");

    if (!this.commentFormTarget.classList.contains("hidden")) {
      this.commentFormTarget.scrollIntoView({ behavior: 'smooth' });
    }
  }
}
