window.addEventListener('load', function(){

  const priceInput = document.getElementById("item-price");
  const tax_price = document.getElementById("add-tax-price");
  const benefit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;

  const tax = Math.ceil(inputValue * 0.1);
  const profit = Math.floor(inputValue * 0.9);

  tax_price.innerHTML = Math.ceil(inputValue * 0.1);
  benefit.innerHTML = Math.floor(inputValue * 0.9);
  })
})
