const expenseForm = document.getElementById("expense-form");
const descriptionInput = document.getElementById("expense-description");

function validateDescription() {
    descriptionInput.setCustomValidity(
        descriptionInput.value.trim() === ""
            ? "지출 내용을 입력해 주세요."
            : ""
    );
}

descriptionInput.addEventListener("input", validateDescription);
validateDescription();

expenseForm.addEventListener("submit", function (event) {
    validateDescription();

    if (!expenseForm.reportValidity()) {
        event.preventDefault();
    }
});