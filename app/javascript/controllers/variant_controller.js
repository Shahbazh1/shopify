import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("Variant controller connected")
  }

  add() {
    console.log("Add method called")
    const row = document.createElement("div")

    row.className = "variant-row"
    row.style.display = "grid"
    row.style.gridTemplateColumns = "1fr 1fr 1fr 1fr auto"
    row.style.gap = "8px"
    row.style.marginTop = "10px"

    row.innerHTML = `
      <input type="text" name="variants[][size]" placeholder="Size (M, L)">
      <input type="text" name="variants[][color]" placeholder="Color">
      <input type="number" name="variants[][quantity]" placeholder="Qty">
      <input type="number" name="variants[][price]" placeholder="Price">
      <button type="button" class="remove-btn">✖</button>
    `

    this.containerTarget.appendChild(row)

    // remove handler
    row.querySelector(".remove-btn").addEventListener("click", () => {
      row.remove()
    })
  }
}