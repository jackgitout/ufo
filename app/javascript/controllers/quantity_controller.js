import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'input', 'count' ];

  refresh(event) {
    event.preventDefault();
    console.log(event);
    let amountLeft = parseInt(this.countTarget.dataset.amountLeft);
    let amountInput = parseInt(this.inputTarget.value);
    if (amountLeft > amountInput) {
      amountLeft = amountLeft - amountInput;
      this.countTarget.innerText = `(Quantity left: ${amountLeft})`;
      this.countTarget.dataset.amountLeft = amountLeft
    } else {
      alert('Oops Veggies out of stock');
    }
    // console.log("added to cart");
  }
}
