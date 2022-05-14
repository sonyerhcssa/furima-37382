window.addEventListener('load', () => {
  const commission = 0.1;
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * commission);

    const profit_price = document.getElementById("profit");
    profit_price.innerHTML = inputValue - addTaxDom.innerHTML;
  })
});