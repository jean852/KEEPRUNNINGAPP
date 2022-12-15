import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "challengetype", "length", "quantity"]
  connect() {
    console.log("challengetypecontroller");
  }

   km() {
     console.log("KM")
     this.challengetypeTarget.value="KM"
     this.quantityTarget.classList.remove("toggle")
     this.lengthTarget.classList.add("toggle")
   }
  distance() {
     console.log("Distance")
     this.challengetypeTarget.value="Distance"
     this.quantityTarget.classList.add("toggle")
     this.lengthTarget.classList.remove("toggle")
     }
  }
