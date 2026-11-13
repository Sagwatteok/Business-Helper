const salesForm = document.getElementById("sales-form");
const productInput = document.getElementById("sales-product");

function validateProduct() {
    productInput.setCustomValidity(
        productInput.value.trim() === "" ? "상품명을 입력해 주세요." : ""
    );
}

productInput.addEventListener("input", validateProduct);
validateProduct();

salesForm.addEventListener("submit", function (event) {
    validateProduct();

    if (!salesForm.reportValidity()) {
        event.preventDefault();
    }
});