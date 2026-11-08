const salesTable = document.querySelector(".sales-edit-table");
const totalDisplay = document.getElementById("sales-edit-total");
const emptyMessage = document.getElementById("sales-empty-message");
const saveButton = document.getElementById("sales-edit-save");
const moneyFormatter = new Intl.NumberFormat("ko-KR");
const editableFields = [];

const fieldLabels = {
    date: "판매일자",
    product: "상품명",
    quantity: "수량",
    amount: "품목 합계",
    channel: "주문 경로"
};

function updateSalesTotal() {
    let total = 0;

    const rows = salesTable.querySelectorAll("tbody tr");

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

salesTable.querySelectorAll("[data-field]").forEach(function (cell) {
    const field = cell.dataset.field;
    const isNumber = field === "quantity" || field === "amount";
    const initialValue = cell.dataset.value ?? cell.textContent.trim();

    const display = document.createElement("button");
    const editor = document.createElement("input");
    const error = document.createElement("p");

    display.type = "button";
    display.className = "sales-edit-value";
    display.title = fieldLabels[field] + " 수정";

    editor.className = "sales-edit-editor";
    editor.title = fieldLabels[field] + " 입력";
    editor.required = field !== "channel";

    error.className = "sales-edit-error";

    if (isNumber) {
        editor.type = "number";
        editor.min = "1";
        editor.step = "1";
    } else if (field === "date") {
        editor.type = "datetime-local";
    } else {
        editor.type = "text";
    }

    editor.value = initialValue;
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

        return valid;
    }

    function showValue() {
        if (!validate()) {
            return false;
        }

        cell.dataset.value = editor.value;

        if (field === "amount") {
            display.textContent =
                "₩ " + moneyFormatter.format(editor.valueAsNumber);
        } else if (field === "channel" && editor.value.trim() === "") {
            display.textContent = "—";
        } else if (field === "date") {
            display.textContent = editor.value.replace("T", " ");
        } else {
            display.textContent = editor.value;
        }

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

    editableFields.push({
        cell: cell,
        editor: editor,
        display: display,
        showValue: showValue
    });

    display.hidden = true;
    showValue();
});

updateSalesTotal();

salesTable.addEventListener("input", updateSalesTotal);

salesTable.querySelectorAll(".sales-delete-button").forEach(function (button) {
    button.addEventListener("click", function () {
        const row = button.closest("tr");
        const productName = row.querySelector('[data-field="product"]').dataset.value;
        const confirmed = confirm(
            productName + " 매출 내역을 정말 삭제하시겠습니까?"
        );

        if (!confirmed) {
            return;
        }

        row.remove();
        updateSalesTotal();

        emptyMessage.hidden =
            salesTable.querySelectorAll("tbody tr").length > 0;
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
    window.location.href = "sales_list.jsp";
});

saveButton.disabled = false;
