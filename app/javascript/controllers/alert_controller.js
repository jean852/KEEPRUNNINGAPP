import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
// If you cannot see the console log, try removing assets with rails assets:clobber
export default class extends Controller {
  static targets = [ "clickable" ]

  // connect() {
  //   console.log("alertcontroller connected", this.element)
  // }

  display() {
    alert("🚨 When connecting with Strava, please make sure all 3 boxes to allow data when on window 'Authorize KeepRunning to connect to Strava' are checked. If not, challenges will not be able to be synced 🚨")
  }
}
