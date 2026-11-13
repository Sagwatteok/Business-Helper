const productTable = document.querySelector(".product-edit-table");
const emptyMessage = document.getElementById("product-empty-message");
const saveButton = document.getElementById("product-edit-save");
const productEditForm = document.getElementById("product-edit-form");
const submittedValues = document.createElement("div");
productEditForm.appendChild(submittedValues); //서버로 보낼 숨김 입력 요소들을 담는 공간
const editableFields = [];
const deletedProductIds = new Set();
const moneyFormatter = new Intl.NumberFormat("ko-KR"); //금액 콘마로 표기

const fieldLabels = {
    name: "상품명",
    category: "카테고리",
    price: "판매가",
    cost: "추정 원가",
    status: "판매 상태"
};

function updateMargin(row) { //예상 마진 계산
    const price = row.querySelector('[data-field="price"] input');
    const cost = row.querySelector('[data-field="cost"] input');
    const margin = row.querySelector(".product-edit-margin");

    if (!price.validity.valid || !cost.validity.valid) {
        margin.textContent = "—";
        return;
    }

    margin.textContent =
        "₩ " + moneyFormatter.format(price.valueAsNumber - cost.valueAsNumber);
}

productTable.querySelectorAll("[data-field]").forEach(function (cell) {
    const field = cell.dataset.field;
    const isMoney = field === "price" || field === "cost";
    const isSelect = field === "category" || field === "status";
    const initialValue = isMoney
        ? cell.dataset.value
        : cell.textContent.trim();

    const display = document.createElement("button");
    const editor = document.createElement(isSelect ? "select" : "input");
    const error = document.createElement("p");

    display.type = "button";
    display.className = "product-edit-value";
    display.title = fieldLabels[field] + " 수정";

    editor.className = "product-edit-editor";
    editor.title = fieldLabels[field] + " 입력";
    editor.required = true;

    error.className = "product-edit-error";

    if (isSelect) {
        const options = field === "category"
            ? ["커피", "음료", "디저트", "식사", "주류","굿즈", "기타"]
            : ["판매 중", "판매 중지"];

        options.forEach(function (option) {
            editor.add(new Option(option, option));
        });
    } else {
        editor.type = isMoney ? "number" : "text";
    }

    if (isMoney) {
        editor.min = "0";
        editor.step = "1";
    }

    editor.value = initialValue;
    cell.replaceChildren(display, editor, error);

    function validate() {
        editor.setCustomValidity("");

        if (field === "name" && editor.value.trim() === "") {
            editor.setCustomValidity("상품명을 입력해 주세요.");
        }

        const valid = editor.validity.valid;

        editor.classList.toggle("is-invalid", !valid);
        error.hidden = valid;
        error.textContent = isMoney
            ? "금액은 0 이상의 정수로 입력해 주세요."
            : fieldLabels[field] + " 입력값을 확인해 주세요.";

        return valid;
    }

    function showValue() {
        if (!validate()) {
            return false;
        }

        cell.dataset.value = editor.value;

        display.textContent = isMoney
            ? "₩ " + moneyFormatter.format(editor.valueAsNumber)
            : editor.value;

        if (field === "status") {
            cell.classList.toggle(
                "product-status-inactive",
                editor.value === "판매 중지"
            );
        }

        editor.hidden = true;
        display.hidden = false;
        return true;
    }

    display.addEventListener("click", function () {
        display.hidden = true;
        editor.hidden = false;
        editor.focus();

        if (!isSelect) {
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

productTable.querySelectorAll("tbody tr").forEach(updateMargin);

emptyMessage.hidden = productTable.querySelectorAll("tbody tr").length > 0;

productTable.addEventListener("input", function (event) {
    updateMargin(event.target.closest("tr"));
});

productTable.querySelectorAll(".product-delete-button").forEach(function (button) {
    button.addEventListener("click", function () {
        const row = button.closest("tr");
        const productName = row.querySelector('[data-field="name"]').dataset.value;
        const confirmed = confirm( //브라우저가 제공하는 확인창
            productName + " 상품을 정말 삭제하시겠습니까?"
        );

        if (!confirmed) {
            return;
        }

		deletedProductIds.add(row.dataset.productId);
		row.remove();
        emptyMessage.hidden = productTable.querySelectorAll("tbody tr").length > 0;
    });
});

function addEditValue(name, value) {
    const input = document.createElement("input");

    input.type = "hidden";
    input.name = name;
    input.value = value;

    submittedValues.appendChild(input);
}

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

	//데이터 수정
	submittedValues.replaceChildren();

	productTable.querySelectorAll("tbody tr").forEach(function (row) {
	    const productId = row.dataset.productId;
	    const productName = row.querySelector('[data-field="name"]').dataset.value;
	    const category = row.querySelector('[data-field="category"]').dataset.value;
	    const salePrice = row.querySelector('[data-field="price"]').dataset.value;
	    const estimatedCost = row.querySelector('[data-field="cost"]').dataset.value;
	    const statusText = row.querySelector('[data-field="status"]').dataset.value;
	    const saleStatus = statusText === "판매 중" ? "active" : "inactive";

	    addEditValue("productId", productId);
	    addEditValue("productName", productName);
	    addEditValue("category", category);
	    addEditValue("salePrice", salePrice);
	    addEditValue("estimatedCost", estimatedCost);
	    addEditValue("saleStatus", saleStatus);
	});

	deletedProductIds.forEach(function (productId) {
	    addEditValue("deletedProductId", productId);
	});
	productEditForm.requestSubmit();
});
