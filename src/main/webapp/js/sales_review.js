const reviewTable = document.querySelector(".sales-review-table");
const checkButton = document.getElementById("sales-review-check");
const resultMessage = document.getElementById("sales-review-result");
const amountFormatter = new Intl.NumberFormat("ko-KR");
const unitPriceBasis = new URLSearchParams(window.location.search).get("amountBasis") === "unitPrice";
document.getElementById("sales-review-back").href =
    "mapping.jsp?amountBasis=" + (unitPriceBasis ? "unitPrice" : "lineTotal");
const fieldLabels = {
    date: "판매일자",
    product: "상품명",
    quantity: "수량",
    amount: unitPriceBasis ? "단가" : "금액"
};
const reviewFields = [];
const missingMessages = {
    date: "판매일자를 입력해 주세요.",
    product: "상품명을 입력해 주세요.",
    quantity: "수량을 입력해 주세요.",
    amount: unitPriceBasis ? "단가를 입력해 주세요." : "금액을 입력해 주세요."
};

document.getElementById("sales-amount-heading").textContent = unitPriceBasis ? "단가" : "품목 합계";
reviewTable.querySelectorAll(".sales-line-total").forEach(function (cell) {
    cell.hidden = !unitPriceBasis;
});
document.getElementById("sales-amount-guide").textContent = unitPriceBasis
    ? "단가 × 수량으로 품목 합계를 계산합니다."
    : "금액에는 품목 합계를 입력하세요. 수량을 바꿔도 품목 합계는 그대로 사용합니다.";

function updateLineTotal(row) {
    const quantity = row.querySelector('[data-edit="quantity"] input');
    const amount = row.querySelector('[data-edit="amount"] input');
    const total = row.querySelector(".sales-line-total");

    if (!quantity.validity.valid || !amount.validity.valid) {
        total.textContent = "확인 필요";
        return;
    }

    const lineTotal = unitPriceBasis
        ? amount.valueAsNumber * quantity.valueAsNumber
        : amount.valueAsNumber;
    total.textContent = "₩ " + amountFormatter.format(lineTotal);
}

reviewTable.querySelectorAll("[data-edit]").forEach(function (cell) {
    const field = cell.dataset.edit;
    const isNumber = field === "quantity" || field === "amount";
    const display = document.createElement("button");
    const editor = document.createElement("input");
    const error = document.createElement("p");

    display.type = "button";
    display.className = "sales-review-value";
    display.title = "클릭하여 " + fieldLabels[field] + " 수정";
    editor.type = isNumber ? "number" : field === "date" ? "datetime-local" : "text";
    editor.className = "sales-review-editor";
    editor.title = fieldLabels[field] + " 수정";
    editor.required = true;
    error.className = "sales-review-error";

    if (isNumber) {
        editor.min = "1";
        editor.step = "1";
        editor.placeholder = fieldLabels[field] + " 입력";
    }

    editor.value = field === "amount" && unitPriceBasis
        ? cell.dataset.unitPrice
        : cell.dataset.value ?? cell.textContent.trim();
    cell.replaceChildren(display, editor, error);

    function validate() {
        editor.setCustomValidity("");
        if (field === "product" && editor.value.trim() === "") {
            editor.setCustomValidity("상품명을 입력해 주세요.");
        }

        const valid = editor.validity.valid;
        editor.classList.toggle("is-invalid", !valid);
        error.hidden = valid;
        error.textContent = isNumber
            ? fieldLabels[field] + " 입력값은 1 이상의 정수로 입력해 주세요."
            : fieldLabels[field] + " 입력값을 확인해 주세요.";

        if (editor.value === "" && !editor.validity.badInput) {
            error.textContent = missingMessages[field];
        }

        return valid;
    }

    function showValue() {
        if (!validate()) {
            return false;
        }

        cell.dataset.value = editor.value;
        display.textContent = field === "amount"
            ? "₩ " + amountFormatter.format(editor.valueAsNumber)
            : editor.value.replace("T", " ");
        editor.hidden = true;
        display.hidden = false;
        return true;
    }

    display.addEventListener("click", function () {
        display.hidden = true;
        editor.hidden = false;
        editor.focus();
        if (field !== "date") {
            editor.select();
        }
    });
    editor.addEventListener("input", validate);
    editor.addEventListener("blur", showValue);
    editor.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            event.preventDefault();
            showValue();
            if (editor.hidden) {
                display.focus();
            }
        }
    });

    reviewFields.push({ editor: editor, display: display, showValue: showValue });
    display.hidden = true;
    showValue();
});

reviewTable.querySelectorAll("tbody tr").forEach(updateLineTotal);
reviewTable.addEventListener("input", function (event) {
    resultMessage.hidden = true;
    updateLineTotal(event.target.closest("tr"));
});

checkButton.addEventListener("click", function () {
    let firstInvalidEditor = null;

    reviewFields.forEach(function (field) {
        if (!field.showValue()) {
            field.display.hidden = true;
            field.editor.hidden = false;
            if (firstInvalidEditor === null) {
                firstInvalidEditor = field.editor;
            }
        }
    });

    if (firstInvalidEditor !== null) {
        resultMessage.textContent = "입력값을 확인해 주세요.";
        resultMessage.hidden = false;
        firstInvalidEditor.focus();
        return;
    }

    alert("저장되었습니다.");
    window.location.href = "sales_list.jsp";
});
