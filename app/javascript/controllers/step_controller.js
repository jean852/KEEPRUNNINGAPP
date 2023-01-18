import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "step1", "step2Cycling", "step2Running", "step3Distance", "step3Sessions", "step4" ]
  connect() {
    console.log("ERddddD");
  }

   to_step2() {
     console.log("next_step")
     this.step1Target.classList.add("d-none")
     let type = document.querySelector("#challenge_activity_type")
     if (type.value == "RUNNING") {
     this.step2RunningTarget.classList.remove("d-none");
    } else {
      this.step2CyclingTarget.classList.remove("d-none");
    }
   }
  to_step3() {
    console.log("next_step3")
      this.step2RunningTarget.classList.add("d-none");
       this.step2CyclingTarget.classList.add("d-none");
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
    this.step4Target.classList.remove("d-none")
    }
  }
