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

//예상 마진이 음수일 때 전송을 잠시 막고 사용자가 확인하면 등록
//경고창과 버튼 가져오기
const marginWarning = document.getElementById("margin-warning");
const marginWarningMessage = document.getElementById("margin-warning-message");
const productSubmit = document.getElementById("product-submit");
const confirmNegativeMargin = document.getElementById("confirm-negative-margin");
const cancelNegativeMargin = document.getElementById("cancel-negative-margin");

//사용자가 확인했는지 기억
let negativeMarginConfirmed = false;

//경고와 확인 상태 초기화
function resetMarginWarning() {
    negativeMarginConfirmed = false;
    marginWarning.hidden = true;
    productSubmit.disabled = false;
    confirmNegativeMargin.disabled = false;
}

productForm.addEventListener("input", resetMarginWarning);
productForm.addEventListener("change", resetMarginWarning);

productForm.addEventListener("submit", function (event) {
    validateProductName();

    if (!productForm.reportValidity()) {
        event.preventDefault();
        resetMarginWarning();
        return;
    }

    const margin = salePrice.valueAsNumber - estimatedCost.valueAsNumber; //마진 계산

    if (margin < 0 && !negativeMarginConfirmed) {
        event.preventDefault();

        marginWarningMessage.textContent =
            "예상 마진이 " + margin.toLocaleString("ko-KR") +
            "원입니다. 추정 원가가 판매가보다 높습니다. " +
            "그래도 등록하시겠습니까?";

        marginWarning.hidden = false;
        productSubmit.disabled = true;
        confirmNegativeMargin.focus();
        return;
    }

    confirmNegativeMargin.disabled = true;
});

//‘그래도 등록’을 눌렀을 때
confirmNegativeMargin.addEventListener("click", function () {
    validateProductName();

    if (!productForm.reportValidity()) {
        resetMarginWarning();
        return;
    }

    negativeMarginConfirmed = true;
    try {
        productForm.requestSubmit();
    } finally {
        negativeMarginConfirmed = false;
    }
});

cancelNegativeMargin.addEventListener("click", function () {
    resetMarginWarning();
    salePrice.focus();
});