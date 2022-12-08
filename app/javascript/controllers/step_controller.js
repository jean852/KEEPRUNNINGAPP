import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "step1", "step2" ]
  connect() {
    console.log("ERddddD");
  }

   next_step() {
     console.log("next_step")
     this.step1Target.classList.add("d-none")
     this.step2Target.classList.remove("d-none")
     }
  }
