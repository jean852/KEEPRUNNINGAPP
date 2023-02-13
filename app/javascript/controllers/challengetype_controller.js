import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "challengetype", "length", "quantity"]
  // connect() {
  //   console.log("challengetypecontroller connected");
  // }

   km() {
     console.log("KM")
     this.challengetypeTarget.value="KM"
     this.quantityTarget.classList.remove("toggle")
     this.lengthTarget.classList.add("toggle")
   }
  sessions() {
     console.log("Sessions")
     this.challengetypeTarget.value="Sessions"
     this.quantityTarget.classList.add("toggle")
     this.lengthTarget.classList.remove("toggle")
     }
  }
