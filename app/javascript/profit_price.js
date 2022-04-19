function profit_price(){
  const gains = 0.9;

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue * gains);

  })
}

window.addEventListener('load', profit_price);