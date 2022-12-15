import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "activity", "cycling", "running"]
  connect() {
    console.log("activitycontroller");
  }

   running() {
     console.log("running")
     this.activityTarget.value="RUNNING"
     this.cyclingTarget.classList.remove("toggle")
     this.runningTarget.classList.add("toggle")
   }
  cycling() {
     console.log("cycling")
     this.activityTarget.value="CYCLING"
     this.cyclingTarget.classList.add("toggle")
     this.runningTarget.classList.remove("toggle")
     }
  }
