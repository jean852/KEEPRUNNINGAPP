import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "step1", "step2", "step3", "step4" ]
  connect() {
    console.log("ERddddD");
  }

   to_step2() {
     console.log("next_step")
     this.step1Target.classList.add("d-none")
     this.step2Target.classList.remove("d-none")
   }
  to_step3() {
    console.log("next_step3")
    this.step2Target.classList.add("d-none")
    this.step3Target.classList.remove("d-none")
    }
  to_step4() {
    console.log("next_step4")
    this.step3Target.classList.add("d-none")
    this.step4Target.classList.remove("d-none")
    }
  }
