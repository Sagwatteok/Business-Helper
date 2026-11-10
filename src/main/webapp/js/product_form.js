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


//상품 유효성 검사
const productForm = document.getElementById("product-form");
const productNameInput = document.getElementById("product-name");

function validateProductName() {
    productNameInput.setCustomValidity(
        productNameInput.value.trim() === ""
            ? "상품명을 입력해 주세요."
            : ""
    );
}

productNameInput.addEventListener("input", validateProductName);
validateProductName();

productForm.addEventListener("submit", function (event) {
    event.preventDefault();
    validateProductName();

    if (!productForm.reportValidity()) {
        return;
    }

    alert("저장되었습니다.");
    window.location.href = "product_list.jsp";
});