import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'count' ];

  refresh() {
    fetch(window.location.href, {
      headers : {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then((data) => {
        console.log(this.countTarget.innerText);
        this.countTarget.innerText++;
      });
  }
}
