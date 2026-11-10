const expenseTable = document.querySelector(".expense-edit-table");
const totalDisplay = document.getElementById("expense-edit-total");
const emptyMessage = document.getElementById("expense-empty-message");
const saveButton = document.getElementById("expense-edit-save");
const moneyFormatter = new Intl.NumberFormat("ko-KR");
const editableFields = [];

const fieldLabels = {
    date: "지출일",
    category: "분류",
    description: "지출 내용",
    amount: "금액"
};

function updateExpenseTotal() {
    let total = 0;

    const rows = expenseTable.querySelectorAll("tbody tr");

    for (const row of rows) {
        const amountInput = row.querySelector('[data-field="amount"] input');

        if (!amountInput.validity.valid) {
            totalDisplay.textContent = "—";
            return;
        }

        total += amountInput.valueAsNumber;
    }

    totalDisplay.textContent = "₩ " + moneyFormatter.format(total);
}

expenseTable.querySelectorAll("[data-field]").forEach(function (cell) {
    const field = cell.dataset.field;
    const initialValue = cell.dataset.value != null
        ? cell.dataset.value
        : cell.textContent.trim();

    const display = document.createElement("button");
    const editor = document.createElement(
        field === "category" ? "select" : "input"
    );
    const error = document.createElement("p");

    display.type = "button";
    display.className = "expense-review-value";
    display.title = fieldLabels[field] + " 수정";

    editor.className = "expense-review-editor";
    editor.title = fieldLabels[field] + " 입력";
    editor.required = true;

    error.className = "expense-review-error";

    if (field === "category") {
        ["재료비", "임대료", "인건비", "공과금", "기타"].forEach(function (category) {
            editor.add(new Option(category, category));
        });
    } else if (field === "date") {
        editor.type = "date";
    } else if (field === "amount") {
        editor.type = "number";
        editor.min = "1";
        editor.step = "1";
    } else {
        editor.type = "text";
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
        error.textContent = field === "amount"
            ? "금액은 1원 이상의 정수로 입력해 주세요."
            : fieldLabels[field] + " 입력값을 확인해 주세요.";

        return valid;
    }

    function showValue() {
        if (!validate()) {
            return false;
        }

        cell.dataset.value = editor.value;

        display.textContent = field === "amount"
            ? "₩ " + moneyFormatter.format(editor.valueAsNumber)
            : editor.value;

        editor.hidden = true;
        display.hidden = false;

        return true;
    }

    display.addEventListener("click", function () {
        display.hidden = true;
        editor.hidden = false;
        editor.focus();

        if (field === "description" || field === "amount") {
            editor.select();
        }
    });

    editor.addEventListener("input", validate);
    editor.addEventListener("change", validate);
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

    editableFields.push({
        cell: cell,
        editor: editor,
        display: display,
        showValue: showValue
    });

    display.hidden = true;
    showValue();
});

updateExpenseTotal();

expenseTable.addEventListener("input", updateExpenseTotal);

expenseTable.querySelectorAll(".expense-delete-button").forEach(function (button) {
    button.addEventListener("click", function () {
        const row = button.closest("tr");
        const description = row.querySelector('[data-field="description"]').dataset.value;
        const confirmed = confirm(
            description + " 지출 내역을 정말 삭제하시겠습니까?"
        );

        if (!confirmed) {
            return;
        }

        row.remove();
        updateExpenseTotal();

        emptyMessage.hidden =
            expenseTable.querySelectorAll("tbody tr").length > 0;
    });

    button.disabled = false;
});

saveButton.addEventListener("click", function () {
    let firstInvalidEditor = null;

    editableFields.forEach(function (field) {
        if (!field.cell.isConnected) {
            return;
        }

        if (!field.showValue()) {
            field.display.hidden = true;
            field.editor.hidden = false;

            if (firstInvalidEditor === null) {
                firstInvalidEditor = field.editor;
            }
        }
    });

    if (firstInvalidEditor !== null) {
        firstInvalidEditor.focus();
        return;
    }

    alert("저장되었습니다.");
    window.location.href = "expense_list.jsp";
});

saveButton.disabled = false;
