import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "activity"]
  connect() {
    console.log("activitycontroller");
  }

   running() {
     console.log("running")
     this.activityTarget.value="RUNNING"
   }
  cycling() {
     console.log("cycling")
     this.activityTarget.value="CYCLING"
     }
  }
