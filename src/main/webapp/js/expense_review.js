const amountFormatter = new Intl.NumberFormat("ko-KR");
const fieldLabels = {
    date: "지출일",
    category: "분류",
    description: "지출 내용",
    amount: "금액"
};
const reviewFields = [];
const checkButton = document.getElementById("expense-review-check");
const resultMessage = document.getElementById("expense-review-result");
const reviewTable = document.querySelector(".expense-review-table");


document.querySelectorAll(".expense-review-table [data-edit]").forEach(function (cell) {
    const field = cell.dataset.edit;
    const isAmount = field === "amount";
    const initialValue = isAmount ? cell.dataset.value : cell.textContent.trim();
    const display = document.createElement("button");
    const editor = document.createElement(field === "category" ? "select" : "input");
    const error = document.createElement("p");

    display.type = "button";
    display.className = "expense-review-value";
    display.title = "클릭하여 " + fieldLabels[field] + " 수정";
    editor.className = isAmount ? "expense-review-amount" : "expense-review-editor";
    editor.required = true;
    editor.title = fieldLabels[field] + " 수정";
    error.className = "expense-review-error";

    if (field === "category") {
        ["재료비", "임대료", "인건비", "공과금", "기타"].forEach(function (category) {
            editor.add(new Option(category, category));
        });
    } else {
        editor.type = { date: "date", description: "text", amount: "number" }[field];
    }

    if (isAmount) {
        editor.min = "1";
        editor.step = "1";
        editor.placeholder = "금액 입력";
    }

    editor.value = initialValue;
    cell.replaceChildren(display, editor, error);

    function validate() {
        editor.setCustomValidity("");
        if (field === "description" && editor.value.trim() === "") {
            editor.setCustomValidity("지출 내용을 입력해 주세요.");
        }
        const valid = editor.validity.valid;
        editor.classList.toggle("is-invalid", !valid);
        error.hidden = valid;
        error.textContent = isAmount
            ? "금액은 1원 이상의 정수로 입력해 주세요."
            : fieldLabels[field] + "을(를) 확인해 주세요.";
        if (isAmount && editor.value === "" && !editor.validity.badInput) {
            error.textContent = "금액을 입력해 주세요.";
        }
        return valid;
    }

    function showValue() {
        if (!validate()) {
            return false;
        }

        cell.dataset.value = editor.value;
        display.textContent = isAmount
            ? "₩ " + amountFormatter.format(editor.valueAsNumber)
            : editor.value;
        editor.hidden = true;
        display.hidden = false;

        return true;
    }

    display.addEventListener("click", function () {
        display.hidden = true;
        editor.hidden = false;
        editor.focus();
        if (field === "description" || isAmount) {
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

    reviewFields.push({
        editor: editor,
        display: display,
        showValue: showValue
    });

    display.hidden = true;
    showValue();
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

    resultMessage.hidden = false;

    if (firstInvalidEditor !== null) {
        resultMessage.textContent = "입력값을 확인해 주세요.";
        firstInvalidEditor.focus();
        return;
    }

    alert("저장되었습니다.");
    window.location.href = "expense_list.jsp";
});


reviewTable.addEventListener("input", function () {
    resultMessage.hidden = true;
});
