import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "step1", "step2", "step2Running", "step3", "step3Distance", "step3Sessions", "step4" ]
  // connect() {
  //   console.log("stepcontroller connected")
  // }

   to_step2() {
     console.log("next_step")
     this.step1Target.classList.add("d-none")
     let type = document.querySelector("#challenge_activity_type")
     if (type.value == "RUNNING") {
     this.step2Target.classList.remove("d-none");
    } else {
      this.step2Target.classList.remove("d-none");
    }
   }
  to_step3() {
    console.log("next_step3")
      this.step2Target.classList.add("d-none");
      this.step3Target.classList.remove("d-none");
     let challengeType = document.querySelector("#challenge_challenge_type")
     if (challengeType.value == "KM") {
      this.step3DistanceTarget.classList.remove("d-none");
     } else {
       this.step3SessionsTarget.classList.remove("d-none");
     }
    }
  to_step4() {
    console.log("next_step4")
    this.step3DistanceTarget.classList.add("d-none")
    this.step3SessionsTarget.classList.add("d-none")
    this.step3Target.classList.add("d-none")
    this.step4Target.classList.remove("d-none")
    }
  }
