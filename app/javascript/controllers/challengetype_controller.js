import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "challengetype"]
  connect() {
    console.log("challengetypecontroller");
  }

   km() {
     console.log("KM")
     this.challengetypeTarget.value="KM"
   }
  distance() {
     console.log("Distance")
     this.challengetypeTarget.value="Distance"
     }
  }
