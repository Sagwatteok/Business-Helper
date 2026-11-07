const requiredSelects = document.querySelectorAll(".mapping-select[required]");
const mappingNextButton = document.getElementById("mappingNextButton");
const amountBasis = document.getElementById("amount-basis");
const amountExample = document.getElementById("amount-example");

function checkRequiredMapping() { //필수 열 매핑 항목을 모두 선택했을 때만 버튼 활성화
    let isComplete = true;

    requiredSelects.forEach(function (select) {
        if (select.value === "") {
            isComplete = false;
        }
    });

    mappingNextButton.disabled = !isComplete;
}

requiredSelects.forEach(function (select) {
    select.addEventListener("change", checkRequiredMapping);
});

checkRequiredMapping();

function updateAmountExample() {
    if (amountBasis.value === "unitPrice") {
        amountExample.textContent = "예: 4,500원 × 2잔 = 9,000원";
    } else {
        amountExample.textContent = "품목 합계 열의 금액을 그대로 사용합니다.";
    }
}

amountBasis.addEventListener("change", updateAmountExample);
updateAmountExample();

mappingNextButton.addEventListener("click", function () {
    window.location.href = "validation.jsp?amountBasis=" + encodeURIComponent(amountBasis.value);
});
