const salePrice = document.getElementById("sale-price");
const estimatedCost = document.getElementById("estimated-cost");
const estimatedMargin = document.getElementById("estimated-margin");

function updateEstimatedMargin() { //예상 마진 계산
    if (!salePrice.validity.valid || !estimatedCost.validity.valid) {
        estimatedMargin.textContent = "—";
        return;
    }

    const margin = salePrice.valueAsNumber - estimatedCost.valueAsNumber;
    estimatedMargin.textContent = margin.toLocaleString("ko-KR") + "원";
}

salePrice.addEventListener("input", updateEstimatedMargin);
estimatedCost.addEventListener("input", updateEstimatedMargin);
updateEstimatedMargin();